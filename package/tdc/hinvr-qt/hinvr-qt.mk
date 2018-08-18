################################################################################
#
# hinvr-qt
#
################################################################################

ifeq ($(BR2_PACKAGE_HINVR_QT_CUSTOM_VERSION),y)
HINVR_QT_VERSION = $(call qstrip, $(BR2_PACKAGE_HINVR_QT_CUSTOM_VERSION_VALUE))
else
HINVR_QT_VERSION = 1.0.0
endif
HINVR_QT_SOURCE = hinvr-qt-$(HINVR_QT_VERSION).tar.xz
HINVR_QT_SITE = https://10.0.2.2/cgit/rdst/hinvr-qt.git/snapshot
HINVR_QT_STRIP_COMPONENTS = 1
HINVR_QT_INSTALL_STAGING = NO
HINVR_QT_DEPENDENCIES = gstreamer1 qt
HINVR_QT_LICENSE = GPLv2
HINVR_QT_LICENSE_FILES =

CP	= @cp
MV	= @mv
RMDIR	= @rmdir
QMAKE	= $(HOST_DIR)/usr/bin/qmake

define HINVR_QT_CONFIGURE_CMDS
	(cd $(@D); $(QMAKE) hinvr-qt.pro)
endef

define HINVR_QT_BUILD_CMDS
	$(MAKE) -C $(@D)
endef

define HINVR_QT_INSTALL_STAGING_CMDS
endef

define HINVR_QT_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 $(@D)/src/hinvr-qt $(TARGET_DIR)/usr/bin/
endef

$(eval $(generic-package))
