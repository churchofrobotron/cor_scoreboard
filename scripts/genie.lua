function copyLib()
end

solution "cor_scoreboard"
  configurations {
    "Debug",
    "Release",
  }

  ROOT_DIR = path.getabsolute("../")
  THIRD_PARTY_DIR = path.getabsolute("../thirdparty")
  BX_DIR = path.join(THIRD_PARTY_DIR, "bx")
  BIMG_DIR = path.join(THIRD_PARTY_DIR, "bimg")
  BGFX_DIR = path.join(THIRD_PARTY_DIR, "bgfx")
  EXAMPLE_FRAMEWORK_DIR = path.join(BGFX_DIR, "examples")
  BUILD_DIR = "../build/make"

  language "C++"

  dofile(path.join(BX_DIR, "scripts/toolchain.lua"))
  if not toolchain(BUILD_DIR, THIRD_PARTY_DIR) then
    return -- no action specified
  end

  location(BUILD_DIR)
  targetdir("../build/bin")

	configuration { "osx" }
		linkoptions {
			"-framework Cocoa",
			"-framework QuartzCore",
			"-framework OpenGL",
			"-weak_framework Metal",
		}

  project("cor_scoreboard")
    uuid(os.uuid("cor_scoreboard"))
    kind "WindowedApp"

  files {
    path.join(ROOT_DIR, "src", "**.cpp"),
    path.join(ROOT_DIR, "src", "**.h")
  }

  includedirs {
    path.join(BX_DIR, "include"),
    path.join(BIMG_DIR, "include"),
    path.join(BGFX_DIR, "include"),
    path.join(BGFX_DIR, "3rdparty"),
    path.join(EXAMPLE_FRAMEWORK_DIR, "common"),
  }

  removefiles {
    path.join(ROOT_DIR, "src", "**.bin.h"),
  }

  defines {
    "ENTRY_CONFIG_IMPLEMENT_MAIN=1",
  }

  links {
    "bx",
    "bimg",
    "bimg_decode",
    "bgfx",
		"example-common",
		-- "example-glue",
  }

  dofile(path.join(BGFX_DIR, "scripts/bgfx.lua"))
  group "libs"
  bgfxProject("", "StaticLib", {})
  dofile(path.join(BX_DIR, "scripts/bx.lua"))
  dofile(path.join(BIMG_DIR, "scripts/bimg.lua"))
  dofile(path.join(BIMG_DIR, "scripts/bimg_decode.lua"))
  dofile(path.join(BGFX_DIR, "scripts/example-common.lua"))

  configuration {}
  defines {
    "ENTRY_DEFAULT_WIDTH=768",
    "ENTRY_DEFAULT_HEIGHT=668"
  }
