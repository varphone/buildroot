################################################################################
#
# aac-audio-lib
#
################################################################################

AAC_AUDIO_LIB_VERSION = 1.0.0
AAC_AUDIO_LIB_SOURCE = aac-audio-lib-$(AAC_AUDIO_LIB_VERSION).tar.xz
#AAC_AUDIO_LIB_SITE = https://10.0.2.2/cgit/rdst/binaries-release.git/plain
AAC_AUDIO_LIB_SITE = https://10.0.2.2/git/rdst/binaries-release/raw/master
AAC_AUDIO_LIB_STRIP_COMPONENTS = 1
AAC_AUDIO_LIB_INSTALL_STAGING = YES
AAC_AUDIO_LIB_LICENSE = GPLv2
AAC_AUDIO_LIB_LICENSE_FILES =

define AAC_AUDIO_LIB_BUILD_CMDS
endef

define AAC_AUDIO_LIB_INSTALL_STAGING_CMDS
	$(INSTALL) -D -m 0644 $(@D)/include/*.* $(STAGING_DIR)/usr/include
	$(INSTALL) -D -m 0644 $(@D)/lib/*.* $(STAGING_DIR)/usr/lib
endef

define AAC_AUDIO_LIB_INSTALL_TARGET_CMDS
endef

$(eval $(generic-package))
