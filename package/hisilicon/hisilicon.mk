################################################################################
#
# hisilicon
#
################################################################################

HISILICON_CHIP = $(call qstrip, $(BR2_PACKAGE_HISILICON_CHIP))
HISILICON_CPU_TYPE = $(call qstrip, $(BR2_PACKAGE_HISILICON_CPU_TYPE))
HISILICON_KERNEL = $(call qstrip, $(BR2_PACKAGE_HISILICON_KERNEL))

include $(sort $(wildcard package/hisilicon/*/*.mk))
