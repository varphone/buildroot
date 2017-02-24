################################################################################
#
# etlmd-ia-ws
#
################################################################################

ifeq ($(BR2_PACKAGE_ETLMD_IA_WS_CUSTOM_VERSION),y)
ETLMD_IA_WS_VERSION = $(call qstrip, $(BR2_PACKAGE_ETLMD_IA_WS_CUSTOM_VERSION_VALUE))
else
ETLMD_IA_WS_VERSION = 2.2
endif
ETLMD_IA_WS_SOURCE = etlmd-ia-ws-$(ETLMD_IA_WS_VERSION).tar.bz2
ETLMD_IA_WS_SITE = https://10.0.2.2/cgit/rdst/etlmd-ia-ws.git/snapshot
ETLMD_IA_WS_STRIP_COMPONENTS = 1
ETLMD_IA_WS_INSTALL_STAGING = NO
ETLMD_IA_WS_DEPENDENCIES = etlmd-ia nodejs
ETLMD_IA_WS_LICENSE = GPLv2
ETLMD_IA_WS_LICENSE_FILES = COPYING

CP	= @cp
MV	= @mv
RMDIR	= @rmdir

define ETLMD_IA_WS_CONFIGURE_CMDS
endef

define ETLMD_IA_WS_BUILD_CMDS
endef

define ETLMD_IA_WS_INSTALL_STAGING_CMDS
endef

define ETLMD_IA_WS_INSTALL_TARGET_CMDS
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/usr/lib/etlmd-ia-ws
	tar -c --exclude .git --exclude .git* --exclude .ap* --exclude .br* --exclude .st*  -C$(@D) . | tar -x -C$(TARGET_DIR)/usr/lib/etlmd-ia-ws/
	$(INSTALL) -m 0755 -D package/tdc/etlmd-ia-ws/S90etlmd-ia-ws $(TARGET_DIR)/etc/init.d/
endef

$(eval $(generic-package))
