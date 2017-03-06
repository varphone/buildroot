################################################################################
#
# incron
#
################################################################################

INCRON_VERSION = 0.5.10
INCRON_SITE = http://inotify.aiken.cz/download/incron
INCRON_SOURCE = incron-0.5.10.tar.bz2
INCRON_LICENSE = GPLv2
INCRON_LICENSE_FILES = LICENSE
INCRON_INSTALL_STAGING = YES

INCRON_CFLAGS = $(TARGET_CFLAGS) $(TARGET_LDFLAGS)
INCRON_CXXFLAGS = $(TARGET_CXXFLAGS) $(TARGET_LDFLAGS)


define INCRON_BUILD_CMDS
	$(MAKE) -C $(@D) CC="$(TARGET_CC)" CXX="$(TARGET_CXX)" CFLAGS="$(TARGET_CFLAGS)" CXXFLAGS="$(TARGET_CXXFLAGS)" LDFLAGS="$(TARGET_LDFALGS)"
endef

define INCRON_INSTALL_TARGET_CMDS
	$(MAKE) -C $(@D) install DESTDIR=$(TARGET_DIR) PREFIX=/usr
endef

define INCRON_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 755 package/incron/S85incrond \
		$(TARGET_DIR)/etc/init.d/S85incrond
endef

define INCRON_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 644 package/incron/incrond.service \
		$(TARGET_DIR)/usr/lib/systemd/system/incrond.service
	mkdir -p $(TARGET_DIR)/etc/systemd/system/multi-user.target.wants
	ln -sf ../../../../usr/lib/systemd/system/incrond.service \
		$(TARGET_DIR)/etc/systemd/system/multi-user.target.wants/incrond.service
endef

define INCRON_INSTALL_STAGING_CMDS
endef

$(eval $(generic-package))
