################################################################################
#
# mpcam
#
################################################################################

ifeq ($(BR2_PACKAGE_MPCAM_CUSTOM_VERSION),y)
MPCAM_VERSION = $(call qstrip, $(BR2_PACKAGE_MPCAM_CUSTOM_VERSION_VALUE))
else
MPCAM_VERSION = 1.0.0
endif
MPCAM_SOURCE = mpcam-$(MPCAM_VERSION).tar.xz
MPCAM_SITE = https://10.0.2.2/cgit/rdst/mpcam.git/snapshot
MPCAM_STRIP_COMPONENTS = 1
MPCAM_INSTALL_STAGING = NO
MPCAM_DEPENDENCIES = opencv3
MPCAM_LICENSE = GPLv2
MPCAM_LICENSE_FILES =
MPCAM_CONF_OPTS =

ifeq ($(BR2_PACKAGE_MPCAM_BUILD_EXAMPLES),y)
MPCAM_CONF_OPTS += -DBUILD_EXAMPLES=ON
endif

ifeq ($(BR2_PACKAGE_MPCAM_BUILD_TESTS),y)
MPCAM_CONF_OPTS += -DBUILD_TESTS=ON
endif

define MPCAM_INSTALL_STAGING_CMDS
endef

define MPCAM_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 $(@D)/bin/* $(TARGET_DIR)/usr/bin/
endef

$(eval $(cmake-package))
