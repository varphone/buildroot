################################################################################
#
# ppmd-3531
#
################################################################################

ifeq ($(BR2_PACKAGE_PPMD_3531_CUSTOM_VERSION),y)
PPMD_3531_VERSION = $(call qstrip, $(BR2_PACKAGE_PPMD_3531_CUSTOM_VERSION_VALUE))
else
PPMD_3531_VERSION = 1.0.0
endif
PPMD_3531_SOURCE = ppmd-3531-$(PPMD_3531_VERSION).tar.bz2
#PPMD_3531_SITE = https://10.0.2.2/cgit/rdst/binaries-release.git/plain
#PPMD_3531_SITE = https://10.0.2.2/git/rdst/binaries-release/raw/master
#PPMD_3531_SITE = https://10.0.2.2/git/rdst/ppmd-3531/archive
PPMD_3531_SITE = https://10.0.2.2/cgit/rdst/ppmd-3531.git/snapshot
PPMD_3531_STRIP_COMPONENTS = 1
PPMD_3531_INSTALL_STAGING = NO
PPMD_3531_DEPENDENCIES = mpp-lib xpr
PPMD_3531_LICENSE = GPLv2
PPMD_3531_LICENSE_FILES = COPYING

PPMD_3531_MAKE_ENV = CROSS_COMPILER_PREFIX=$(TARGET_CROSS)

CP	= @cp
MV	= @mv
RMDIR	= @rmdir

define PPMD_3531_CONFIGURE_CMDS
	$(MV) "$(@D)/contrib/include/aac_audio_dec.h" "${@D}/contrib/include/aac_audio_dec.h.bak"
	$(MV) "$(@D)/contrib/include/aac_audio_enc.h" "${@D}/contrib/include/aac_audio_enc.h.bak"
	$(MV) "$(@D)/contrib/include/XD_Common.h" "${@D}/contrib/include/XD_Common.h.bak"
	$(MV) "$(@D)/contrib/include/XD_Stream.h" "${@D}/contrib/include/XD_Stream.h.bak"
	$(MV) "$(@D)/contrib/lib/libaacdec.a" "${@D}/contrib/lib/libaacdec.a.bak"
	$(MV) "$(@D)/contrib/lib/libaacenc.a" "${@D}/contrib/lib/libaacenc.a.bak"
	$(MV) "$(@D)/contrib/lib/libXD_Player.a" "${@D}/contrib/lib/libXD_Player.a.bak"
	$(MV) "$(@D)/contrib/lib/libXD_Stream.a" "${@D}/contrib/lib/libXD_Stream.a.bak"
	$(RM) "$(@D)/contrib/include/mkp/"*.h
	$(RM) -d "$(@D)/contrib/include/mkp"
	$(RM) "$(@D)/contrib/include/xpr/"*.h
	$(RM) -d "$(@D)/contrib/include/xpr"
	$(RM) "$(@D)/contrib/include/"*.h
	$(RM) "$(@D)/contrib/lib/"*.a
	$(RM) "$(@D)/contrib/lib/"*.so
	$(MV) "$(@D)/contrib/include/aac_audio_dec.h.bak" "${@D}/contrib/include/aac_audio_dec.h"
	$(MV) "$(@D)/contrib/include/aac_audio_enc.h.bak" "${@D}/contrib/include/aac_audio_enc.h"
	$(MV) "$(@D)/contrib/include/XD_Common.h.bak" "${@D}/contrib/include/XD_Common.h"
	$(MV) "$(@D)/contrib/include/XD_Stream.h.bak" "${@D}/contrib/include/XD_Stream.h"
	$(MV) "$(@D)/contrib/lib/libaacdec.a.bak" "${@D}/contrib/lib/libaacdec.a"
	$(MV) "$(@D)/contrib/lib/libaacenc.a.bak" "${@D}/contrib/lib/libaacenc.a"
	$(MV) "$(@D)/contrib/lib/libXD_Player.a.bak" "${@D}/contrib/lib/libXD_Player.a"
	$(MV) "$(@D)/contrib/lib/libXD_Stream.a.bak" "${@D}/contrib/lib/libXD_Stream.a"
	$(CP) "$(@D)/libavt/src/avt.h" "$(@D)/contrib/include"
	$(CP) "$(@D)/libir370/src/ir370.h" "$(@D)/contrib/include"
	$(CP) "$(@D)/libserial/src/serial.h" "$(@D)/contrib/include"
	$(CP) "$(@D)/libmal/src/mal.h" "$(@D)/contrib/include"
endef

define PPMD_3531_BUILD_CMDS
	$(MAKE1) $(PPMD_3531_MAKE_ENV) -C $(@D)/libmal all
	$(MAKE1) $(PPMD_3531_MAKE_ENV) -C $(@D)/libserial all
	$(MAKE1) $(PPMD_3531_MAKE_ENV) -C $(@D)/libavt all
	$(MAKE1) $(PPMD_3531_MAKE_ENV) -C $(@D)/libir370 all
	$(MAKE1) $(PPMD_3531_MAKE_ENV) -C $(@D)/src all
endef

define PPMD_3531_INSTALL_STAGING_CMDS
endef

define PPMD_3531_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/src/ppmd $(TARGET_DIR)/usr/bin
endef

#$(eval $(kernel-module))
$(eval $(generic-package))
