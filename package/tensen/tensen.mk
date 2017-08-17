################################################################################
#
# tensen
#
################################################################################

TENSEN_VERSION = 1.0.0
TENSEN_SOURCE = tensen-fonts-ttf-$(TENSEN_VERSION).tar.xz
TENSEN_SITE = https://10.0.2.2/git/rdst/binaries-release/raw/master
TENSEN_STRIP_COMPONENTS = 0
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
