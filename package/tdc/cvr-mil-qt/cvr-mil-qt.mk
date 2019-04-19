################################################################################
#
# cvr-mil-qt
#
################################################################################

ifeq ($(BR2_PACKAGE_CVR_MIL_QT_CUSTOM_VERSION),y)
CVR_MIL_QT_VERSION = $(call qstrip, $(BR2_PACKAGE_CVR_MIL_QT_CUSTOM_VERSION_VALUE))
else
CVR_MIL_QT_VERSION = 1.3.0-CVR-MIL-V1
endif
CVR_MIL_QT_SOURCE = cvr-mil-qt-$(CVR_MIL_QT_VERSION).tar.xz
CVR_MIL_QT_SITE = https://10.0.2.2/cgit/rdst/cvr-mil-qt.git/snapshot
CVR_MIL_QT_STRIP_COMPONENTS = 1
CVR_MIL_QT_INSTALL_STAGING = NO
CVR_MIL_QT_DEPENDENCIES = qt
CVR_MIL_QT_LICENSE = GPLv2
CVR_MIL_QT_LICENSE_FILES =

CP	= @cp
MV	= @mv
RMDIR	= @rmdir
QMAKE	= $(HOST_DIR)/usr/bin/qmake

define CVR_MIL_QT_CONFIGURE_CMDS
	(cd $(@D); $(QMAKE) cvr-mil-qt.pro)
endef

define CVR_MIL_QT_BUILD_CMDS
	$(MAKE) -C $(@D)
endef

define CVR_MIL_QT_INSTALL_STAGING_CMDS
endef

define CVR_MIL_QT_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 $(@D)/src/cvr-mil-qt $(TARGET_DIR)/usr/bin/
endef

$(eval $(generic-package))
