################################################################################
#
# kernel-module-hi_dbe
#
################################################################################

ifeq ($(HISILICON_CPU_CHIP),hi3559av100)
KERNEL_MODULE_HI_DBE_VERSION = 6ff1f05e78026d2ce86adee8361d57bc86db818d
else
KERNEL_MODULE_HI_DBE_VERSION = 6ff1f05e78026d2ce86adee8361d57bc86db818d
endif
KERNEL_MODULE_HI_DBE_SOURCE = kernel-module-hi_dbe-$(KERNEL_MODULE_HI_DBE_VERSION).tar.gz
KERNEL_MODULE_HI_DBE_SITE = https://cgit.vaxpl.com/rdst/kernel-module-hi_dbe/snapshot
KERNEL_MODULE_HI_DBE_LICENSE = LGPL-2.1+
KERNEL_MODULE_HI_DBE_LICENSE_FILES = COPYING-LGPL-2.1

ifeq ($(HISILICON_KERNEL),linux)
KERNEL_MODULE_HI_DBE_DEPENDENCIES += kernel-module-hi_osal
KERNEL_MODULE_HI_DBE_EXTRA_CFLAGS = \
	-I$(@D) \
	-I$(KERNEL_MODULE_HI_OSAL_DIR)/include
KERNEL_MODULE_HI_DBE_MODULE_MAKE_OPTS += \
	EXTRA_CFLAGS="$(KERNEL_MODULE_HI_DBE_EXTRA_CFLAGS)" \
	CONFIG_HI_DMA_BUFFER_EXPORTER=m
endif

$(eval $(kernel-module))
$(eval $(generic-package))
