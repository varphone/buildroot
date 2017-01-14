################################################################################
#
# mpp-ko
#
################################################################################

MPP_KO_VERSION := $(call qstrip,$(BR2_PACKAGE_HISILICON_PLATFORM))_SDK_$(call qstrip,$(BR2_PACKAGE_HISILICON_SDK_VERSION))
MPP_KO_SOURCE = mpp-ko-$(MPP_KO_VERSION).tar.xz
#MPP_KO_SITE = https://10.0.2.2/cgit/rdst/binaries-release.git/plain
MPP_KO_SITE = https://10.0.2.2/git/rdst/binaries-release/raw/master
MPP_KO_STRIP_COMPONENTS = 1
MPP_KO_LICENSE = GPLv2
MPP_KO_LICENSE_FILES = COPYING

define MPP_KO_BUILD_CMDS
endef

define MPP_KO_INSTALL_STAGING_CMDS
endef

define MPP_KO_INSTALL_TARGET_CMDS
	#echo $(LINUX_VERSION_PROBED)
	#env
	#mkdir -p $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/mpp
	#mkdir -p $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/mpp/extdrv
	#mkdir -p $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/mpp/pcie
	#$(INSTALL) -m 0644 $(@D)/ko/*.ko $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/mpp/
	#$(INSTALL) -m 0644 $(@D)/ko/extdrv/*.ko $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/mpp/extdrv/
	#$(INSTALL) -m 0644 $(@D)/ko/pcie/*.ko $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/mpp/pcie/
	#$(INSTALL) -m 0755 $(@D)/ko/load3531 $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/mpp/
	#$(INSTALL) -m 0755 $(@D)/ko/*.sh $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/mpp/
	
	mkdir -p $(TARGET_DIR)/ko
	mkdir -p $(TARGET_DIR)/ko/extdrv
	mkdir -p $(TARGET_DIR)/ko/pcie
	$(INSTALL) -m 0644 $(@D)/ko/*.ko $(TARGET_DIR)/ko/
	$(INSTALL) -m 0644 $(@D)/ko/extdrv/*.ko $(TARGET_DIR)/ko/extdrv/
	$(INSTALL) -m 0644 $(@D)/ko/pcie/*.ko $(TARGET_DIR)/ko/pcie/
	$(INSTALL) -m 0755 $(@D)/ko/load3531 $(TARGET_DIR)/ko/
	$(INSTALL) -m 0755 $(@D)/ko/*.sh $(TARGET_DIR)/ko/
endef

$(eval $(generic-package))
