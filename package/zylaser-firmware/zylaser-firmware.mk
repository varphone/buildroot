################################################################################
#
# zylaser-firmware
#
################################################################################

ZYLASER_FIRMWARE_VERSION = $(call qstrip,$(BR2_PACKAGE_ZYLASER_FIRMWARE_VERSION))
ZYLASER_FIRMWARE_BOARD_NAME = $(call qstrip,$(BR2_PACKAGE_ZYLASER_FIRMWARE_BOARDNAME))

ZYLASER_FIRMWARE_INSTALL_IMAGES = YES
ZYLASER_FIRMWARE_INSTALL_STAGING = NO
ZYLASER_FIRMWARE_INSTALL_TARGET = NO

ifeq ($(ZYLASER_FIRMWARE_VERSION),custom)
# Handle custom Zylaser Firmware tarballs as specified by the configuration
ZYLASER_FIRMWARE_TARBALL = $(call qstrip,$(BR2_PACKAGE_ZYLASER_FIRMWARE_CUSTOM_TARBALL_LOCATION))
ZYLASER_FIRMWARE_SITE = $(patsubst %/,%,$(dir $(ZYLASER_FIRMWARE_TARBALL)))
ZYLASER_FIRMWARE_SOURCE = $(notdir $(ZYLASER_FIRMWARE_TARBALL))
else
# Handle stable official Zylaser Firmware versions
ZYLASER_FIRMWARE_SITE = $(call github,varphone,zylaser-firmware,$(ZYLASER_FIRMWARE_VERSION))
endif

ifeq ($(BR2_PACKAGE_ZYLASER_FIRMWARE)$(BR2_PACKAGE_ZYLASER_FIRMWARE_LATEST_VERSION),y)
BR_NO_CHECK_HASH_FOR += $(ZYLASER_FIRMWARE_SOURCE)
endif

define ZYLASER_FIRMWARE_INSTALL_IMAGES_CMDS
	$(INSTALL) -m 0644 $(@D)/$(ZYLASER_FIRMWARE_BOARD_NAME)/fpga.bit $(BINARIES_DIR)/fpga.bit
endef

$(eval $(generic-package))
