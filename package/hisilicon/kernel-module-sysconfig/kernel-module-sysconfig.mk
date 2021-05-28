################################################################################
#
# kernel-module-sysconfig
#
################################################################################

ifeq ($(HISILICON_CPU_CHIP),hi3559av100)
KERNEL_MODULE_SYSCONFIG_VERSION = 679e588a0280409db4de3745abf86c812e3e788d
else
KERNEL_MODULE_SYSCONFIG_VERSION = 679e588a0280409db4de3745abf86c812e3e788d
endif
KERNEL_MODULE_SYSCONFIG_SOURCE = kernel-module-sysconfig-$(KERNEL_MODULE_SYSCONFIG_VERSION).tar.gz
KERNEL_MODULE_SYSCONFIG_SITE = https://cgit.vaxpl.com/rdst/kernel-module-sysconfig/snapshot
KERNEL_MODULE_SYSCONFIG_LICENSE = LGPL-2.1+
KERNEL_MODULE_SYSCONFIG_LICENSE_FILES = COPYING-LGPL-2.1

ifeq ($(HISILICON_CPU_KERNEL),linux)
KERNEL_MODULE_SYSCONFIG_DEPENDENCIES += mpp-lib
endif

$(eval $(kernel-module))
$(eval $(generic-package))
