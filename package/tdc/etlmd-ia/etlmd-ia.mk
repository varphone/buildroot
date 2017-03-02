################################################################################
#
# etlmd-ia
#
################################################################################

ifeq ($(BR2_PACKAGE_ETLMD_IA_CUSTOM_VERSION),y)
ETLMD_IA_VERSION = $(call qstrip, $(BR2_PACKAGE_ETLMD_IA_CUSTOM_VERSION_VALUE))
else
ETLMD_IA_VERSION = 2.0.2
endif
ETLMD_IA_SOURCE = etlmd-ia-$(ETLMD_IA_VERSION).tar.bz2
#ETLMD_IA_SITE = https://10.0.2.2/cgit/rdst/binaries-release.git/plain
#ETLMD_IA_SITE = https://10.0.2.2/git/rdst/binaries-release/raw/master
#ETLMD_IA_SITE = https://10.0.2.2/git/rdst/etlmd-ia/archive
ETLMD_IA_SITE = https://10.0.2.2/cgit/rdst/etlmd-ia.git/snapshot
ETLMD_IA_STRIP_COMPONENTS = 1
ETLMD_IA_INSTALL_STAGING = NO
ETLMD_IA_DEPENDENCIES = opencv libpes-legacy libstream-legacy xpr-legacy
ETLMD_IA_LICENSE = GPLv2
ETLMD_IA_LICENSE_FILES = COPYING

ETLMD_IA_MAKE_ENV = \
 CROSS_COMPILE=$(TARGET_CROSS) \
 CFLAGS="$(TARGET_CFLAGS)" \
 CXXFLAGS="$(TARGET_CXXFLAGS)" \
 LDFLAGS="$(TARGET_LDFLAGS)"

CP	= @cp
MV	= @mv
RMDIR	= @rmdir

define ETLMD_IA_CONFIGURE_CMDS
endef

define ETLMD_IA_BUILD_CMDS
	$(MAKE1) $(ETLMD_IA_MAKE_ENV) -C $(@D)/src clean all
endef

define ETLMD_IA_INSTALL_STAGING_CMDS
endef

define ETLMD_IA_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/src/etlmd-ia $(TARGET_DIR)/usr/bin
endef

$(eval $(generic-package))
