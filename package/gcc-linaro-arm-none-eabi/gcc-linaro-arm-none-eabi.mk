################################################################################
#
# host gcc-linaro-arm-none-eabi
#
################################################################################

HOST_GCC_LINARO_ARM_NONE_EABI_VERSION = 4.8-2013.11
HOST_GCC_LINARO_ARM_NONE_EABI_SITE = https://releases.linaro.org/archive/13.11/components/toolchain/binaries
HOST_GCC_LINARO_ARM_NONE_EABI_SOURCE = gcc-linaro-arm-none-eabi-$(HOST_GCC_LINARO_ARM_NONE_EABI_VERSION)_linux.tar.xz
HOST_GCC_LINARO_ARM_NONE_EABI_LICENSE = GPL-3.0+

HOST_GCC_LINARO_ARM_NONE_EABI_INSTALL_DIR = $(HOST_DIR)/opt/gcc-linaro-arm-none-eabi

define HOST_GCC_LINARO_ARM_NONE_EABI_INSTALL_CMDS
	rm -rf $(HOST_GCC_LINARO_ARM_NONE_EABI_INSTALL_DIR)
	mkdir -p $(HOST_GCC_LINARO_ARM_NONE_EABI_INSTALL_DIR)
	cp -rf $(@D)/* $(HOST_GCC_LINARO_ARM_NONE_EABI_INSTALL_DIR)/

	mkdir -p $(HOST_DIR)/bin
	cd $(HOST_DIR)/bin && \
	for i in ../opt/gcc-linaro-arm-none-eabi/bin/*; do \
		ln -sf $$i; \
	done
endef

$(eval $(host-generic-package))
