################################################################################
#
# kernel-module-adv7280m
#
################################################################################

KERNEL_MODULE_ADV7280M_VERSION = 0a1052d900c98f865466b6d4a3b4d4f4f8639ef2
KERNEL_MODULE_ADV7280M_SOURCE = kernel-module-adv7280m-$(KERNEL_MODULE_ADV7280M_VERSION).tar.gz
KERNEL_MODULE_ADV7280M_SITE = https://cgit.vaxpl.com/rdst/kernel-module-adv7280m/snapshot
KERNEL_MODULE_ADV7280M_LICENSE = LGPL-2.1+
KERNEL_MODULE_ADV7280M_LICENSE_FILES = COPYING-LGPL-2.1

$(eval $(kernel-module))
$(eval $(generic-package))
