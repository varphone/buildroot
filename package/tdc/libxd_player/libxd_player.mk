################################################################################
#
# libxd_player
#
################################################################################

ifeq ($(BR2_PACKAGE_LIBXD_PLAYER_CUSTOM_VERSION),y)
LIBXD_PLAYER_VERSION = $(call qstrip, $(BR2_PACKAGE_LIBXD_PLAYER_CUSTOM_VERSION_VALUE))
else
LIBXD_PLAYER_VERSION = 1.0.0
endif
LIBXD_PLAYER_SOURCE = libxd_player-$(LIBXD_PLAYER_VERSION).tar.xz
LIBXD_PLAYER_SITE = https://10.0.2.2/cgit/rdst/libxd_player.git/snapshot
LIBXD_PLAYER_STRIP_COMPONENTS = 1
LIBXD_PLAYER_INSTALL_STAGING = YES
LIBXD_PLAYER_LICENSE = GPLv2
LIBXD_PLAYER_LICENSE_FILES =
LIBXD_DEPENDENCIES = libmal libxd_stream mpp-lib

LIBXD_PLAYER_CFLAGS = $(TARGET_CFLAGS) $(TARGET_LDFLAGS)
LIBXD_PLAYER_CXXFLAGS = $(TARGET_CXXFLAGS) $(TARGET_LDFLAGS)

LIBXD_PLAYER_MAKE_ENV = \
 CROSS_COMPILE=$(TARGET_CROSS)\
 CC="$(TARGET_CC)"\
 CXX="$(TARGET_CXX)"\
 CFLAGS="$(TARGET_CFLAGS)"\
 CXXFLAGS="$(TARGET_CXXFLAGS)"\
 LDFLAGS="$(TARGET_LDFLAGS)"

define LIBXD_PLAYER_CONFIGURE_CMDS
endef

define LIBXD_PLAYER_BUILD_CMDS
	$(MAKE1) $(LIBXD_PLAYER_MAKE_ENV) -C $(@D) all
endef

define LIBXD_PLAYER_INSTALL_STAGING_CMDS
	$(MAKE) -C $(@D) install DESTDIR=$(STAGING_DIR) PREFIX=/usr
endef

define LIBXD_PLAYER_INSTALL_TARGET_CMDS
	$(MAKE) -C $(@D) install-bin DESTDIR=$(TARGET_DIR) PREFIX=/usr
endef

$(eval $(generic-package))
