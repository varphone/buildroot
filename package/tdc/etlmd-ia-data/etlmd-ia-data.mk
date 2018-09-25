################################################################################
#
# etlmd-ia-data
#
################################################################################

ifeq ($(BR2_PACKAGE_ETLMD_IA_DATA_CUSTOM_VERSION),y)
ETLMD_IA_DATA_VERSION = $(call qstrip, $(BR2_PACKAGE_ETLMD_IA_DATA_CUSTOM_VERSION_VALUE))
else
ETLMD_IA_DATA_VERSION = 1.3
endif
ETLMD_IA_DATA_SOURCE = etlmd-ia-data-$(ETLMD_IA_DATA_VERSION).tar.bz2
ETLMD_IA_DATA_SITE = https://10.0.2.2/cgit/rdst/etlmd-ia-data.git/snapshot
ETLMD_IA_DATA_STRIP_COMPONENTS = 1
ETLMD_IA_DATA_INSTALL_STAGING = NO
ETLMD_IA_DATA_DEPENDENCIES = etlmd-ia
ETLMD_IA_DATA_LICENSE = GPLv2
ETLMD_IA_DATA_LICENSE_FILES = COPYING


CP	= @cp
MV	= @mv
RMDIR	= @rmdir

define ETLMD_IA_DATA_CONFIGURE_CMDS
endef

define ETLMD_IA_DATA_BUILD_CMDS
endef

define ETLMD_IA_DATA_INSTALL_STAGING_CMDS
endef

define ETLMD_IA_DATA_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/etc/etlmd-ia
	$(INSTALL) -d $(TARGET_DIR)/etc/etlmd-ia/prefs
	$(INSTALL) -d $(TARGET_DIR)/etc/etlmd-ia/resources
	$(INSTALL) -m 0644 $(@D)/etc/etlmd-ia/*.* $(TARGET_DIR)/etc/etlmd-ia/
	$(INSTALL) -m 0644 $(@D)/etc/etlmd-ia/prefs/*.* $(TARGET_DIR)/etc/etlmd-ia/prefs/
	$(INSTALL) -m 0644 $(@D)/etc/etlmd-ia/resources/*.* $(TARGET_DIR)/etc/etlmd-ia/resources/
endef

$(eval $(generic-package))
