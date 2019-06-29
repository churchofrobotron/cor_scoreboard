#include <algorithm>
#include <dirent.h>
#include <functional>
#include <stdio.h>
#include <string>
#include <vector>

#include "bgfx_utils.h"
#include "common.h"

#include <bx/file.h>
#include <bx/math.h>
#include <bx/string.h>
#include <bx/timer.h>

#include "entry/input.h"
#include "font/font_manager.h"
#include "font/text_buffer_manager.h"

#include <wchar.h>

#include "imgui/imgui.h"

#include "font_utils.h"
#include "gif_load.h"
#include "gif_utils.h"
#include "string_utils.h"

namespace {

struct PosTexcoordVertex {
  float m_x;
  float m_y;
  float m_z;
  float m_u;
  float m_v;
  float m_w;

  static void init() {
    ms_decl.begin()
        .add(bgfx::Attrib::Position, 3, bgfx::AttribType::Float)
        .add(bgfx::Attrib::TexCoord0, 3, bgfx::AttribType::Float)
        .end();
  };

  static bgfx::VertexDecl ms_decl;
};

bgfx::VertexDecl PosTexcoordVertex::ms_decl;

const float faceHeight = 66.6;
const float faceWidth = faceHeight * 1.6;
const float textHeight = 50.0;
const float headerHeight = 40.0;
const float groupWidth = faceWidth * 2.55;
const float columnSize = 1.05;
const float leftMarg = 0.0;

static PosTexcoordVertex s_planeVertices[] = {
    {00.0f, faceHeight, 0.0f, 0.0, 1.0, 0.0f},
    {faceWidth, faceHeight, 0.0f, 1.0f, 1.0f, 0.0f},
    {00.0f, 00.0f, 0.0f, 0.0f, 0.0f, 0.0f},
    {faceWidth, 00.0f, 0.0f, 1.0f, 0.0f, 0.0f},
};

static const uint16_t s_planeIndices[] = {
    0, 1, 2, // 0
    1, 3, 2,
};

struct DeathFace {
  std::string initials;
  int score;
  std::string date;
  std::string location;
  std::string filename;

  int num_frames;

  TextBufferManager *bufferManager = nullptr;
  bgfx::TextureHandle texture;
  TextBufferHandle m_text;
  bgfx::IndexBufferHandle m_ibh;
  bgfx::VertexBufferHandle m_vbh;

  void cleanup() {
    if (bufferManager) {
      bufferManager->destroyTextBuffer(m_text);
      bgfx::destroy(texture);
      bgfx::destroy(m_ibh);
      bgfx::destroy(m_vbh);
    }
  }
};

const size_t MAX_FACES = 10;
const size_t NUM_GROUPS = 3;

typedef std::function<bool(const DeathFace &a, const DeathFace &b)>
    GroupSortFunc;
typedef std::function<bool(const DeathFace &a)> GroupFilterFunc;

struct ScoreGroup {
  std::vector<DeathFace> faces;
  TextBufferHandle m_text;

  GroupSortFunc sortFunc;
  GroupFilterFunc filterFunc;
};

class Scoreboard : public entry::AppI {
public:
  Scoreboard(const char *_name, const char *_description)
      : entry::AppI(_name, _description) {}

  void init(int32_t _argc, const char *const *_argv, uint32_t _width,
            uint32_t _height) override {
    Args args(_argc, _argv);

    m_width = _width;
    m_height = _height;
    m_debug = BGFX_DEBUG_NONE;
    m_reset = BGFX_RESET_VSYNC;

    bgfx::Init init;
    init.type = args.m_type;
    init.vendorId = args.m_pciId;
    init.resolution.width = m_width;
    init.resolution.height = m_height;
    init.resolution.reset = m_reset;
    bgfx::init(init);

    // Enable debug text.
    bgfx::setDebug(m_debug);

    // Set view 0 clear state.
    bgfx::setViewClear(0, BGFX_CLEAR_COLOR | BGFX_CLEAR_DEPTH, 0x303030ff, 1.0f,
                       0);

    PosTexcoordVertex::init();

    // Create program from shaders.
    m_program = loadProgram("vs_gif", "fs_gif");

    // Init the text rendering system.
    m_fontManager = new FontManager(512);
    m_textBufferManager = new TextBufferManager(m_fontManager);

    m_fontRobotronTtf = loadTtf(m_fontManager, "font/ROBOTRON.ttf");
    m_fontRobotron =
        m_fontManager->createFontByPixelSize(m_fontRobotronTtf, 0, 24);
    m_fontManager->preloadGlyph(
        m_fontRobotron,
        L"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ.1234567890 :\n");

    s_texColor = bgfx::createUniform("s_texColor", bgfx::UniformType::Sampler);
    u_time = bgfx::createUniform("u_time", bgfx::UniformType::Vec4);

    m_timeOffset = bx::getHPCounter();

    GroupSortFunc sortByScore = [](const DeathFace &a, const DeathFace &b) {
      return a.score != b.score ? a.score > b.score : a.filename < b.filename;
    };
    GroupFilterFunc filterByEvent = [](const DeathFace &a) {
      return a.location == "AFRU";
    };
    GroupSortFunc sortByDate = [](const DeathFace &a, const DeathFace &b) {
      return a.date != b.date ? a.date > b.date : a.filename < b.filename;
    };

    initGroup(&m_scores[0], "Most Recent", sortByDate);
    initGroup(&m_scores[1], "Teardown 2019", sortByScore, filterByEvent);
    initGroup(&m_scores[2], "All Time", sortByScore);
    loadScores(true);
  }

  virtual int shutdown() override {

    for (int board = 0; board < 3; board++) {
      for (auto &face : m_scores[board].faces) {
        face.cleanup();
      }
      m_textBufferManager->destroyTextBuffer(m_scores[board].m_text);
    }

    bgfx::destroy(m_program);

    m_fontManager->destroyTtf(m_fontRobotronTtf);
    m_fontManager->destroyFont(m_fontRobotron);

    delete m_textBufferManager;
    delete m_fontManager;

    bgfx::destroy(s_texColor);
    bgfx::destroy(u_time);

    // Shutdown bgfx.
    bgfx::shutdown();

    return 0;
  }

  bool update() override {
    if (!entry::processEvents(m_width, m_height, m_debug, m_reset,
                              &m_mouseState)) {

      if (inputGetKeyState(entry::Key::KeyQ)) {
        return false;
      }

      // This dummy draw call is here to make sure that view 0 is cleared
      // if no other draw calls are submitted to view 0.
      bgfx::touch(0);

      int64_t now = bx::getHPCounter();
      const double freq = double(bx::getHPFrequency());

      const float curr_time = (now - m_timeOffset) / freq;
      static int lastFloor = 0;
      int thisFloor = (int)bx::floor(curr_time);
      if ((thisFloor != lastFloor) && (thisFloor % 1 == 0)) {
        printf("Checking for new scores.\n");
        loadScores(false);
        lastFloor = thisFloor;
      }

      // Use transient text to display debug information.
      const bx::Vec3 at = {0.0f, 0.0f, 0.0f};
      const bx::Vec3 eye = {0.0f, 0.0f, -1.0f};

      float view[16];
      bx::mtxLookAt(view, eye, at);

      const float centering = 0.5f;

      // Setup a top-left ortho matrix for screen space drawing.
      const bgfx::Caps *caps = bgfx::getCaps();
      {
        float ortho[16];
        bx::mtxOrtho(ortho, centering, m_width + centering,
                     m_height + centering, centering, 0.0f, 100.0f, 0.0f,
                     caps->homogeneousDepth);
        bgfx::setViewTransform(0, view, ortho);
        bgfx::setViewRect(0, 0, 0, uint16_t(m_width), uint16_t(m_height));
      }

      for (int i = 0; i < 3; i++) {
        renderScores(m_scores[i], curr_time, i * groupWidth);
      }

      // Advance to next frame. Rendering thread will be kicked to
      // process submitted rendering primitives.
      bgfx::frame();

      return true;
    }

    return false;
  }

  void renderScores(const ScoreGroup &group, float curr_time, float xoffset) {
    bgfx::setState(0 | BGFX_STATE_WRITE_RGB | BGFX_STATE_WRITE_A |
                   BGFX_STATE_WRITE_Z | BGFX_STATE_MSAA);

    float mtx[16];
    bx::mtxTranslate(mtx, xoffset + leftMarg * faceWidth, 0, 0);
    bgfx::setTransform(mtx);
    m_textBufferManager->submitTextBuffer(group.m_text, 0);

    // Set vertex and index buffer.
    for (int i = 0; i < group.faces.size(); i++) {
      bgfx::setVertexBuffer(0, group.faces[i].m_vbh);
      bgfx::setIndexBuffer(group.faces[i].m_ibh);

      const float initialHeight =
          (i / 2) * (faceHeight + textHeight) + headerHeight;
      const float xColumnOffset =
          (i % 2 == 0) ? leftMarg * faceWidth : faceWidth * columnSize;

      bx::mtxTranslate(mtx, xoffset + xColumnOffset, initialHeight, 0);
      bgfx::setTransform(mtx);

      bgfx::setTexture(0, s_texColor, group.faces[i].texture);

      float frames = (float)group.faces[i].num_frames == 0
                         ? 1.0
                         : group.faces[i].num_frames;
      const int frame = (int)(curr_time * 4) % (int)group.faces[i].num_frames;
      float time[] = {1.0f / frames, (float)frame / frames, 0.0f, 0.0f};
      bgfx::setUniform(u_time, time);

      // Submit primitive for rendering to view 0.
      bgfx::submit(0, m_program);

      bx::mtxTranslate(mtx, xoffset + xColumnOffset, initialHeight + faceHeight,
                       0);
      bgfx::setTransform(mtx);
      m_textBufferManager->submitTextBuffer(group.faces[i].m_text, 0);
    }
  }

  void initGroup(ScoreGroup *group, const std::string &groupName,
                 GroupSortFunc sortFunc, GroupFilterFunc filterFunc = nullptr) {
    group->m_text = m_textBufferManager->createTextBuffer(FONT_TYPE_ALPHA,
                                                          BufferType::Static);
    m_textBufferManager->appendText(group->m_text, m_fontRobotron,
                                    groupName.c_str());
    group->sortFunc = sortFunc;
    if (filterFunc != nullptr) {
      group->filterFunc = filterFunc;
    } else {
      group->filterFunc = [](const DeathFace &a) { return true; };
    }
    group->faces.reserve(MAX_FACES + 2);
  }

  void loadScores(bool initialLoad) {
    std::vector<DeathFace> ret;
    auto dirp = opendir("data/");
    if (dirp == nullptr) {
      printf("Bad directory, setup the data/ symlink!\n");
      exit(0);
    }
    struct dirent *dp;
    while ((dp = readdir(dirp)) != NULL) {
      std::string filename(dp->d_name);
      auto s = SplitString(filename, '_');
      if (s.size() == 4) {
        DeathFace face = {s[0], std::stoi(s[1]), s[2],
                          SplitString(s[3], '.')[0], filename};
        for (int i = 0; i < NUM_GROUPS; i++) {
          ScoreGroup *g = &m_scores[i];
          if (g->filterFunc(face)) {
            auto insert = std::lower_bound(g->faces.begin(), g->faces.end(),
                                           face, g->sortFunc);
            bool couldInsert =
                (g->faces.size() < MAX_FACES || insert != g->faces.end());
            bool isEqual = insert->filename == face.filename;
            if (couldInsert && !isEqual) {
              if (!initialLoad) {
                loadFace(&face);
              }
              g->faces.insert(insert, face);
              if (g->faces.size() > MAX_FACES) {
                g->faces.back().cleanup();
                g->faces.pop_back();
              }
            }
          }
        }
      }
    }
    closedir(dirp);
    if (initialLoad) {
      for (int i = 0; i < NUM_GROUPS; i++) {
        ScoreGroup *g = &m_scores[i];
        for (auto &f : g->faces) {
          loadFace(&f);
        }
      }
    }
  }

  void loadFace(DeathFace *face) {
    face->texture = loadGif("data/" + face->filename, &(face->num_frames));
    face->m_text = m_textBufferManager->createTextBuffer(FONT_TYPE_ALPHA,
                                                         BufferType::Static);
    m_textBufferManager->setPenPosition(face->m_text, 0.0f, 0.0f);
    m_textBufferManager->setTextColor(face->m_text, 0x00FFFFFF);
    m_textBufferManager->appendText(
        face->m_text, m_fontRobotron,
        (face->initials + "\n" + std::to_string(face->score)).c_str());
    face->m_vbh = bgfx::createVertexBuffer(
        bgfx::makeRef(s_planeVertices, sizeof(s_planeVertices)),
        PosTexcoordVertex::ms_decl);
    // Create static index buffer.
    face->m_ibh = bgfx::createIndexBuffer(
        bgfx::makeRef(s_planeIndices, sizeof(s_planeIndices)));
    face->bufferManager = m_textBufferManager;
  }

  entry::MouseState m_mouseState;

  uint32_t m_width;
  uint32_t m_height;
  uint32_t m_debug;
  uint32_t m_reset;

  bgfx::ProgramHandle m_program;

  FontManager *m_fontManager;
  TextBufferManager *m_textBufferManager;

  TrueTypeHandle m_fontRobotronTtf;
  FontHandle m_fontRobotron;

  bgfx::UniformHandle s_texColor;
  bgfx::UniformHandle u_time;

  int64_t m_timeOffset;

  ScoreGroup m_scores[NUM_GROUPS];
};

} // namespace

ENTRY_IMPLEMENT_MAIN(Scoreboard, "41-cor", "Church of Robotron Scoreboard");
