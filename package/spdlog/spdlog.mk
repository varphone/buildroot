################################################################################
#
# spdlog
#
################################################################################

SPDLOG_VERSION = 1.2.1
SPDLOG_SITE = $(call github,gabime,spdlog,v$(SPDLOG_VERSION))
SPDLOG_LICENSE = MIT
SPDLOG_LICENSE_FILES = COPYING LICENSE
SPDLOG_INSTALL_STAGING = YES
SPDLOG_CONF_OPTS = \
	-DSPDLOG_BUILD_BENCH=OFF \
	-DSPDLOG_BUILD_EXAMPLES=OFF \
	-DSPDLOG_BUILD_TESTING=OFF

$(eval $(cmake-package))
