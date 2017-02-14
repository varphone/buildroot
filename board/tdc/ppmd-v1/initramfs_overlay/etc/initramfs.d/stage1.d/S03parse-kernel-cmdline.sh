# Parsing kernel cmdline
CMDLINE=`cat /proc/cmdline`
ROOT_DEV=
ROOT_OPT=
ROOT_FST=
OVERLAYROOT=
OVERLAYROOT_DEV=
OVERLAYROOT_OPT=
OVERLAYROOT_FST=
MISC_MTD=/dev/mtd4
MISC_MTD_NUM=4
MISC_UBI=/dev/ubi0
MISC_UBI_VOL=/dev/ubi0_0
CACHE_MTD=/dev/mtd5
CACHE_MTD_NUM=5
CACHE_UBI=/dev/ubi1
CACHE_UBI_VOL=/dev/ubi1_0
MOUNT_OPTS=
for V in ${CMDLINE}; do
	case $V in
		root=*)
			ROOT_DEV=`echo $V | cut -d= -f2`
			;;
		ro)
			ROOT_OPT=ro
			;;
		rw)
			ROOT_OPT=rw
			;;
		rootfstype=*)
			ROOT_FST=`echo $V | cut -d= -f2`
			;;
		originroot=*)
			ORIGINROOT=$V
			ORIGINROOT_DEV=`echo $V | cut -d: -f1`
			ORIGINROOT_OPT=`echo $V | cut -d: -f2`
			ORIGINROOT_FST=`echo $V | cut -d: -f3`
			;;
		overlayroot=*)
			OVERLAYROOT=`echo $V | cut -d= -f2`
			OVERLAYROOT_DEV=`echo $OVERLAYROOT | cut -d: -f1`
			OVERLAYROOT_OPT=`echo $OVERLAYROOT | cut -d: -f2`
			OVERLAYROOT_FST=`echo $OVERLAYROOT | cut -d: -f3`
			;;
		*);;
	esac
done

