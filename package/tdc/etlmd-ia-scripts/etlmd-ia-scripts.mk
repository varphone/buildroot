################################################################################
#
# etlmd-ia-scripts
#
################################################################################

ifeq ($(BR2_PACKAGE_ETLMD_IA_SCRIPTS_CUSTOM_VERSION),y)
ETLMD_IA_SCRIPTS_VERSION = $(call qstrip, $(BR2_PACKAGE_ETLMD_IA_SCRIPTS_CUSTOM_VERSION_VALUE))
else
ETLMD_IA_SCRIPTS_VERSION = 1.3
endif
ETLMD_IA_SCRIPTS_SOURCE = etlmd-ia-scripts-$(ETLMD_IA_SCRIPTS_VERSION).tar.bz2
ETLMD_IA_SCRIPTS_SITE = https://10.0.2.2/cgit/rdst/etlmd-ia-scripts.git/snapshot
ETLMD_IA_SCRIPTS_STRIP_COMPONENTS = 1
ETLMD_IA_SCRIPTS_INSTALL_STAGING = NO
ETLMD_IA_SCRIPTS_DEPENDENCIES = etlmd-ia
ETLMD_IA_SCRIPTS_LICENSE = GPLv2
ETLMD_IA_SCRIPTS_LICENSE_FILES = COPYING

#ETLMD_IA_SCRIPTS_MAKE_ENV = CROSS_COMPILER_PREFIX=$(TARGET_CROSS)

CP	= @cp
MV	= @mv
RMDIR	= @rmdir

define ETLMD_IA_SCRIPTS_CONFIGURE_CMDS
endef

define ETLMD_IA_SCRIPTS_BUILD_CMDS
endef

define ETLMD_IA_SCRIPTS_INSTALL_STAGING_CMDS
endef

define ETLMD_IA_SCRIPTS_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 $(@D)/etc/init.d/S* $(TARGET_DIR)/etc/init.d/
	$(INSTALL) -m 0755 $(@D)/usr/bin/* $(TARGET_DIR)/usr/bin/
endef

$(eval $(generic-package))
