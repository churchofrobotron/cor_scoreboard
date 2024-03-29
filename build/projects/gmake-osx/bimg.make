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

MAKEFILE = bimg.make

ifeq ($(config),debug)
  OBJDIR              = obj/Debug/bimg
  TARGETDIR           = ../../../thirdparty/bimg/scripts
  TARGET              = $(TARGETDIR)/libbimgDebug.a
  DEFINES            += -D__STDC_LIMIT_MACROS -D__STDC_FORMAT_MACROS -D__STDC_CONSTANT_MACROS -D_DEBUG
  INCLUDES           += -I"../../../thirdparty/bx/include/compat/osx" -I"../../../thirdparty/bx/include" -I"../../../thirdparty/bimg/include" -I"../../../thirdparty/bimg/3rdparty/astc-codec" -I"../../../thirdparty/bimg/3rdparty/astc-codec/include"
  ALL_CPPFLAGS       += $(CPPFLAGS) -MMD -MP -MP $(DEFINES) $(INCLUDES)
  ALL_ASMFLAGS       += $(ASMFLAGS) $(CFLAGS) $(ALL_CPPFLAGS) $(ARCH) -Wall -Wextra -ffast-math -fomit-frame-pointer -g -Wshadow -Wfatal-errors -msse2 -Wunused-value -Wundef
  ALL_CFLAGS         += $(CFLAGS) $(ALL_CPPFLAGS) $(ARCH) -Wall -Wextra -ffast-math -fomit-frame-pointer -g -Wshadow -Wfatal-errors -msse2 -Wunused-value -Wundef
  ALL_CXXFLAGS       += $(CXXFLAGS) $(CFLAGS) $(ALL_CPPFLAGS) $(ARCH) -Wall -Wextra -ffast-math -fomit-frame-pointer -g -std=c++14 -fno-rtti -fno-exceptions -Wshadow -Wfatal-errors -msse2 -Wunused-value -Wundef
  ALL_OBJCFLAGS      += $(CFLAGS) $(ALL_CPPFLAGS) $(ARCH) -Wall -Wextra -ffast-math -fomit-frame-pointer -g -Wshadow -Wfatal-errors -msse2 -Wunused-value -Wundef
  ALL_OBJCPPFLAGS    += $(CXXFLAGS) $(CFLAGS) $(ALL_CPPFLAGS) $(ARCH) -Wall -Wextra -ffast-math -fomit-frame-pointer -g -std=c++14 -fno-rtti -fno-exceptions -Wshadow -Wfatal-errors -msse2 -Wunused-value -Wundef
  ALL_RESFLAGS       += $(RESFLAGS) $(DEFINES) $(INCLUDES)
  ALL_LDFLAGS        += $(LDFLAGS)
  LIBDEPS            +=
  LDDEPS             +=
  LIBS               += $(LDDEPS)
  EXTERNAL_LIBS      +=
  LINKOBJS            = $(OBJECTS)
  LINKCMD             = $(AR)  -rcs $(TARGET)
  OBJECTS := \
	$(OBJDIR)/thirdparty/bimg/3rdparty/astc-codec/src/decoder/astc_file.o \
	$(OBJDIR)/thirdparty/bimg/3rdparty/astc-codec/src/decoder/codec.o \
	$(OBJDIR)/thirdparty/bimg/3rdparty/astc-codec/src/decoder/endpoint_codec.o \
	$(OBJDIR)/thirdparty/bimg/3rdparty/astc-codec/src/decoder/footprint.o \
	$(OBJDIR)/thirdparty/bimg/3rdparty/astc-codec/src/decoder/integer_sequence_codec.o \
	$(OBJDIR)/thirdparty/bimg/3rdparty/astc-codec/src/decoder/intermediate_astc_block.o \
	$(OBJDIR)/thirdparty/bimg/3rdparty/astc-codec/src/decoder/logical_astc_block.o \
	$(OBJDIR)/thirdparty/bimg/3rdparty/astc-codec/src/decoder/partition.o \
	$(OBJDIR)/thirdparty/bimg/3rdparty/astc-codec/src/decoder/physical_astc_block.o \
	$(OBJDIR)/thirdparty/bimg/3rdparty/astc-codec/src/decoder/quantization.o \
	$(OBJDIR)/thirdparty/bimg/3rdparty/astc-codec/src/decoder/weight_infill.o \
	$(OBJDIR)/thirdparty/bimg/src/image.o \
	$(OBJDIR)/thirdparty/bimg/src/image_gnf.o \

  define PREBUILDCMDS
  endef
  define PRELINKCMDS
  endef
  define POSTBUILDCMDS
  endef
endif

ifeq ($(config),release)
  OBJDIR              = obj/Release/bimg
  TARGETDIR           = ../../../thirdparty/bimg/scripts
  TARGET              = $(TARGETDIR)/libbimgRelease.a
  DEFINES            += -D__STDC_LIMIT_MACROS -D__STDC_FORMAT_MACROS -D__STDC_CONSTANT_MACROS -DNDEBUG
  INCLUDES           += -I"../../../thirdparty/bx/include/compat/osx" -I"../../../thirdparty/bx/include" -I"../../../thirdparty/bimg/include" -I"../../../thirdparty/bimg/3rdparty/astc-codec" -I"../../../thirdparty/bimg/3rdparty/astc-codec/include"
  ALL_CPPFLAGS       += $(CPPFLAGS) -MMD -MP -MP $(DEFINES) $(INCLUDES)
  ALL_ASMFLAGS       += $(ASMFLAGS) $(CFLAGS) $(ALL_CPPFLAGS) $(ARCH) -Wall -Wextra -ffast-math -fomit-frame-pointer -g -O3 -Wshadow -Wfatal-errors -msse2 -Wunused-value -Wundef
  ALL_CFLAGS         += $(CFLAGS) $(ALL_CPPFLAGS) $(ARCH) -Wall -Wextra -ffast-math -fomit-frame-pointer -g -O3 -Wshadow -Wfatal-errors -msse2 -Wunused-value -Wundef
  ALL_CXXFLAGS       += $(CXXFLAGS) $(CFLAGS) $(ALL_CPPFLAGS) $(ARCH) -Wall -Wextra -ffast-math -fomit-frame-pointer -g -O3 -std=c++14 -fno-rtti -fno-exceptions -Wshadow -Wfatal-errors -msse2 -Wunused-value -Wundef
  ALL_OBJCFLAGS      += $(CFLAGS) $(ALL_CPPFLAGS) $(ARCH) -Wall -Wextra -ffast-math -fomit-frame-pointer -g -O3 -Wshadow -Wfatal-errors -msse2 -Wunused-value -Wundef
  ALL_OBJCPPFLAGS    += $(CXXFLAGS) $(CFLAGS) $(ALL_CPPFLAGS) $(ARCH) -Wall -Wextra -ffast-math -fomit-frame-pointer -g -O3 -std=c++14 -fno-rtti -fno-exceptions -Wshadow -Wfatal-errors -msse2 -Wunused-value -Wundef
  ALL_RESFLAGS       += $(RESFLAGS) $(DEFINES) $(INCLUDES)
  ALL_LDFLAGS        += $(LDFLAGS)
  LIBDEPS            +=
  LDDEPS             +=
  LIBS               += $(LDDEPS)
  EXTERNAL_LIBS      +=
  LINKOBJS            = $(OBJECTS)
  LINKCMD             = $(AR)  -rcs $(TARGET)
  OBJECTS := \
	$(OBJDIR)/thirdparty/bimg/3rdparty/astc-codec/src/decoder/astc_file.o \
	$(OBJDIR)/thirdparty/bimg/3rdparty/astc-codec/src/decoder/codec.o \
	$(OBJDIR)/thirdparty/bimg/3rdparty/astc-codec/src/decoder/endpoint_codec.o \
	$(OBJDIR)/thirdparty/bimg/3rdparty/astc-codec/src/decoder/footprint.o \
	$(OBJDIR)/thirdparty/bimg/3rdparty/astc-codec/src/decoder/integer_sequence_codec.o \
	$(OBJDIR)/thirdparty/bimg/3rdparty/astc-codec/src/decoder/intermediate_astc_block.o \
	$(OBJDIR)/thirdparty/bimg/3rdparty/astc-codec/src/decoder/logical_astc_block.o \
	$(OBJDIR)/thirdparty/bimg/3rdparty/astc-codec/src/decoder/partition.o \
	$(OBJDIR)/thirdparty/bimg/3rdparty/astc-codec/src/decoder/physical_astc_block.o \
	$(OBJDIR)/thirdparty/bimg/3rdparty/astc-codec/src/decoder/quantization.o \
	$(OBJDIR)/thirdparty/bimg/3rdparty/astc-codec/src/decoder/weight_infill.o \
	$(OBJDIR)/thirdparty/bimg/src/image.o \
	$(OBJDIR)/thirdparty/bimg/src/image_gnf.o \

  define PREBUILDCMDS
  endef
  define PRELINKCMDS
  endef
  define POSTBUILDCMDS
  endef
endif

OBJDIRS := \
	$(OBJDIR) \
	$(OBJDIR)/thirdparty/bimg/3rdparty/astc-codec/src/decoder \
	$(OBJDIR)/thirdparty/bimg/src \

RESOURCES := \

.PHONY: clean prebuild prelink

all: $(OBJDIRS) $(TARGETDIR) prebuild prelink $(TARGET)
	@:

$(TARGET): $(GCH) $(OBJECTS) $(LIBDEPS) $(EXTERNAL_LIBS) $(RESOURCES) | $(TARGETDIR) $(OBJDIRS)
	@echo Archiving bimg
ifeq (posix,$(SHELLTYPE))
	$(SILENT) rm -f  $(TARGET)
else
	$(SILENT) if exist $(subst /,\\,$(TARGET)) del $(subst /,\\,$(TARGET))
endif
	$(SILENT) $(LINKCMD) $(LINKOBJS) 2>&1 > /dev/null | sed -e '/.o) has no symbols$$/d'
	$(POSTBUILDCMDS)

$(TARGETDIR):
	@echo Creating $(TARGETDIR)
	-$(call MKDIR,$(TARGETDIR))

$(OBJDIRS):
	@echo Creating $(@)
	-$(call MKDIR,$@)

clean:
	@echo Cleaning bimg
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

$(OBJDIR)/thirdparty/bimg/3rdparty/astc-codec/src/decoder/astc_file.o: ../../../thirdparty/bimg/3rdparty/astc-codec/src/decoder/astc_file.cc $(GCH) $(MAKEFILE) | $(OBJDIR)/thirdparty/bimg/3rdparty/astc-codec/src/decoder
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(ALL_CXXFLAGS) $(FORCE_INCLUDE) -o "$@" -c "$<"

$(OBJDIR)/thirdparty/bimg/3rdparty/astc-codec/src/decoder/codec.o: ../../../thirdparty/bimg/3rdparty/astc-codec/src/decoder/codec.cc $(GCH) $(MAKEFILE) | $(OBJDIR)/thirdparty/bimg/3rdparty/astc-codec/src/decoder
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(ALL_CXXFLAGS) $(FORCE_INCLUDE) -o "$@" -c "$<"

$(OBJDIR)/thirdparty/bimg/3rdparty/astc-codec/src/decoder/endpoint_codec.o: ../../../thirdparty/bimg/3rdparty/astc-codec/src/decoder/endpoint_codec.cc $(GCH) $(MAKEFILE) | $(OBJDIR)/thirdparty/bimg/3rdparty/astc-codec/src/decoder
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(ALL_CXXFLAGS) $(FORCE_INCLUDE) -o "$@" -c "$<"

$(OBJDIR)/thirdparty/bimg/3rdparty/astc-codec/src/decoder/footprint.o: ../../../thirdparty/bimg/3rdparty/astc-codec/src/decoder/footprint.cc $(GCH) $(MAKEFILE) | $(OBJDIR)/thirdparty/bimg/3rdparty/astc-codec/src/decoder
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(ALL_CXXFLAGS) $(FORCE_INCLUDE) -o "$@" -c "$<"

$(OBJDIR)/thirdparty/bimg/3rdparty/astc-codec/src/decoder/integer_sequence_codec.o: ../../../thirdparty/bimg/3rdparty/astc-codec/src/decoder/integer_sequence_codec.cc $(GCH) $(MAKEFILE) | $(OBJDIR)/thirdparty/bimg/3rdparty/astc-codec/src/decoder
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(ALL_CXXFLAGS) $(FORCE_INCLUDE) -o "$@" -c "$<"

$(OBJDIR)/thirdparty/bimg/3rdparty/astc-codec/src/decoder/intermediate_astc_block.o: ../../../thirdparty/bimg/3rdparty/astc-codec/src/decoder/intermediate_astc_block.cc $(GCH) $(MAKEFILE) | $(OBJDIR)/thirdparty/bimg/3rdparty/astc-codec/src/decoder
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(ALL_CXXFLAGS) $(FORCE_INCLUDE) -o "$@" -c "$<"

$(OBJDIR)/thirdparty/bimg/3rdparty/astc-codec/src/decoder/logical_astc_block.o: ../../../thirdparty/bimg/3rdparty/astc-codec/src/decoder/logical_astc_block.cc $(GCH) $(MAKEFILE) | $(OBJDIR)/thirdparty/bimg/3rdparty/astc-codec/src/decoder
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(ALL_CXXFLAGS) $(FORCE_INCLUDE) -o "$@" -c "$<"

$(OBJDIR)/thirdparty/bimg/3rdparty/astc-codec/src/decoder/partition.o: ../../../thirdparty/bimg/3rdparty/astc-codec/src/decoder/partition.cc $(GCH) $(MAKEFILE) | $(OBJDIR)/thirdparty/bimg/3rdparty/astc-codec/src/decoder
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(ALL_CXXFLAGS) $(FORCE_INCLUDE) -o "$@" -c "$<"

$(OBJDIR)/thirdparty/bimg/3rdparty/astc-codec/src/decoder/physical_astc_block.o: ../../../thirdparty/bimg/3rdparty/astc-codec/src/decoder/physical_astc_block.cc $(GCH) $(MAKEFILE) | $(OBJDIR)/thirdparty/bimg/3rdparty/astc-codec/src/decoder
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(ALL_CXXFLAGS) $(FORCE_INCLUDE) -o "$@" -c "$<"

$(OBJDIR)/thirdparty/bimg/3rdparty/astc-codec/src/decoder/quantization.o: ../../../thirdparty/bimg/3rdparty/astc-codec/src/decoder/quantization.cc $(GCH) $(MAKEFILE) | $(OBJDIR)/thirdparty/bimg/3rdparty/astc-codec/src/decoder
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(ALL_CXXFLAGS) $(FORCE_INCLUDE) -o "$@" -c "$<"

$(OBJDIR)/thirdparty/bimg/3rdparty/astc-codec/src/decoder/weight_infill.o: ../../../thirdparty/bimg/3rdparty/astc-codec/src/decoder/weight_infill.cc $(GCH) $(MAKEFILE) | $(OBJDIR)/thirdparty/bimg/3rdparty/astc-codec/src/decoder
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(ALL_CXXFLAGS) $(FORCE_INCLUDE) -o "$@" -c "$<"

$(OBJDIR)/thirdparty/bimg/src/image.o: ../../../thirdparty/bimg/src/image.cpp $(GCH) $(MAKEFILE) | $(OBJDIR)/thirdparty/bimg/src
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(ALL_CXXFLAGS) $(FORCE_INCLUDE) -o "$@" -c "$<"

$(OBJDIR)/thirdparty/bimg/src/image_gnf.o: ../../../thirdparty/bimg/src/image_gnf.cpp $(GCH) $(MAKEFILE) | $(OBJDIR)/thirdparty/bimg/src
	@echo $(notdir $<)
	$(SILENT) $(CXX) $(ALL_CXXFLAGS) $(FORCE_INCLUDE) -o "$@" -c "$<"

-include $(OBJECTS:%.o=%.d)
ifneq (,$(PCH))
  -include $(OBJDIR)/$(notdir $(PCH)).d
  -include $(OBJDIR)/$(notdir $(PCH))_objc.d
endif
