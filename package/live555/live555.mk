################################################################################
#
# live555
#
################################################################################

ifeq ($(BR2_PACKAGE_LIVE555_CUSTOM_TARBALL),y)
LIVE555_TARBALL = $(call qstrip,$(BR2_PACKAGE_LIVE555_CUSTOM_TARBALL_LOCATION))
LIVE555_SITE = $(patsubst %/,%,$(dir $(LIVE555_TARBALL)))
LIVE555_SOURCE = $(notdir $(LIVE555_TARBALL))
LIVE555_STRIP_COMPONENTS = $(BR2_PACKAGE_LIVE555_CUSTOM_TARBALL_STRIP_COMPONENTS)
BR_NO_CHECK_HASH_FOR += $(LIVE555_SOURCE)
else
LIVE555_VERSION = 2017.10.28
LIVE555_SOURCE = live.$(LIVE555_VERSION).tar.gz
LIVE555_SITE = http://www.live555.com/liveMedia/public
endif
LIVE555_LICENSE = LGPL-2.1+
LIVE555_LICENSE_FILES = COPYING
LIVE555_INSTALL_STAGING = YES

LIVE555_CFLAGS = $(TARGET_CFLAGS)

LIVE555_STATIC_LIBS =

ifeq ($(BR2_PACKAGE_LIVE555_FORCE_STATIC_LIBS),y)
LIVE555_STATIC_LIBS = y
endif
ifeq ($(BR2_STATIC_LIBS),y)
LIVE555_STATIC_LIBS = y
endif
ifeq ($(LIVE555_STATIC_LIBS),y)
LIVE555_CONFIG_TARGET = linux
LIVE555_LIBRARY_LINK = $(TARGET_AR) cr
else
LIVE555_CONFIG_TARGET = linux-with-shared-libraries
LIVE555_LIBRARY_LINK = $(TARGET_CC) -o
LIVE555_CFLAGS += -fPIC
endif

ifndef ($(BR2_ENABLE_LOCALE),y)
LIVE555_CFLAGS += -DLOCALE_NOT_USED
endif

define LIVE555_CONFIGURE_CMDS
	echo 'COMPILE_OPTS = $$(INCLUDES) -I. -DSOCKLEN_T=socklen_t $(LIVE555_CFLAGS)' >> $(@D)/config.$(LIVE555_CONFIG_TARGET)
	echo 'C_COMPILER = $(TARGET_CC)' >> $(@D)/config.$(LIVE555_CONFIG_TARGET)
	echo 'CPLUSPLUS_COMPILER = $(TARGET_CXX)' >> $(@D)/config.$(LIVE555_CONFIG_TARGET)

	echo 'LINK = $(TARGET_CXX) -o' >> $(@D)/config.$(LIVE555_CONFIG_TARGET)
	echo 'LINK_OPTS = -L. $(TARGET_LDFLAGS)' >> $(@D)/config.$(LIVE555_CONFIG_TARGET)
	echo 'PREFIX = /usr' >> $(@D)/config.$(LIVE555_CONFIG_TARGET)
	# Must have a whitespace at the end of LIBRARY_LINK, otherwise static link
	# fails
	echo 'LIBRARY_LINK = $(LIVE555_LIBRARY_LINK) ' >> $(@D)/config.$(LIVE555_CONFIG_TARGET)
	(cd $(@D); ./genMakefiles $(LIVE555_CONFIG_TARGET))
endef

define LIVE555_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) all
endef

define LIVE555_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) DESTDIR=$(STAGING_DIR) -C $(@D) install
	$(INSTALL) -d -m 0755 $(STAGING_DIR)/usr/include/live
	$(INSTALL) -D -m 0644 $(STAGING_DIR)/usr/include/BasicUsageEnvironment/*.* $(STAGING_DIR)/usr/include/live
	$(INSTALL) -D -m 0644 $(STAGING_DIR)/usr/include/groupsock/*.* $(STAGING_DIR)/usr/include/live
	$(INSTALL) -D -m 0644 $(STAGING_DIR)/usr/include/liveMedia/*.* $(STAGING_DIR)/usr/include/live
	$(INSTALL) -D -m 0644 $(STAGING_DIR)/usr/include/UsageEnvironment/*.* $(STAGING_DIR)/usr/include/live
endef

ifeq ($(BR2_PACKAGE_LIVE555_FORCE_STATIC_LIBS),)
define LIVE555_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) DESTDIR=$(TARGET_DIR) PREFIX=/usr -C $(@D) install
endef
endif

$(eval $(generic-package))
