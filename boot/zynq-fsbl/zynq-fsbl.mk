################################################################################
#
# zynq-fsbl
#
################################################################################

ZYNQ_FSBL_VERSION = $(call qstrip,$(BR2_TARGET_ZYNQ_FSBL_VERSION))
ZYNQ_FSBL_BOARD_NAME = $(call qstrip,$(BR2_TARGET_ZYNQ_FSBL_BOARDNAME))

ZYNQ_FSBL_DEPENDENCIES = host-arm-gnu-a-toolchain
ZYNQ_FSBL_INSTALL_STAGING = NO
ZYNQ_FSBL_INSTALL_TARGET = NO
ZYNQ_FSBL_INSTALL_IMAGES = YES

ifeq ($(ZYNQ_FSBL_VERSION),custom)
# Handle custom Zynq FSBL tarballs as specified by the configuration
ZYNQ_FSBL_TARBALL = $(call qstrip,$(BR2_TARGET_ZYNQ_FSBL_CUSTOM_TARBALL_LOCATION))
ZYNQ_FSBL_SITE = $(patsubst %/,%,$(dir $(ZYNQ_FSBL_TARBALL)))
ZYNQ_FSBL_SOURCE = $(notdir $(ZYNQ_FSBL_TARBALL))
else
# Handle stable official Zynq FSBL versions
ZYNQ_FSBL_SITE = $(call github,varphone,zynq-fsbl,$(ZYNQ_FSBL_VERSION))
endif

ifeq ($(BR2_TARGET_ZYNQ_FSBL)$(BR2_TARGET_ZYNQ_FSBL_LATEST_VERSION),y)
BR_NO_CHECK_HASH_FOR += $(ZYNQ_FSBL_SOURCE)
endif

CFLAGS :=

ifeq ($(BR2_TARGET_ZYNQ_FSBL_DEBUG_INFO),y)
CFLAGS += -DFSBL_DEBUG_INFO
endif

ifeq ($(BR2_TARGET_ZYNQ_FSBL_MMC_SUPPORT),y)
CFLAGS += -DMMC_SUPPORT
endif

ifeq ($(BR2_TARGET_ZYNQ_FSBL_RSA_SUPPORT),y)
CFLAGS += -DRSA_SUPPORT
endif

ZYNQ_FSBL_MAKE_OPTS += BOARD=$(ZYNQ_FSBL_BOARD_NAME)
ZYNQ_FSBL_MAKE_OPTS += CFLAGS="$(CFLAGS)"

define ZYNQ_FSBL_BUILD_CMDS
	$(HOST_MAKE_ENV) $(MAKE1) -C $(@D) $(ZYNQ_FSBL_MAKE_OPTS) clean
	$(HOST_MAKE_ENV) $(MAKE1) -C $(@D) $(ZYNQ_FSBL_MAKE_OPTS)
endef

define ZYNQ_FSBL_INSTALL_IMAGES_CMDS
	$(INSTALL) -m 0755 $(@D)/src/executable.elf $(BINARIES_DIR)/zynq_fsbl.elf
endef

$(eval $(generic-package))
