################################################################################
#
# mali-lib
#
################################################################################

MALI_LIB_VERSION = fdcf0375fe7fba17ced947f499135a01751ed11e
MALI_LIB_SOURCE = mali-lib-$(MALI_LIB_VERSION).tar.gz
MALI_LIB_SITE = https://cgit.vaxpl.com/rdst/mali-lib/snapshot
MALI_LIB_LICENSE = LGPL-2.1+
MALI_LIB_LICENSE_FILES = COPYING-LGPL-2.1

MALI_LIB_INSTALL_STAGING = YES

MALI_LIB_LIBDIR = $(@D)

define MALI_LIB_INSTALL_STAGING_CMDS
	mkdir -p $(STAGING_DIR)/usr/include
	mkdir -p $(STAGING_DIR)/usr/lib
	cp -aprv $(MALI_LIB_LIBDIR)/include/* $(STAGING_DIR)/usr/include/
	cp -aprv $(MALI_LIB_LIBDIR)/lib/* $(STAGING_DIR)/usr/lib/
endef

define MALI_LIB_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/lib
	cp -aprv $(MALI_LIB_LIBDIR)/lib/*.so $(TARGET_DIR)/usr/lib/
endef

$(eval $(generic-package))
