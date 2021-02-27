################################################################################
#
# host bootgen
#
################################################################################

HOST_BOOTGEN_VERSION = 2020.2
HOST_BOOTGEN_SITE = $(call github,Xilinx,bootgen,$(HOST_BOOTGEN_VERSION))
HOST_BOOTGEN_LICENSE = Apache-2.0
# HOST_BOOTGEN_INSTALL_TARGET = NO
# HOST_BOOTGEN_INSTALL_STAGING = YES
HOST_BOOTGEN_DEPENDENCIES = $(BR2_MAKE_HOST_DEPENDENCY) host-libopenssl

HOST_BOOTGEN_OPTS = LDFLAGS="$(HOST_LDFLAGS)"

define HOST_BOOTGEN_BUILD_CMDS
	$(MAKE) -C $(@D) $(HOST_BOOTGEN_OPTS)
endef

define HOST_BOOTGEN_INSTALL_CMDS
	$(INSTALL) -m 0755 -D $(@D)/bootgen \
		$(HOST_DIR)/bin/bootgen
endef

$(eval $(host-generic-package))
