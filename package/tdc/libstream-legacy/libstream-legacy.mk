################################################################################
#
# libstream-legacy
#
################################################################################

ifeq ($(BR2_PACKAGE_LIBSTREAM_LEGACY_CUSTOM_VERSION),y)
LIBSTREAM_LEGACY_VERSION = $(call qstrip, $(BR2_PACKAGE_LIBSTREAM_LEGACY_CUSTOM_VERSION_VALUE))
else
LIBSTREAM_LEGACY_VERSION = 1.0
endif
LIBSTREAM_LEGACY_SOURCE = libstream-legacy-$(LIBSTREAM_LEGACY_VERSION).tar.bz2
#LIBSTREAM_LEGACY_SITE = https://cgit.vaxpl.com/rdst/binaries-release/plain
#LIBSTREAM_LEGACY_SITE = https://git.vaxpl.com/rdst/binaries-release/raw/master
#LIBSTREAM_LEGACY_SITE = https://git.vaxpl.com/rdst/ppmd-3531/archive
LIBSTREAM_LEGACY_SITE = https://cgit.vaxpl.com/rdst/libstream-legacy/snapshot
LIBSTREAM_LEGACY_STRIP_COMPONENTS = 1
LIBSTREAM_LEGACY_INSTALL_STAGING = YES
LIBSTREAM_LEGACY_LICENSE = GPLv2
LIBSTREAM_LEGACY_LICENSE_FILES =

LIBSTREAM_LEGACY_CFLAGS = $(TARGET_CFLAGS) $(TARGET_LDFLAGS)
LIBSTREAM_LEGACY_CXXFLAGS = $(TARGET_CXXFLAGS) $(TARGET_LDFLAGS)

LIBSTREAM_LEGACY_DEPENDENCIES += libpes-legacy

LIBSTREAM_LEGACY_MAKE_ENV = \
 CROSS_COMPILE=$(TARGET_CROSS)\
 CC="$(TARGET_CC)"\
 CXX="$(TARGET_CXX)"\
 CFLAGS="$(TARGET_CFLAGS)"\
 CXXFLAGS="$(TARGET_CXXFLAGS)"\
 LDFLAGS="$(TARGET_LDFLAGS)"

define LIBSTREAM_LEGACY_CONFIGURE_CMDS
endef

define LIBSTREAM_LEGACY_BUILD_CMDS
	$(MAKE1) $(LIBSTREAM_LEGACY_MAKE_ENV) -C $(@D) all
endef

define LIBSTREAM_LEGACY_INSTALL_STAGING_CMDS
	$(MAKE) -C $(@D) install DESTDIR=$(STAGING_DIR) PREFIX=/usr
endef

define LIBSTREAM_LEGACY_INSTALL_TARGET_CMDS
	$(MAKE) -C $(@D) install-bin DESTDIR=$(TARGET_DIR) PREFIX=/usr
endef

$(eval $(generic-package))
