################################################################################
#
# gst1-validate
#
################################################################################

GST1_VALIDATE_VERSION = 1.12.4
GST1_VALIDATE_SOURCE = gst-validate-$(GST1_VALIDATE_VERSION).tar.xz
GST1_VALIDATE_SITE = https://gstreamer.freedesktop.org/src/gst-validate
GST1_VALIDATE_LICENSE = LGPL-2.1+
GST1_VALIDATE_LICENSE_FILES = COPYING

GST1_VALIDATE_DEPENDENCIES = \
	gstreamer1 \
	gst1-plugins-base \
	json-glib \
	host-python \
	python \
	$(if $(BR2_PACKAGE_CAIRO),cairo)

GST1_VALIDATE_CONF_OPTS += --disable-sphinx-doc

ifeq ($(BR2_STATIC_LIBS),y)
GST1_VALIDATE_CONF_OPTS += --enable-static-plugins
endif

$(eval $(autotools-package))
