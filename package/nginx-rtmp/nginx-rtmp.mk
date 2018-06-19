################################################################################
#
# nginx-rtmp
#
################################################################################

NGINX_RTMP_VERSION = 1.2.1
#NGINX_RTMP_SOURCE = https://github.com/varphone/nginx-rtmp-module/archive/v$(NGINX_1.2.1.tar.gz
NGINX_RTMP_SITE = $(call github,varphone,nginx-rtmp-module,v$(NGINX_RTMP_VERSION))
NGINX_RTMP_LICENSE = GPL-2.0+
NGINX_RTMP_LICENSE_FILES = COPYING

$(eval $(generic-package))
