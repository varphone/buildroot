################################################################################
#
# gstvafilters
#
################################################################################

ifeq ($(BR2_PACKAGE_GSTVAFILTERS_CUSTOM_VERSION),y)
GSTVAFILTERS_VERSION = $(call qstrip, $(BR2_PACKAGE_GSTVAFILTERS_CUSTOM_VERSION_VALUE))
else
GSTVAFILTERS_VERSION = 1.0.0
endif
GSTVAFILTERS_SOURCE = gstvafilters-$(GSTVAFILTERS_VERSION).tar.xz
GSTVAFILTERS_SITE = https://10.0.2.2/cgit/rdst/gstvafilters.git/snapshot
GSTVAFILTERS_STRIP_COMPONENTS = 1
GSTVAFILTERS_INSTALL_STAGING = NO
GSTVAFILTERS_DEPENDENCIES = gstreamer1 gst1-plugins-base
GSTVAFILTERS_LICENSE = GPLv2
GSTVAFILTERS_LICENSE_FILES =
GSTVAFILTERS_CONF_OPTS = -DBUILD_WITH_SIMPLIFY_OPENCV=ON

define GSTVAFILTERS_INSTALL_STAGING_CMDS
endef

define GSTVAFILTERS_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 $(@D)/src/libgstvafilters.so $(TARGET_DIR)/usr/lib/gstreamer-1.0/
endef

$(eval $(cmake-package))
