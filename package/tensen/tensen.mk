################################################################################
#
# tensen
#
################################################################################

TENSEN_VERSION = c280edab949ad74332e0bb2bce582e01b18be0e8
TENSEN_SOURCE = tensen-fonts-$(TENSEN_VERSION).tar.gz
TENSEN_SITE = https://cgit.vaxpl.com/rdst/tensen-fonts/snapshot
TENSEN_STRIP_COMPONENTS = 1
TENSEN_LICENSE_FILES =

TENSEN_FONTS_INSTALL =

ifeq ($(BR2_PACKAGE_TENSEN_RUIHEIJ_W1),y)
TENSEN_FONTS_INSTALL += TTRuiHeiJ-W1.ttf
endif

ifeq ($(BR2_PACKAGE_TENSEN_RUIHEIJ_W2),y)
TENSEN_FONTS_INSTALL += TTRuiHeiJ-W2.ttf
endif

ifeq ($(BR2_PACKAGE_TENSEN_XIHEIJ),y)
TENSEN_FONTS_INSTALL += TTXiHeiJ.ttf
endif

ifeq ($(BR2_PACKAGE_TENSEN_XINYUANJ_W1),y)
TENSEN_FONTS_INSTALL += TTXinYuanJ-W1.ttf
endif

ifeq ($(BR2_PACKAGE_TENSEN_ZHIHEIJ_W2),y)
TENSEN_FONTS_INSTALL += TTZhiHeiJ-W2.ttf
endif

ifeq ($(BR2_PACKAGE_TENSEN_ZHIHEIJ_W3),y)
TENSEN_FONTS_INSTALL += TTZhiHeiJ-W3.ttf
endif

ifeq ($(BR2_PACKAGE_TENSEN_ZHONGHEIJ),y)
TENSEN_FONTS_INSTALL += TTZhongHeiJ.ttf
endif

ifeq ($(BR2_PACKAGE_TENSEN_ZHONGYUANJ),y)
TENSEN_FONTS_INSTALL += TTZhongYuanJ.ttf
endif

define TENSEN_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/usr/share/fonts/
	for i in $(TENSEN_FONTS_INSTALL) ; do \
		$(INSTALL) -m 0644 $(@D)/$$i \
			$(TARGET_DIR)/usr/share/fonts/ || exit 1 ; \
	done
endef

$(eval $(generic-package))
