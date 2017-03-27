################################################################################
#
# vrs-qt
#
################################################################################

ifeq ($(BR2_PACKAGE_VRS_QT_CUSTOM_VERSION),y)
VRS_QT_VERSION = $(call qstrip, $(BR2_PACKAGE_VRS_QT_CUSTOM_VERSION_VALUE))
else
VRS_QT_VERSION = 1.0.0
endif
VRS_QT_SOURCE = vrs-qt-$(VRS_QT_VERSION).tar.xz
VRS_QT_SITE = https://10.0.2.2/cgit/rdst/vrs-qt.git/snapshot
VRS_QT_STRIP_COMPONENTS = 1
VRS_QT_INSTALL_STAGING = NO
VRS_QT_DEPENDENCIES = libpes-legacy libxd_stream libxd_muxer libxd_player libmal mpp-lib qt xpr zlog
VRS_QT_LICENSE = GPLv2
VRS_QT_LICENSE_FILES =

VRS_QT_MAKE_ENV = \
 CROSS_COMPILER_PREFIX=$(TARGET_CROSS)\
 BUILD_DOCS=n\
 BUILD_EXAMPLES=n\
 BUILD_TESTS=n

CP	= @cp
MV	= @mv
RMDIR	= @rmdir

define VRS_QT_CONFIGURE_CMDS
endef

define VRS_QT_BUILD_CMDS
	$(MAKE1) $(VRS_QT_MAKE_ENV) -C $(@D) clean all
endef

define VRS_QT_INSTALL_STAGING_CMDS
endef

define VRS_QT_INSTALL_TARGET_CMDS
	$(MAKE1) $(VRS_QT_MAKE_ENV) -C $(@D) install-bin DESTDIR=$(TARGET_DIR) PREFIX=/usr
endef

$(eval $(generic-package))
