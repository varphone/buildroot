################################################################################
#
# libini
#
################################################################################

LIBINI_VERSION = 1.1.10-2
LIBINI_SOURCE = libini-$(LIBINI_VERSION).tar.bz2
LIBINI_SITE = https://10.0.2.2/cgit/rdst/libini.git/snapshot
LIBINI_STRIP_COMPONENTS = 1
LIBINI_INSTALL_STAGING = YES
LIBINI_LICENSE = GPLv2
LIBINI_LICENSE_FILES = COPYING

LIBINI_AUTORECONF = YES
LIBINI_AUTORECONF_OPTS = --install

define LIBINI_REMOVE_USELESS_HEADERS
	rm -rf "$(TARGET_DIR)/usr/include"
endef

LIBINI_POST_INSTALL_TARGET_HOOKS += LIBINI_REMOVE_USELESS_HEADERS

$(eval $(autotools-package))
