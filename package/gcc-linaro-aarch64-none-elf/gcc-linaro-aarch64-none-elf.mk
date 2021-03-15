################################################################################
#
# host gcc-linaro-aarch64-none-elf
#
################################################################################

HOST_GCC_LINARO_AARCH64_NONE_ELF_VERSION = 4.8-2013.11
HOST_GCC_LINARO_AARCH64_NONE_ELF_SITE = https://releases.linaro.org/archive/13.11/components/toolchain/binaries
HOST_GCC_LINARO_AARCH64_NONE_ELF_SOURCE = gcc-linaro-aarch64-none-elf-$(HOST_GCC_LINARO_AARCH64_NONE_ELF_VERSION)_linux.tar.xz
HOST_GCC_LINARO_AARCH64_NONE_ELF_LICENSE = GPL-3.0+

HOST_GCC_LINARO_AARCH64_NONE_ELF_INSTALL_DIR = $(HOST_DIR)/opt/gcc-linaro-aarch64-none-elf

define HOST_GCC_LINARO_AARCH64_NONE_ELF_INSTALL_CMDS
	rm -rf $(HOST_GCC_LINARO_AARCH64_NONE_ELF_INSTALL_DIR)
	mkdir -p $(HOST_GCC_LINARO_AARCH64_NONE_ELF_INSTALL_DIR)
	cp -rf $(@D)/* $(HOST_GCC_LINARO_AARCH64_NONE_ELF_INSTALL_DIR)/

	mkdir -p $(HOST_DIR)/bin
	cd $(HOST_DIR)/bin && \
	for i in ../opt/gcc-linaro-aarch64-none-elf/bin/*; do \
		ln -sf $$i; \
	done
endef

$(eval $(host-generic-package))
