################################################################################
#
# hi3531-mpp-drv
#
################################################################################

HI3531_MPP_DRV_VERSION = V2.0.A.0
HI3531_MPP_DRV_SOURCE = hi3531-mpp-drv-V2.0.A.0.tar.gz
HI3531_MPP_DRV_SITE = https://10.0.2.2/files/release/packages
HI3531_MPP_DRV_LICENSE = GPLv2
HI3531_MPP_DRV_LICENSE_FILES = COPYING

define HI3531_MPP_DRV_BUILD_CMDS
	echo "Nothing to build."
endef

define HI3531_MPP_DRV_INSTALL_STAGING_CMDS
	echo "Nothing to install."
endef

define HI3531_MPP_DRV_INSTALL_TARGET_CMDS
	#echo $(LINUX_VERSION_PROBED)
	#env
	mkdir -p $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/mpp
	mkdir -p $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/mpp/extdrv
	mkdir -p $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/mpp/pcie
	$(INSTALL) -m 0644 $(@D)/ko/*.ko $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/mpp/
	$(INSTALL) -m 0644 $(@D)/ko/extdrv/*.ko $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/mpp/extdrv/
	$(INSTALL) -m 0644 $(@D)/ko/pcie/*.ko $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/mpp/pcie/
	$(INSTALL) -m 0755 $(@D)/ko/load3531 $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/mpp/
	$(INSTALL) -m 0755 $(@D)/ko/*.sh $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/mpp/
endef

#$(eval $(kernel-module))
$(eval $(generic-package))
