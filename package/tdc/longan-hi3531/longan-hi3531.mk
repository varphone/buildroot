################################################################################
#
# longan-hi3531
#
################################################################################

ifeq ($(BR2_PACKAGE_LONGAN_HI3531_CUSTOM_VERSION),y)
LONGAN_HI3531_VERSION = $(call qstrip, $(BR2_PACKAGE_LONGAN_HI3531_CUSTOM_VERSION_VALUE))
else
LONGAN_HI3531_VERSION = 1.0.9
endif
LONGAN_HI3531_SOURCE = longan-$(LONGAN_HI3531_VERSION).tar.xz
LONGAN_HI3531_SITE = https://10.0.2.2/cgit/rdst/longan.git/snapshot
LONGAN_HI3531_STRIP_COMPONENTS = 1
LONGAN_HI3531_INSTALL_STAGING = NO
LONGAN_HI3531_DEPENDENCIES = boost mpp-lib xpr
LONGAN_HI3531_LICENSE = GPLv2
LONGAN_HI3531_LICENSE_FILES =
LONGAN_HI3531_CONF_OPTS =

ifeq ($(BR2_PACKAGE_LONGAN_HI3531_BUILD_EXAMPLES),y)
LONGAN_HI3531_CONF_OPTS += -DBUILD_EXAMPLES=ON
endif

ifeq ($(BR2_PACKAGE_LONGAN_HI3531_BUILD_TESTS),y)
LONGAN_HI3531_CONF_OPTS += -DBUILD_TESTS=ON
endif

define LONGAN_HI3531_INSTALL_STAGING_CMDS
endef

define LONGAN_HI3531_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 $(@D)/bin/* $(TARGET_DIR)/usr/bin/
	$(INSTALL) -d $(TARGET_DIR)/etc/longan
	$(INSTALL) -m 0644 $(@D)/src/hi3531/settings.ini $(TARGET_DIR)/etc/longan/
endef

$(eval $(cmake-package))
