################################################################################
#
# kmscube
#
################################################################################

KMSCUBE_VERSION = f632b23a528ed6b4e1fddd774db005c30ab65568
KMSCUBE_SITE = https://cgit.freedesktop.org/mesa/kmscube/snapshot
KMSCUBE_LICENSE = MIT
KMSCUBE_DEPENDENCIES = host-pkgconf mesa3d libdrm
KMSCUBE_AUTORECONF = YES

$(eval $(autotools-package))
