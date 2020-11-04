################################################################################
#
# zylaser-firmware
#
################################################################################

ZYLASER_FIRMWARE_VERSION = v1.0.0
ZYLASER_FIRMWARE_SITE = $(call github,varphone,zylaser-firmware,$(ZYLASER_FIRMWARE_VERSION))
ZYLASER_FIRMWARE_INSTALL_IMAGES = YES
ZYLASER_FIRMWARE_INSTALL_STAGING = NO
ZYLASER_FIRMWARE_INSTALL_TARGET = NO

define ZYLASER_FIRMWARE_INSTALL_IMAGES_CMDS
	$(INSTALL) -m 0644 $(@D)/fpga.bit $(BINARIES_DIR)/fpga.bit
	$(INSTALL) -m 0644 $(@D)/zynq_fsbl.elf $(BINARIES_DIR)/zynq_fsbl.elf
endef

$(eval $(generic-package))
