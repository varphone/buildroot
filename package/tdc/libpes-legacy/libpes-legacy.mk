################################################################################
#
# libpes-legacy
#
################################################################################

ifeq ($(BR2_PACKAGE_LIBPES_LEGACY_CUSTOM_VERSION),y)
LIBPES_LEGACY_VERSION = $(call qstrip, $(BR2_PACKAGE_LIBPES_LEGACY_CUSTOM_VERSION_VALUE))
else
LIBPES_LEGACY_VERSION = 1.0
endif
LIBPES_LEGACY_SOURCE = libpes-legacy-$(LIBPES_LEGACY_VERSION).tar.bz2
#LIBPES_LEGACY_SITE = https://10.0.2.2/cgit/rdst/binaries-release.git/plain
#LIBPES_LEGACY_SITE = https://10.0.2.2/git/rdst/binaries-release/raw/master
#LIBPES_LEGACY_SITE = https://10.0.2.2/git/rdst/ppmd-3531/archive
LIBPES_LEGACY_SITE = https://10.0.2.2/cgit/rdst/libpes-legacy.git/snapshot
LIBPES_LEGACY_STRIP_COMPONENTS = 1
LIBPES_LEGACY_INSTALL_STAGING = YES
LIBPES_LEGACY_LICENSE = GPLv2
LIBPES_LEGACY_LICENSE_FILES = COPYING

LIBPES_LEGACY_CFLAGS = $(TARGET_CFLAGS) $(TARGET_LDFLAGS)
LIBPES_LEGACY_CXXFLAGS = $(TARGET_CXXFLAGS) $(TARGET_LDFLAGS)

LIBPES_LEGACY_MAKE_ENV = \
 CROSS_COMPILE=$(TARGET_CROSS)\
 CC="$(TARGET_CC)"\
 CXX="$(TARGET_CXX)"\
 CFLAGS="$(TARGET_CFLAGS)"\
 CXXFLAGS="$(TARGET_CXXFLAGS)"\
 LDFLAGS="$(TARGET_LDFLAGS)"

define LIBPES_LEGACY_CONFIGURE_CMDS
endef

define LIBPES_LEGACY_BUILD_CMDS
	$(MAKE1) $(LIBPES_LEGACY_MAKE_ENV) -C $(@D) all
endef

define LIBPES_LEGACY_INSTALL_STAGING_CMDS
	$(MAKE) -C $(@D) install DESTDIR=$(STAGING_DIR) PREFIX=/usr
endef

define LIBPES_LEGACY_INSTALL_TARGET_CMDS
	$(MAKE) -C $(@D) install-bin DESTDIR=$(TARGET_DIR) PREFIX=/usr
endef

$(eval $(generic-package))
