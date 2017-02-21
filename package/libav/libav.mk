################################################################################
#
# libav
#
################################################################################

LIBAV_VERSION = 11.4
LIBAV_SOURCE = libav-$(LIBAV_VERSION).tar.xz
LIBAV_SITE = https://libav.org/releases
LIBAV_INSTALL_STAGING = YES

LIBAV_LICENSE = LGPLv2.1+, libjpeg license
LIBAV_LICENSE_FILES = LICENSE.md COPYING.LGPLv2.1
ifeq ($(BR2_PACKAGE_LIBAV_GPL),y)
LIBAV_LICENSE += and GPLv2+
LIBAV_LICENSE_FILES += COPYING.GPLv2
endif

LIBAV_CONF_OPTS = \
	--prefix=/usr \
	--enable-avfilter \
	--disable-version3 \
	--enable-logging \
	--enable-optimizations \
	--disable-extra-warnings \
	--enable-avdevice \
	--enable-avcodec \
	--enable-avformat \
	--disable-x11grab \
	--enable-network \
	--disable-gray \
	--enable-swscale-alpha \
	--disable-small \
	--enable-dct \
	--enable-fft \
	--enable-mdct \
	--enable-rdft \
	--disable-vdpau \
	--disable-dxva2 \
	--enable-runtime-cpudetect \
	--disable-hardcoded-tables \
	--disable-memalign-hack \
	--enable-hwaccels \
	--disable-avisynth \
	--disable-frei0r \
	--disable-libopencore-amrnb \
	--disable-libopencore-amrwb \
	--disable-libopencv \
	--disable-libdc1394 \
	--disable-libfaac \
	--disable-libgsm \
	--disable-libmp3lame \
	--disable-libopenjpeg \
	--disable-librtmp \
	--disable-libschroedinger \
	--disable-libspeex \
	--disable-libtheora \
	--disable-libvo-aacenc \
	--disable-libvo-amrwbenc \
	--disable-symver \
	--disable-doc

LIBAV_DEPENDENCIES += $(if $(BR2_PACKAGE_LIBICONV),libiconv) host-pkgconf

ifeq ($(BR2_PACKAGE_LIBAV_GPL),y)
LIBAV_CONF_OPTS += --enable-gpl
else
LIBAV_CONF_OPTS += --disable-gpl
endif

ifeq ($(BR2_PACKAGE_LIBAV_NONFREE),y)
LIBAV_CONF_OPTS += --enable-nonfree
else
LIBAV_CONF_OPTS += --disable-nonfree
endif

ifeq ($(BR2_PACKAGE_LIBAV_AVCONV),y)
LIBAV_CONF_OPTS += --enable-avconv
else
LIBAV_CONF_OPTS += --disable-avconv
endif

ifeq ($(BR2_PACKAGE_LIBAV_AVPLAY),y)
LIBAV_DEPENDENCIES += sdl
LIBAV_CONF_OPTS += --enable-avplay
LIBAV_CONF_ENV += SDL_CONFIG=$(STAGING_DIR)/usr/bin/sdl-config
else
LIBAV_CONF_OPTS += --disable-avplay
endif

ifeq ($(BR2_PACKAGE_LIBAV_AVSERVER),y)
LIBAV_CONF_OPTS += --enable-avserver
else
LIBAV_CONF_OPTS += --disable-avserver
endif

ifeq ($(BR2_PACKAGE_LIBAV_AVRESAMPLE),y)
LIBAV_CONF_OPTS += --enable-avresample
else
LIBAV_CONF_OPTS += --disable-avresample
endif

ifeq ($(BR2_PACKAGE_LIBAV_AVPROBE),y)
LIBAV_CONF_OPTS += --enable-avprobe
else
LIBAV_CONF_OPTS += --disable-avprobe
endif

#ifeq ($(BR2_PACKAGE_LIBAV_POSTPROC),y)
#LIBAV_CONF_OPTS += --enable-postproc
#else
#LIBAV_CONF_OPTS += --disable-postproc
#endif

ifeq ($(BR2_PACKAGE_LIBAV_SWSCALE),y)
LIBAV_CONF_OPTS += --enable-swscale
else
LIBAV_CONF_OPTS += --disable-swscale
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_LIBAV_ENCODERS)),all)
LIBAV_CONF_OPTS += --disable-encoders \
	$(foreach x,$(call qstrip,$(BR2_PACKAGE_LIBAV_ENCODERS)),--enable-encoder=$(x))
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_LIBAV_DECODERS)),all)
LIBAV_CONF_OPTS += --disable-decoders \
	$(foreach x,$(call qstrip,$(BR2_PACKAGE_LIBAV_DECODERS)),--enable-decoder=$(x))
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_LIBAV_MUXERS)),all)
LIBAV_CONF_OPTS += --disable-muxers \
	$(foreach x,$(call qstrip,$(BR2_PACKAGE_LIBAV_MUXERS)),--enable-muxer=$(x))
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_LIBAV_DEMUXERS)),all)
LIBAV_CONF_OPTS += --disable-demuxers \
	$(foreach x,$(call qstrip,$(BR2_PACKAGE_LIBAV_DEMUXERS)),--enable-demuxer=$(x))
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_LIBAV_PARSERS)),all)
LIBAV_CONF_OPTS += --disable-parsers \
	$(foreach x,$(call qstrip,$(BR2_PACKAGE_LIBAV_PARSERS)),--enable-parser=$(x))
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_LIBAV_BSFS)),all)
LIBAV_CONF_OPTS += --disable-bsfs \
	$(foreach x,$(call qstrip,$(BR2_PACKAGE_LIBAV_BSFS)),--enable-bsfs=$(x))
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_LIBAV_PROTOCOLS)),all)
LIBAV_CONF_OPTS += --disable-protocols \
	$(foreach x,$(call qstrip,$(BR2_PACKAGE_LIBAV_PROTOCOLS)),--enable-protocol=$(x))
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_LIBAV_FILTERS)),all)
LIBAV_CONF_OPTS += --disable-filters \
	$(foreach x,$(call qstrip,$(BR2_PACKAGE_LIBAV_FILTERS)),--enable-filter=$(x))
endif

ifeq ($(BR2_PACKAGE_LIBAV_INDEVS),y)
LIBAV_CONF_OPTS += --enable-indevs
else
LIBAV_CONF_OPTS += --disable-indevs
endif

ifeq ($(BR2_PACKAGE_LIBAV_OUTDEVS),y)
LIBAV_CONF_OPTS += --enable-outdevs
else
LIBAV_CONF_OPTS += --disable-outdevs
endif

ifeq ($(BR2_TOOLCHAIN_HAS_THREADS),y)
LIBAV_CONF_OPTS += --enable-pthreads
else
LIBAV_CONF_OPTS += --disable-pthreads
endif

ifeq ($(BR2_PACKAGE_ZLIB),y)
LIBAV_CONF_OPTS += --enable-zlib
LIBAV_DEPENDENCIES += zlib
else
LIBAV_CONF_OPTS += --disable-zlib
endif

ifeq ($(BR2_PACKAGE_BZIP2),y)
LIBAV_CONF_OPTS += --enable-bzlib
LIBAV_DEPENDENCIES += bzip2
else
LIBAV_CONF_OPTS += --disable-bzlib
endif

ifeq ($(BR2_PACKAGE_OPENSSL),y)
# openssl isn't license compatible with GPL
ifeq ($(BR2_PACKAGE_LIBAV_GPL)x$(BR2_PACKAGE_LIBAV_NONFREE),yx)
LIBAV_CONF_OPTS += --disable-openssl
else
LIBAV_CONF_OPTS += --enable-openssl
LIBAV_DEPENDENCIES += openssl
endif
else
LIBAV_CONF_OPTS += --disable-openssl
endif

ifeq ($(BR2_PACKAGE_LIBVORBIS),y)
LIBAV_DEPENDENCIES += libvorbis
LIBAV_CONF_OPTS += \
	--enable-libvorbis \
	--enable-muxer=ogg \
	--enable-encoder=libvorbis
endif

ifeq ($(BR2_PACKAGE_LIBVA),y)
LIBAV_CONF_OPTS += --enable-vaapi
LIBAV_DEPENDENCIES += libva
else
LIBAV_CONF_OPTS += --disable-vaapi
endif

ifeq ($(BR2_PACKAGE_OPUS),y)
LIBAV_CONF_OPTS += --enable-libopus
LIBAV_DEPENDENCIES += opus
else
LIBAV_CONF_OPTS += --disable-libopus
endif

ifeq ($(BR2_PACKAGE_LIBVPX),y)
LIBAV_CONF_OPTS += --enable-libvpx
LIBAV_DEPENDENCIES += libvpx
else
LIBAV_CONF_OPTS += --disable-libvpx
endif

# libav freetype support require fenv.h which is only
# available/working on glibc.
# The microblaze variant doesn't provide the needed exceptions
ifeq ($(BR2_PACKAGE_FREETYPE)$(BR2_TOOLCHAIN_USES_GLIBC)x$(BR2_microblaze),yyx)
LIBAV_CONF_OPTS += --enable-libfreetype
LIBAV_DEPENDENCIES += freetype
else
LIBAV_CONF_OPTS += --disable-libfreetype
endif

#ifeq ($(BR2_PACKAGE_FONTCONFIG),y)
#LIBAV_CONF_OPTS += --enable-fontconfig
#LIBAV_DEPENDENCIES += fontconfig
#else
#LIBAV_CONF_OPTS += --disable-fontconfig
#endif

ifeq ($(BR2_PACKAGE_X264)$(BR2_PACKAGE_LIBAV_GPL),yy)
LIBAV_CONF_OPTS += --enable-libx264
LIBAV_DEPENDENCIES += x264
else
LIBAV_CONF_OPTS += --disable-libx264
endif

ifeq ($(BR2_X86_CPU_HAS_MMX),y)
LIBAV_CONF_OPTS += --enable-yasm
LIBAV_DEPENDENCIES += host-yasm
else
ifeq ($(BR2_x86_i586),y)
# Needed to work around a bug with gcc 5.x:
# error: 'asm' operand has impossible constraints
LIBAV_CONF_OPTS += --disable-inline-asm
endif
LIBAV_CONF_OPTS += --disable-yasm
LIBAV_CONF_OPTS += --disable-mmx
endif

ifeq ($(BR2_X86_CPU_HAS_SSE),y)
LIBAV_CONF_OPTS += --enable-sse
else
LIBAV_CONF_OPTS += --disable-sse
endif

ifeq ($(BR2_X86_CPU_HAS_SSE2),y)
LIBAV_CONF_OPTS += --enable-sse2
else
LIBAV_CONF_OPTS += --disable-sse2
endif

ifeq ($(BR2_X86_CPU_HAS_SSE3),y)
LIBAV_CONF_OPTS += --enable-sse3
else
LIBAV_CONF_OPTS += --disable-sse3
endif

ifeq ($(BR2_X86_CPU_HAS_SSSE3),y)
LIBAV_CONF_OPTS += --enable-ssse3
else
LIBAV_CONF_OPTS += --disable-ssse3
endif

ifeq ($(BR2_X86_CPU_HAS_SSE4),y)
LIBAV_CONF_OPTS += --enable-sse4
else
LIBAV_CONF_OPTS += --disable-sse4
endif

ifeq ($(BR2_X86_CPU_HAS_SSE42),y)
LIBAV_CONF_OPTS += --enable-sse42
else
LIBAV_CONF_OPTS += --disable-sse42
endif

ifeq ($(BR2_X86_CPU_HAS_AVX),y)
LIBAV_CONF_OPTS += --enable-avx
else
LIBAV_CONF_OPTS += --disable-avx
endif

ifeq ($(BR2_X86_CPU_HAS_AVX2),y)
LIBAV_CONF_OPTS += --enable-avx2
else
LIBAV_CONF_OPTS += --disable-avx2
endif

# Explicitly disable everything that doesn't match for ARM
# LIBAV "autodetects" by compiling an extended instruction via AS
# This works on compilers that aren't built for generic by default
ifeq ($(BR2_ARM_CPU_ARMV4),y)
LIBAV_CONF_OPTS += --disable-armv5te
endif
ifeq ($(BR2_ARM_CPU_ARMV6)$(BR2_ARM_CPU_ARMV7A),y)
LIBAV_CONF_OPTS += --enable-armv6
else
LIBAV_CONF_OPTS += --disable-armv6 --disable-armv6t2
endif
ifeq ($(BR2_ARM_CPU_HAS_VFPV2),y)
LIBAV_CONF_OPTS += --enable-vfp
else
LIBAV_CONF_OPTS += --disable-vfp
endif
ifeq ($(BR2_ARM_CPU_HAS_NEON),y)
LIBAV_CONF_OPTS += --enable-neon
endif

#ifeq ($(BR2_MIPS_SOFT_FLOAT),y)
#LIBAV_CONF_OPTS += \
#	--disable-mipsfpu
#else
#LIBAV_CONF_OPTS += \
#	--enable-mipsfpu
#endif

#ifeq ($(BR2_mips_32r2),y)
#LIBAV_CONF_OPTS += \
#	--enable-mips32r2
#else
#LIBAV_CONF_OPTS += \
#	--disable-mips32r2
#endif

#ifeq ($(BR2_mips_64r2),y)
#LIBAV_CONF_OPTS += \
#	--enable-mipsdspr1 \
#	--enable-mipsdspr2
#else
#LIBAV_CONF_OPTS += \
#	--disable-mipsdspr1 \
#	--disable-mipsdspr2
#endif

ifeq ($(BR2_POWERPC_CPU_HAS_ALTIVEC),y)
LIBAV_CONF_OPTS += --enable-altivec
else
LIBAV_CONF_OPTS += --disable-altivec
endif

ifeq ($(BR2_STATIC_LIBS),)
LIBAV_CONF_OPTS += --enable-pic
else
LIBAV_CONF_OPTS += --disable-pic
endif

LIBAV_CONF_OPTS += $(call qstrip,$(BR2_PACKAGE_LIBAV_EXTRACONF))

ifneq ($(call qstrip,$(BR2_GCC_TARGET_CPU)),)
LIBAV_CONF_OPTS += --cpu=$(BR2_GCC_TARGET_CPU)
else ifneq ($(call qstrip,$(BR2_GCC_TARGET_ARCH)),)
LIBAV_CONF_OPTS += --cpu=$(BR2_GCC_TARGET_ARCH)
endif

# Override LIBAV_CONFIGURE_CMDS: FFmpeg does not support --target and others
define LIBAV_CONFIGURE_CMDS
	(cd $(LIBAV_SRCDIR) && rm -rf config.cache && \
	$(TARGET_CONFIGURE_OPTS) \
	$(TARGET_CONFIGURE_ARGS) \
	$(LIBAV_CONF_ENV) \
	./configure \
		--enable-cross-compile \
		--cross-prefix=$(TARGET_CROSS) \
		--sysroot=$(STAGING_DIR) \
		--host-cc="$(HOSTCC)" \
		--arch=$(BR2_ARCH) \
		--target-os="linux" \
		--pkg-config="$(PKG_CONFIG_HOST_BINARY)" \
		$(SHARED_STATIC_LIBS_OPTS) \
		$(LIBAV_CONF_OPTS) \
	)
endef

$(eval $(autotools-package))
