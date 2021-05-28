################################################################################
#
# mpp-lib
#
################################################################################

ifeq ($(HISILICON_CHIP),hi3559av100)
MPP_LIB_VERSION = 2aae10cd6e8f4ea9a88bb25572215cee943fa404
else
MPP_LIB_VERSION = 6498055bef22b9f824f09cf1f8f3546eca490067
endif
MPP_LIB_SOURCE = mpp-lib-$(MPP_LIB_VERSION).tar.gz
MPP_LIB_SITE = https://cgit.vaxpl.com/rdst/mpp-lib/snapshot
MPP_LIB_LICENSE = LGPL-2.1+
MPP_LIB_LICENSE_FILES = COPYING-LGPL-2.1

MPP_LIB_INSTALL_STAGING = YES

ifeq ($(HISILICON_KERNEL),linux)
MPP_LIB_DEPENDENCIES += linux
endif

ifeq ($(HISILICON_CHIP),hi3559av100)
MPP_LIB_LIBDIR = $(@D)/$(HISILICON_KERNEL)/$(HISILICON_CPU_TYPE)
else
MPP_LIB_LIBDIR = $(@D)
endif

define MPP_LIB_INSTALL_STAGING_CMDS
	mkdir -p $(STAGING_DIR)/usr/include
	mkdir -p $(STAGING_DIR)/usr/lib
	cp -aprv $(MPP_LIB_LIBDIR)/include/* $(STAGING_DIR)/usr/include/
	cp -aprv $(MPP_LIB_LIBDIR)/lib/* $(STAGING_DIR)/usr/lib/
endef

define MPP_LIB_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/lib/modules/4.9.37/extra
	mkdir -p $(TARGET_DIR)/usr/lib
	cp -aprv $(MPP_LIB_LIBDIR)/lib/*.so $(TARGET_DIR)/usr/lib/
	cp -aprv $(MPP_LIB_LIBDIR)/ko/* $(TARGET_DIR)/lib/modules/4.9.37/extra/
endef

$(eval $(generic-package))
