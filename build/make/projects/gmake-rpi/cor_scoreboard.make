# GNU Make project makefile autogenerated by GENie
ifndef config
  config=debug
endif

ifndef verbose
  SILENT = @
endif

SHELLTYPE := msdos
ifeq (,$(ComSpec)$(COMSPEC))
  SHELLTYPE := posix
endif
ifeq (/bin,$(findstring /bin,$(SHELL)))
  SHELLTYPE := posix
endif
ifeq (/bin,$(findstring /bin,$(MAKESHELL)))
  SHELLTYPE := posix
endif

ifeq (posix,$(SHELLTYPE))
  MKDIR = $(SILENT) mkdir -p "$(1)"
  COPY  = $(SILENT) cp -fR "$(1)" "$(2)"
  RM    = $(SILENT) rm -f "$(1)"
else
  MKDIR = $(SILENT) mkdir "$(subst /,\\,$(1))" 2> nul || exit 0
  COPY  = $(SILENT) copy /Y "$(subst /,\\,$(1))" "$(subst /,\\,$(2))"
  RM    = $(SILENT) del /F "$(subst /,\\,$(1))" 2> nul || exit 0
endif

CC  = gcc
CXX = g++
AR  = ar

ifndef RESCOMP
  ifdef WINDRES
    RESCOMP = $(WINDRES)
  else
    RESCOMP = windres
  endif
endif

MAKEFILE = cor_scoreboard.make

ifeq ($(config),debug)
  OBJDIR              = ../../rpi/obj/Debug/cor_scoreboard
  TARGETDIR           = ../../rpi/bin/cor_scoreboard.app/Contents/MacOS
  TARGET              = $(TARGETDIR)/cor_scoreboardDebug
  DEFINES            += -D__STDC_LIMIT_MACROS -D__STDC_FORMAT_MACROS -D__STDC_CONSTANT_MACROS -D_DEBUG -D__VCCOREVER__=0x04000000 -D__STDC_VERSION__=199901L -DENTRY_CONFIG_IMPLEMENT_MAIN=1
  INCLUDES           += -I"../../../../../../../../../../opt/vc/include" -I"../../../../../../../../../../opt/vc/include/interface/vcos/pthreads" -I"../../../../../../../../../../opt/vc/include/interface/vmcs_host/linux" -I"../../../../thirdparty/bx/include" -I"../../../../thirdparty/bimg/include" -I"../../../../thirdparty/bgfx/include" -I"../../../../thirdparty/bgfx/3rdparty" -I"../../../../thirdparty/bgfx/examples/common"
  ALL_CPPFLAGS       += $(CPPFLAGS) -MMD -MP -MP $(DEFINES) $(INCLUDES)
  ALL_ASMFLAGS       += $(ASMFLAGS) $(CFLAGS) $(ALL_CPPFLAGS) $(ARCH) -Wall -Wextra -ffast-math -fomit-frame-pointer -g -Wunused-value -Wundef
  ALL_CFLAGS         += $(CFLAGS) $(ALL_CPPFLAGS) $(ARCH) -Wall -Wextra -ffast-math -fomit-frame-pointer -g -Wunused-value -Wundef
  ALL_CXXFLAGS       += $(CXXFLAGS) $(CFLAGS) $(ALL_CPPFLAGS) $(ARCH) -Wall -Wextra -ffast-math -fomit-frame-pointer -g -std=c++14 -fno-rtti -fno-exceptions -Wunused-value -Wundef
  ALL_OBJCFLAGS      += $(CFLAGS) $(ALL_CPPFLAGS) $(ARCH) -Wall -Wextra -ffast-math -fomit-frame-pointer -g -Wunused-value -Wundef
  ALL_OBJCPPFLAGS    += $(CXXFLAGS) $(CFLAGS) $(ALL_CPPFLAGS) $(ARCH) -Wall -Wextra -ffast-math -fomit-frame-pointer -g -std=c++14 -fno-rtti -fno-exceptions -Wunused-value -Wundef
  ALL_RESFLAGS       += $(RESFLAGS) $(DEFINES) $(INCLUDES)
  ALL_LDFLAGS        += $(LDFLAGS) -L"../../../../thirdparty/lib/rpi" -L"../../../../../../../../../../opt/vc/lib" -L"." -L"../../rpi/bin" -Wl,--gc-sections
  LIBDEPS            += ../../rpi/bin/libbxDebug.a ../../rpi/bin/libbimgDebug.a ../../rpi/bin/libbimg_decodeDebug.a ../../rpi/bin/libbgfxDebug.a ../../rpi/bin/libexample-commonDebug.a
  LDDEPS             += ../../rpi/bin/libbxDebug.a ../../rpi/bin/libbimgDebug.a ../../rpi/bin/libbimg_decodeDebug.a ../../rpi/bin/libbgfxDebug.a ../../rpi/bin/libexample-commonDebug.a
  LIBS               += $(LDDEPS) -lrt -ldl -lX11 -lbrcmGLESv2 -lbrcmEGL -lbcm_host -lvcos -lvchiq_arm -lpthread
  EXTERNAL_LIBS      +=
  LINKOBJS            = $(OBJECTS)
  LINKCMD             = $(CXX) -o $(TARGET) $(LINKOBJS) $(RESOURCES) $(ARCH) $(ALL_LDFLAGS) $(LIBS)
  OBJECTS := \
	$(OBJDIR)/src/font.o \

  define PREBUILDCMDS
  endef
  define PRELINKCMDS
  endef
  define POSTBUILDCMDS
  endef
endif

ifeq ($(config),release)
  OBJDIR              = ../../rpi/obj/Release/cor_scoreboard
  TARGETDIR           = ../../rpi/bin/cor_scoreboard.app/Contents/MacOS
  TARGET              = $(TARGETDIR)/cor_scoreboardRelease
  DEFINES            += -D__STDC_LIMIT_MACROS -D__STDC_FORMAT_MACROS -D__STDC_CONSTANT_MACROS -DNDEBUG -D__VCCOREVER__=0x04000000 -D__STDC_VERSION__=199901L -DENTRY_CONFIG_IMPLEMENT_MAIN=1
  INCLUDES           += -I"../../../../../../../../../../opt/vc/include" -I"../../../../../../../../../../opt/vc/include/interface/vcos/pthreads" -I"../../../../../../../../../../opt/vc/include/interface/vmcs_host/linux" -I"../../../../thirdparty/bx/include" -I"../../../../thirdparty/bimg/include" -I"../../../../thirdparty/bgfx/include" -I"../../../../thirdparty/bgfx/3rdparty" -I"../../../../thirdparty/bgfx/examples/common"
  ALL_CPPFLAGS       += $(CPPFLAGS) -MMD -MP -MP $(DEFINES) $(INCLUDES)
  ALL_ASMFLAGS       += $(ASMFLAGS) $(CFLAGS) $(ALL_CPPFLAGS) $(ARCH) -Wall -Wextra -ffast-math -fomit-frame-pointer -g -O3 -Wunused-value -Wundef
  ALL_CFLAGS         += $(CFLAGS) $(ALL_CPPFLAGS) $(ARCH) -Wall -Wextra -ffast-math -fomit-frame-pointer -g -O3 -Wunused-value -Wundef
  ALL_CXXFLAGS       += $(CXXFLAGS) $(CFLAGS) $(ALL_CPPFLAGS) $(ARCH) -Wall -Wextra -ffast-math -fomit-frame-pointer -g -O3 -std=c++14 -fno-rtti -fno-exceptions -Wunused-value -Wundef
  ALL_OBJCFLAGS      += $(CFLAGS) $(ALL_CPPFLAGS) $(ARCH) -Wall -Wextra -ffast-math -fomit-frame-pointer -g -O3 -Wunused-value -Wundef
  ALL_OBJCPPFLAGS    += $(CXXFLAGS) $(CFLAGS) $(ALL_CPPFLAGS) $(ARCH) -Wall -Wextra -ffast-math -fomit-frame-pointer -g -O3 -std=c++14 -fno-rtti -fno-exceptions -Wunused-value -Wundef
  ALL_RESFLAGS       += $(RESFLAGS) $(DEFINES) $(INCLUDES)
  ALL_LDFLAGS        += $(LDFLAGS) -L"../../../../thirdparty/lib/rpi" -L"../../../../../../../../../../opt/vc/lib" -L"." -L"../../rpi/bin" -Wl,--gc-sections
  LIBDEPS            += ../../rpi/bin/libbxRelease.a ../../rpi/bin/libbimgRelease.a ../../rpi/bin/libbimg_decodeRelease.a ../../rpi/bin/libbgfxRelease.a ../../rpi/bin/libexample-commonRelease.a
  LDDEPS             += ../../rpi/bin/libbxRelease.a ../../rpi/bin/libbimgRelease.a ../../rpi/bin/libbimg_decodeRelease.a ../../rpi/bin/libbgfxRelease.a ../../rpi/bin/libexample-commonRelease.a
  LIBS               += $(LDDEPS) -lrt -ldl -lX11 -lbrcmGLESv2 -lbrcmEGL -lbcm_host -lvcos -lvchiq_arm -lpthread
  EXTERNAL_LIBS      +=
  LINKOBJS            = $(OBJECTS)
  LINKCMD             = $(CXX) -o $(TARGET) $(LINKOBJS) $(RESOURCES) $(ARCH) $(ALL_LDFLAGS) $(LIBS)
  OBJECTS := \
	$(OBJDIR)/src/font.o \

  define PREBUILDCMDS
  endef
  define PRELINKCMDS
  endef
  define POSTBUILDCMDS
  endef
endif

OBJDIRS := \
	$(OBJDIR) \
	$(OBJDIR)/src \

RESOURCES := \

.PHONY: clean prebuild prelink

all: $(OBJDIRS) $(TARGETDIR) prebuild prelink $(TARGET) $(dir $(TARGETDIR))PkgInfo $(dir $(TARGETDIR))Info.plist
	@:

$(TARGET): $(GCH) $(OBJECTS) $(LIBDEPS) $(EXTERNAL_LIBS) $(RESOURCES) | $(TARGETDIR) $(OBJDIRS)
	@echo Linking cor_scoreboard
	$(SILENT) $(LINKCMD)
	$(POSTBUILDCMDS)

$(TARGETDIR):
	@echo Creating $(TARGETDIR)
	-$(call MKDIR,$(TARGETDIR))

$(OBJDIRS):
	@echo Creating $(@)
	-$(call MKDIR,$@)

$(dir $(TARGETDIR))PkgInfo:
$(dir $(TARGETDIR))Info.plist:

clean:
	@echo Cleaning cor_scoreboard
ifeq (posix,$(SHELLTYPE))
	$(SILENT) rm -f  $(TARGET)
	$(SILENT) rm -rf $(OBJDIR)
else
	$(SILENT) if exist $(subst /,\\,$(TARGET)) del $(subst /,\\,$(TARGET))
	$(SILENT) if exist $(subst /,\\,$(OBJDIR)) rmdir /s /q $(subst /,\\,$(OBJDIR))
endif

prebuild:
	$(PREBUILDCMDS)

prelink:
	$(PRELINKCMDS)

ifneq (,$(PCH))
$(GCH): $(PCH) $(MAKEFILE) | $(OBJDIR)
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(ALL_CXXFLAGS) -x c++-header $(DEFINES) $(INCLUDES) -o "$@" -c "$<"

$(GCH_OBJC): $(PCH) $(MAKEFILE) | $(OBJDIR)
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(ALL_OBJCPPFLAGS) -x objective-c++-header $(DEFINES) $(INCLUDES) -o "$@" -c "$<"
endif

$(OBJDIR)/src/font.o: ../../../../src/font.cpp $(GCH) $(MAKEFILE) | $(OBJDIR)/src
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(ALL_CXXFLAGS) $(FORCE_INCLUDE) -o "$@" -c "$<"

-include $(OBJECTS:%.o=%.d)
ifneq (,$(PCH))
  -include $(OBJDIR)/$(notdir $(PCH)).d
  -include $(OBJDIR)/$(notdir $(PCH))_objc.d
endif