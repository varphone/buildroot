################################################################################
#
# qx1-firmware
#
################################################################################

QX1_FIRMWARE_VERSION = 5779c02be35387c942695f194da20b402a06b8ae
QX1_FIRMWARE_SITE = $(call github,vaxpl,qx1-firmware,$(QX1_FIRMWARE_VERSION))
QX1_FIRMWARE_LICENSE = GPL-2.0
QX1_FIRMWARE_LICENSE_FILES = COPYING

# Not all of the firmware files are used
define QX1_FIRMWARE_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0644 $(@D)/logo.img $(BINARIES_DIR)/
	$(INSTALL) -m 0644 $(@D)/recovery.img $(BINARIES_DIR)/
endef

$(eval $(generic-package))
