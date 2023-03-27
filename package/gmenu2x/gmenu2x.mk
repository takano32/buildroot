GMENU2X_VERSION = origin/master
GMENU2X_SITE_METHOD = git
GMENU2X_SITE = https://github.com/MiyooCFW/gmenu2x.git
GMENU2X_DEPENDENCIES = sdl sdl_image sdl_mixer sdl_sound sdl_ttf

PLATFORM = miyoo
BUILDTIME := $(shell date +%s)
SDL_CFLAGS  = $(shell $(STAGING_DIR)/usr/bin/sdl-config --cflags)
CFLAGS = -DPLATFORM=\"$(PLATFORM)\" -D__BUILDTIME__=$(BUILDTIME) -DLOG_LEVEL=3
CFLAGS += -Isrc 
CFLAGS += -O0 -ggdb -g3 $(SDL_CFLAGS)
CFLAGS += -DTARGET_MIYOO

define GMENU2X_BUILD_CMDS
    $(MAKE) CFLAGS="$(CFLAGS)" CC="$(TARGET_CC)" CXX="$(TARGET_CXX)" STRIP="$(TARGET_STRIP)" LD="$(TARGET_LD)" -C $(@D) -f Makefile.miyoo dist
endef

define GMENU2X_INSTALL_TARGET_CMDS
        mkdir -p "${BINARIES_DIR}/gmenu2x/"
        cp -r $(@D)/dist/miyoo/* "${BINARIES_DIR}/gmenu2x/"
endef

$(eval $(generic-package))