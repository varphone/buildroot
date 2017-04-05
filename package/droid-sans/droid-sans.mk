################################################################################
#
# droid-sans
#
################################################################################

DROID_SANS_VERSION = 1.0.0
DROID_SANS_SOURCE = droid-sans-fonts-ttf-$(DROID_SANS_VERSION).tar.xz
DROID_SANS_SITE = https://10.0.2.2/git/rdst/binaries-release/raw/master
DROID_SANS_STRIP_COMPONENTS = 0
DROID_SANS_LICENSE_FILES =

DROID_SANS_FONTS_INSTALL =

ifeq ($(BR2_PACKAGE_DROID_SANS_REGULAR),y)
DROID_SANS_FONTS_INSTALL += DroidSans.ttf
endif

ifeq ($(BR2_PACKAGE_DROID_SANS_BOLD),y)
DROID_SANS_FONTS_INSTALL += DroidSans-Bold.ttf
endif

ifeq ($(BR2_PACKAGE_DROID_SANS_FALLBACK_FULL),y)
DROID_SANS_FONTS_INSTALL += DroidSansFallbackFull.ttf
endif

define DROID_SANS_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/usr/share/fonts/
	for i in $(DROID_SANS_FONTS_INSTALL) ; do \
		$(INSTALL) -m 0644 $(@D)/$$i \
			$(TARGET_DIR)/usr/share/fonts/ || exit 1 ; \
	done
endef

$(eval $(generic-package))
