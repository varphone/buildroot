################################################################################
#
# etlmd-ia-bgp
#
################################################################################

ifeq ($(BR2_PACKAGE_ETLMD_IA_BGP_CUSTOM_VERSION),y)
ETLMD_IA_BGP_VERSION = $(call qstrip, $(BR2_PACKAGE_ETLMD_IA_BGP_CUSTOM_VERSION_VALUE))
else
ETLMD_IA_BGP_VERSION = 1.2
endif
ETLMD_IA_BGP_SOURCE = etlmd-ia-bgp-$(ETLMD_IA_BGP_VERSION).tar.bz2
ETLMD_IA_BGP_SITE = https://10.0.2.2/cgit/rdst/etlmd-ia-bgp.git/snapshot
ETLMD_IA_BGP_STRIP_COMPONENTS = 1
ETLMD_IA_BGP_INSTALL_STAGING = NO
ETLMD_IA_BGP_DEPENDENCIES = etlmd-ia nodejs
ETLMD_IA_BGP_LICENSE = GPLv2
ETLMD_IA_BGP_LICENSE_FILES = COPYING

CP	= @cp
MV	= @mv
RMDIR	= @rmdir

define ETLMD_IA_BGP_CONFIGURE_CMDS
endef

define ETLMD_IA_BGP_BUILD_CMDS
endef

define ETLMD_IA_BGP_INSTALL_STAGING_CMDS
endef

define ETLMD_IA_BGP_INSTALL_TARGET_CMDS
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/usr/lib/etlmd-ia-bgp
	tar -c --exclude .git --exclude .git* --exclude .ap* --exclude .br* --exclude .st* -C$(@D) . | tar -x -C$(TARGET_DIR)/usr/lib/etlmd-ia-bgp/
	$(INSTALL) -m 0755 -D package/tdc/etlmd-ia-bgp/S90etlmd-ia-bgp $(TARGET_DIR)/etc/init.d/
endef

$(eval $(generic-package))
