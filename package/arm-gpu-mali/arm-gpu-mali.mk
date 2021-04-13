################################################################################
#
# arm-gpu-mali
#
################################################################################

ARM_GPU_MALI_VERSION = ce975f51411a98b2d25b0c82b8d6da146616bfbd
ARM_GPU_MALI_SITE = $(call github,vaxpl,arm-gpu-mali,$(ARM_GPU_MALI_VERSION))

ARM_GPU_MALI_INSTALL_STAGING = YES

ARM_GPU_MALI_LICENSE = Amlogic License Agreement
ARM_GPU_MALI_LICENSE_FILES = EULA COPYING
ARM_GPU_MALI_REDISTRIBUTE = NO

ARM_GPU_MALI_LIB_HWCN = $(call qstrip,$(BR2_PACKAGE_ARM_GPU_MALI_HWCN))
ARM_GPU_MALI_LIB_HWVER = $(call qstrip,$(BR2_PACKAGE_ARM_GPU_MALI_HWVER))
ARM_GPU_MALI_LIB_TARGET = $(call qstrip,$(BR2_PACKAGE_ARM_GPU_MALI_TARGET))
ARM_GPU_MALI_LIB_VENDOR = $(call qstrip,$(BR2_PACKAGE_ARM_GPU_MALI_VENDOR))

#ARM_GPU_MALI_LIB_HWCN = gondul
#ARM_GPU_MALI_LIB_HWVER = r12p0

ifeq ($(ARM_GPU_MALI_LIB_TARGET),x11)
# The libGAL.so library provided by arm-gpu-mali uses X functions. Packages
# may want to link against libGAL.so (QT5 Base with OpenGL and X support
# does so). For this to work we need build dependencies to libXdamage,
# libXext and libXfixes so that X functions used in libGAL.so are referenced.
ARM_GPU_MALI_DEPENDENCIES += xlib_libXdamage xlib_libXext xlib_libXfixes
endif

ifeq ($(ARM_GPU_MALI_LIB_TARGET),wayland)
ARM_GPU_MALI_DEPENDENCIES += libdrm wayland
endif

ARM_GPU_MALI_LIB_TARGET_DIR = $(@D)/$(ARM_GPU_MALI_LIB_VENDOR)/lib/arm64/$(ARM_GPU_MALI_LIB_HWCN)/$(ARM_GPU_MALI_LIB_HWVER)/$(ARM_GPU_MALI_LIB_TARGET)
ARM_GPU_MALI_LIB_TARGET_HDR_DIR = $(@D)/$(ARM_GPU_MALI_LIB_VENDOR)/include/EGL_platform/platform_$(ARM_GPU_MALI_LIB_TARGET)
ARM_GPU_MALI_LIB_VENDOR_DIR = $(@D)/$(ARM_GPU_MALI_LIB_VENDOR)

define ARM_GPU_MALI_INSTALL_STAGING_CMDS
	# Install headers
	$(INSTALL) -d $(STAGING_DIR)/usr/include/EGL
	$(INSTALL) -d $(STAGING_DIR)/usr/include/GLES
	$(INSTALL) -d $(STAGING_DIR)/usr/include/GLES2
	$(INSTALL) -d $(STAGING_DIR)/usr/include/GLES3
	$(INSTALL) -d $(STAGING_DIR)/usr/include/KHR
	$(INSTALL) -m 0644 $(ARM_GPU_MALI_LIB_VENDOR_DIR)/include/EGL/*.h \
		$(STAGING_DIR)/usr/include/EGL/
	$(INSTALL) -m 0644 $(ARM_GPU_MALI_LIB_VENDOR_DIR)/include/GLES/*.h \
		$(STAGING_DIR)/usr/include/GLES/
	$(INSTALL) -m 0644 $(ARM_GPU_MALI_LIB_VENDOR_DIR)/include/GLES2/*.h \
		$(STAGING_DIR)/usr/include/GLES2/
	$(INSTALL) -m 0644 $(ARM_GPU_MALI_LIB_VENDOR_DIR)/include/GLES3/*.h \
		$(STAGING_DIR)/usr/include/GLES3/
	$(INSTALL) -m 0644 $(ARM_GPU_MALI_LIB_VENDOR_DIR)/include/KHR/*.h \
		$(STAGING_DIR)/usr/include/KHR/
	$(INSTALL) -m 0644 $(ARM_GPU_MALI_LIB_TARGET_HDR_DIR)/*.h \
		$(STAGING_DIR)/usr/include/EGL/

	# Install libraries
	cp -ap $(ARM_GPU_MALI_LIB_VENDOR_DIR)/lib/lib*.so* \
		$(STAGING_DIR)/usr/lib/
	$(INSTALL) -D -m 0755 $(ARM_GPU_MALI_LIB_TARGET_DIR)/libMali.so \
		$(STAGING_DIR)/usr/lib/

	# Install pkg-config
	$(INSTALL) -d $(STAGING_DIR)/usr/lib/pkgconfig
	$(INSTALL) -D -m 0644 $(ARM_GPU_MALI_LIB_VENDOR_DIR)/lib/pkgconfig/*.pc \
		$(STAGING_DIR)/usr/lib/pkgconfig/
endef

# On the target, remove the unused libraries.
# Note that this is _required_, else ldconfig may create symlinks
# to the wrong library
define ARM_GPU_MALI_INSTALL_TARGET_CMDS
	# Install libraries
	cp -ap $(ARM_GPU_MALI_LIB_VENDOR_DIR)/lib/lib*.so* \
		$(TARGET_DIR)/usr/lib/
	$(INSTALL) -D -m 0755 $(ARM_GPU_MALI_LIB_TARGET_DIR)/libMali.so \
		$(TARGET_DIR)/usr/lib/
endef

$(eval $(generic-package))
