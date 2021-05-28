################################################################################
#
# kernel-module-hi_osal
#
################################################################################

ifeq ($(HISILICON_CPU_CHIP),hi3559av100)
KERNEL_MODULE_HI_OSAL_VERSION = 5ced2e745eaa0d708076a26597d2343e6a2f0812
else
KERNEL_MODULE_HI_OSAL_VERSION = 5ced2e745eaa0d708076a26597d2343e6a2f0812
endif
KERNEL_MODULE_HI_OSAL_SOURCE = kernel-module-hi_osal-$(KERNEL_MODULE_HI_OSAL_VERSION).tar.gz
KERNEL_MODULE_HI_OSAL_SITE = https://cgit.vaxpl.com/rdst/kernel-module-hi_osal/snapshot
KERNEL_MODULE_HI_OSAL_LICENSE = LGPL-2.1+
KERNEL_MODULE_HI_OSAL_LICENSE_FILES = COPYING-LGPL-2.1

ifeq ($(HISILICON_KERNEL),linux)
KERNEL_MODULE_HI_OSAL_MODULE_SUBDIRS += linux/kernel
KERNEL_MODULE_HI_OSAL_DEPENDENCIES += mpp-lib
endif

$(eval $(kernel-module))
$(eval $(generic-package))
