################################################################################
#
# libpavo
#
################################################################################

ifeq ($(BR2_PACKAGE_LIBPAVO_CUSTOM_VERSION),y)
LIBPAVO_VERSION = $(call qstrip, $(BR2_PACKAGE_LIBPAVO_CUSTOM_VERSION_VALUE))
else
LIBPAVO_VERSION = 1.0.8
endif
LIBPAVO_SOURCE = libpavo-$(LIBPAVO_VERSION).tar.xz
LIBPAVO_SITE = https://10.0.2.2/cgit/rdst/libpavo.git/snapshot
LIBPAVO_STRIP_COMPONENTS = 1
LIBPAVO_INSTALL_STAGING = YES
LIBPAVO_DEPENDENCIES = imx-gpu-viv
LIBPAVO_LICENSE = GPLv2
LIBPAVO_LICENSE_FILES =
LIBPAVO_CONF_OPTS = 

define LIBPAVO_INSTALL_STAGING_CMDS
	$(MAKE) -C $(@D) install DESTDIR=$(STAGING_DIR)
endef

define LIBPAVO_INSTALL_TARGET_CMDS
	$(MAKE) -C $(@D)/src install DESTDIR=$(TARGET_DIR)
endef

$(eval $(cmake-package))
