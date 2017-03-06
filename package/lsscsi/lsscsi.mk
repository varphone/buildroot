################################################################################
#
# lsscsi
#
################################################################################

LSSCSI_VERSION = v0.28
LSSCSI_SITE = $(call github,hreinecke,lsscsi,$(LSSCSI_VERSION))
LSSCSI_INSTALL_STAGING = NO
LSSCSI_INSTALL_TARGET = YES
LSSCSI_LICENSE = GPLv2
LSSCSI_LICENSE_FILES = COPYING

$(eval $(autotools-package))
