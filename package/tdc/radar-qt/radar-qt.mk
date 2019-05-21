################################################################################
#
# radar-qt
#
################################################################################

ifeq ($(BR2_PACKAGE_RADAR_QT_CUSTOM_VERSION),y)
RADAR_QT_VERSION = $(call qstrip, $(BR2_PACKAGE_RADAR_QT_CUSTOM_VERSION_VALUE))
else
RADAR_QT_VERSION = 1.0.0
endif
RADAR_QT_SOURCE = radar-qt-$(RADAR_QT_VERSION).tar.xz
RADAR_QT_SITE = https://10.0.2.2/cgit/rdst/radar-qt.git/snapshot
RADAR_QT_STRIP_COMPONENTS = 1
RADAR_QT_INSTALL_STAGING = NO
RADAR_QT_DEPENDENCIES = imx-lib qt
RADAR_QT_LICENSE = GPLv2
RADAR_QT_LICENSE_FILES =

RADAR_QT_MAKE_ENV = \
 CROSS_COMPILER_PREFIX=$(TARGET_CROSS) \
 BUILD_DOCS=n \
 BUILD_EXAMPLES=n \
 BUILD_TESTS=n

CP	= @cp
MV	= @mv
RMDIR	= @rmdir
QMAKE	= $(HOST_DIR)/usr/bin/qmake

define RADAR_QT_CONFIGURE_CMDS
	(cd $(@D); $(TARGET_MAKE_ENV) $(QMAKE) radar.pro)
endef

define RADAR_QT_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define RADAR_QT_INSTALL_STAGING_CMDS
endef

define RADAR_QT_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 $(@D)/radar $(TARGET_DIR)/usr/bin/
endef

$(eval $(generic-package))
