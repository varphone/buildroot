################################################################################
#
# host amlogic-utils
#
################################################################################

HOST_AMLOGIC_UTILS_VERSION = v2.0.0
HOST_AMLOGIC_UTILS_SITE = $(call github,varphone,amlogic-utils,$(HOST_AMLOGIC_UTILS_VERSION))
HOST_AMLOGIC_UTILS_LICENSE = GPL-3.0+

define HOST_AMLOGIC_UTILS_BUILD_CMDS
	$(MAKE) -C $(@D)/src all
endef

define HOST_AMLOGIC_UTILS_INSTALL_CMDS
	$(INSTALL) -m 0755 $(@D)/bin/aml_image_v2_packer_new $(HOST_DIR)/bin/
	$(INSTALL) -m 0755 $(@D)/bin/img2simg $(HOST_DIR)/bin/
	$(INSTALL) -m 0755 $(@D)/bin/mkbootimg $(HOST_DIR)/bin/
	$(INSTALL) -m 0755 $(@D)/src/res_packer/res_packer $(HOST_DIR)/bin/
endef

$(eval $(host-generic-package))

