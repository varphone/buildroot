################################################################################
#
# libserial-ppmd
#
################################################################################

ifeq ($(BR2_PACKAGE_LIBSERIAL_PPMD_CUSTOM_VERSION),y)
LIBSERIAL_PPMD_VERSION = $(call qstrip, $(BR2_PACKAGE_LIBSERIAL_PPMD_CUSTOM_VERSION_VALUE))
else
LIBSERIAL_PPMD_VERSION = 1.0.2
endif
LIBSERIAL_PPMD_SOURCE = libserial-$(LIBSERIAL_PPMD_VERSION).tar.bz2
LIBSERIAL_PPMD_SITE = https://cgit.vaxpl.com/rdst/libserial/snapshot
LIBSERIAL_PPMD_STRIP_COMPONENTS = 1
LIBSERIAL_PPMD_INSTALL_STAGING = YES
LIBSERIAL_PPMD_LICENSE = GPLv2
LIBSERIAL_PPMD_LICENSE_FILES =

LIBSERIAL_PPMD_CFLAGS = $(TARGET_CFLAGS) $(TARGET_LDFLAGS)
LIBSERIAL_PPMD_CXXFLAGS = $(TARGET_CXXFLAGS) $(TARGET_LDFLAGS)

LIBSERIAL_PPMD_MAKE_ENV = \
 CROSS_COMPILE=$(TARGET_CROSS)\
 CC="$(TARGET_CC)"\
 CXX="$(TARGET_CXX)"\
 CFLAGS="$(TARGET_CFLAGS)"\
 CXXFLAGS="$(TARGET_CXXFLAGS)"\
 LDFLAGS="$(TARGET_LDFLAGS)"\
 PKG_CONFIG="$(PKG_CONFIG_HOST_BINARY)"

define LIBSERIAL_PPMD_CONFIGURE_CMDS
endef

define LIBSERIAL_PPMD_BUILD_CMDS
	$(MAKE1) $(LIBSERIAL_PPMD_MAKE_ENV) -C $(@D) clean all
endef

define LIBSERIAL_PPMD_INSTALL_STAGING_CMDS
	$(MAKE1) $(LIBSERIAL_PPMD_MAKE_ENV) -C $(@D) install DESTDIR=$(STAGING_DIR) PREFIX=/usr
endef

define LIBSERIAL_PPMD_INSTALL_TARGET_CMDS
	$(MAKE1) $(LIBSERIAL_PPMD_MAKE_ENV) -C $(@D) install-bin DESTDIR=$(TARGET_DIR) PREFIX=/usr
endef

$(eval $(generic-package))
