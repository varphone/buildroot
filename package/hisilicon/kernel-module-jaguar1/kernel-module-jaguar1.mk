################################################################################
#
# kernel-module-jaguar1
#
################################################################################

KERNEL_MODULE_JAGUAR1_VERSION = 2b17efc14f5987fe166fe62247ef0403c75fa484
KERNEL_MODULE_JAGUAR1_SOURCE = kernel-module-jaguar1-$(KERNEL_MODULE_JAGUAR1_VERSION).tar.gz
KERNEL_MODULE_JAGUAR1_SITE = https://cgit.vaxpl.com/rdst/kernel-module-jaguar1/snapshot
KERNEL_MODULE_JAGUAR1_LICENSE = LGPL-2.1+
KERNEL_MODULE_JAGUAR1_LICENSE_FILES = COPYING-LGPL-2.1

$(eval $(kernel-module))
$(eval $(generic-package))
