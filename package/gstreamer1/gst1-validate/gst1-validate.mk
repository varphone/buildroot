################################################################################
#
# gst1-validate
#
################################################################################

<<<<<<< HEAD
GST1_VALIDATE_VERSION = 1.10.3
=======
GST1_VALIDATE_VERSION = 1.12.2
>>>>>>> adb6d291c8... gst1-validate: bump version to 1.12.2
GST1_VALIDATE_SOURCE = gst-validate-$(GST1_VALIDATE_VERSION).tar.xz
GST1_VALIDATE_SITE = https://gstreamer.freedesktop.org/src/gst-validate
GST1_VALIDATE_LICENSE = LGPLv2.1+
GST1_VALIDATE_LICENSE_FILES = COPYING

GST1_VALIDATE_CONF_OPTS = --disable-sphinx-doc

GST1_VALIDATE_DEPENDENCIES = \
	gstreamer1 \
	gst1-plugins-base \
	json-glib \
	host-python \
	python \
	$(if $(BR2_PACKAGE_CAIRO),cairo)

$(eval $(autotools-package))
