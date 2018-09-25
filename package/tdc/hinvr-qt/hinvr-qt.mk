################################################################################
#
# hinvr-qt
#
################################################################################

ifeq ($(BR2_PACKAGE_HINVR_QT_CUSTOM_VERSION),y)
HINVR_QT_VERSION = $(call qstrip, $(BR2_PACKAGE_HINVR_QT_CUSTOM_VERSION_VALUE))
else
HINVR_QT_VERSION = 1.0.9
endif
HINVR_QT_SOURCE = hinvr-qt-$(HINVR_QT_VERSION).tar.xz
HINVR_QT_SITE = https://10.0.2.2/cgit/rdst/hinvr-qt.git/snapshot
HINVR_QT_STRIP_COMPONENTS = 1
HINVR_QT_INSTALL_STAGING = NO
HINVR_QT_DEPENDENCIES = gstreamer1
HINVR_QT_LICENSE = GPLv2
HINVR_QT_LICENSE_FILES =

CP	= @cp
MV	= @mv
RMDIR	= @rmdir
QMAKE	= $(HOST_DIR)/usr/bin/qmake

HINVR_QT_DEPENDENCIES += $(if $(BR2_PACKAGE_QT),qt)
HINVR_QT_DEPENDENCIES += $(if $(BR2_PACKAGE_QT5BASE),qt5base)

define HINVR_QT_CONFIGURE_CMDS
	(cd $(@D); $(TARGET_CONFIGURE_OPTS) $(QMAKE) hinvr-qt.pro)
endef

define HINVR_QT_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define HINVR_QT_INSTALL_STAGING_CMDS
endef

define HINVR_QT_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/share/fonts
	$(INSTALL) -m 0644 $(@D)/fonts/Ubunoto-Mono-SC.ttf $(TARGET_DIR)/usr/share/fonts/
	$(INSTALL) -m 0755 $(@D)/src/hinvr-qt $(TARGET_DIR)/usr/bin/
endef

$(eval $(generic-package))
