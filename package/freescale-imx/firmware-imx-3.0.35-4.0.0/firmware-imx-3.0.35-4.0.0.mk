################################################################################
#
# firmware-imx-3.0.35-4.0.0
#
################################################################################

FIRMWARE_IMX_3_0_35_4_0_0_VERSION = 3.0.35-4.0.0
FIRMWARE_IMX_3_0_35_4_0_0_SOURCE = firmware-imx-$(FIRMWARE_IMX_3_0_35_4_0_0_VERSION).tar.gz
FIRMWARE_IMX_3_0_35_4_0_0_SITE = https://10.0.2.2/git/rdst/binaries-release/raw/master

FIRMWARE_IMX_3_0_35_4_0_0_LICENSE = NXP Semiconductor Software License Agreement
FIRMWARE_IMX_3_0_35_4_0_0_LICENSE_FILES = EULA COPYING
FIRMWARE_IMX_3_0_35_4_0_0_REDISTRIBUTE = NO

define FIRMWARE_IMX_3_0_35_4_0_0_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/lib/firmware/sdma
	$(INSTALL) -m 0644 $(@D)/firmware/sdma/*.bin $(TARGET_DIR)/lib/firmware/sdma/
	$(INSTALL) -d $(TARGET_DIR)/lib/firmware/vpu
	$(INSTALL) -m 0644 $(@D)/firmware/vpu/*.bin $(TARGET_DIR)/lib/firmware/vpu/
endef

$(eval $(generic-package))
