################################################################################
#
# ppmd-3531
#
################################################################################

ifeq ($(BR2_PACKAGE_PPMD_3531_CUSTOM_VERSION),y)
PPMD_3531_VERSION = $(call qstrip, $(BR2_PACKAGE_PPMD_3531_CUSTOM_VERSION_VALUE))
else
PPMD_3531_VERSION = 1.1.3
endif
PPMD_3531_SOURCE = ppmd-3531-$(PPMD_3531_VERSION).tar.bz2
PPMD_3531_SITE = https://10.0.2.2/cgit/rdst/ppmd-3531.git/snapshot
PPMD_3531_STRIP_COMPONENTS = 1
PPMD_3531_INSTALL_STAGING = NO
PPMD_3531_DEPENDENCIES = libavt libir370 libmal libpwc libserial-ppmd mpp-lib xpr
PPMD_3531_LICENSE = GPLv2
PPMD_3531_LICENSE_FILES =

PPMD_3531_MAKE_ENV = \
 CROSS_COMPILE=$(TARGET_CROSS)\
 CC="$(TARGET_CC)"\
 CXX="$(TARGET_CXX)"\
 CFLAGS="$(TARGET_CFLAGS)"\
 CXXFLAGS="$(TARGET_CXXFLAGS)"\
 LDFLAGS="$(TARGET_LDFLAGS)"\
 PKG_CONFIG="$(PKG_CONFIG_HOST_BINARY)"\
 BUILD_LIBMAL=n\
 BUILD_LIBAVT=n\
 BUILD_LIBSERIAL=n\
 BUILD_LIBIR370=n\
 BUILD_LIBPWC=n


CP	= @cp
MV	= @mv
RMDIR	= @rmdir

define PPMD_3531_CONFIGURE_CMDS
endef

define PPMD_3531_BUILD_CMDS
	$(MAKE1) $(PPMD_3531_MAKE_ENV) -C $(@D) clean all
endef

define PPMD_3531_INSTALL_STAGING_CMDS
endef

define PPMD_3531_INSTALL_TARGET_CMDS
	$(MAKE1) $(PPMD_3531_MAKE_ENV) -C $(@D) install-bin DESTDIR=$(TARGET_DIR) PREFIX=/usr
endef

$(eval $(generic-package))
