################################################################################
#
# libxd_stream
#
################################################################################

ifeq ($(BR2_PACKAGE_LIBXD_STREAM_CUSTOM_VERSION),y)
LIBXD_STREAM_VERSION = $(call qstrip, $(BR2_PACKAGE_LIBXD_STREAM_CUSTOM_VERSION_VALUE))
else
LIBXD_STREAM_VERSION = 4.2.0
endif
LIBXD_STREAM_SOURCE = libxd_stream-$(LIBXD_STREAM_VERSION).tar.xz
LIBXD_STREAM_SITE = https://cgit.vaxpl.com/rdst/libxd_stream/snapshot
LIBXD_STREAM_STRIP_COMPONENTS = 1
LIBXD_STREAM_INSTALL_STAGING = YES
LIBXD_STREAM_LICENSE = GPLv2
LIBXD_STREAM_LICENSE_FILES =
LIBXD_STREAM_DEPENDENCIES = libpes-legacy

LIBXD_STREAM_CFLAGS = $(TARGET_CFLAGS) $(TARGET_LDFLAGS)
LIBXD_STREAM_CXXFLAGS = $(TARGET_CXXFLAGS) $(TARGET_LDFLAGS)

LIBXD_STREAM_MAKE_ENV = \
 CROSS_COMPILE=$(TARGET_CROSS)\
 CC="$(TARGET_CC)"\
 CXX="$(TARGET_CXX)"\
 CFLAGS="$(TARGET_CFLAGS)"\
 CXXFLAGS="$(TARGET_CXXFLAGS)"\
 LDFLAGS="$(TARGET_LDFLAGS)"

define LIBXD_STREAM_CONFIGURE_CMDS
endef

define LIBXD_STREAM_BUILD_CMDS
	$(MAKE1) $(LIBXD_STREAM_MAKE_ENV) -C $(@D) clean all
endef

define LIBXD_STREAM_INSTALL_STAGING_CMDS
	$(MAKE) -C $(@D) install DESTDIR=$(STAGING_DIR) PREFIX=/usr
endef

define LIBXD_STREAM_INSTALL_TARGET_CMDS
	$(MAKE) -C $(@D) install-bin DESTDIR=$(TARGET_DIR) PREFIX=/usr
endef

$(eval $(generic-package))
