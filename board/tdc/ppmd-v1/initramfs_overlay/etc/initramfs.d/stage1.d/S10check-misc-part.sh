pr "UBI attaching misc part ..."
ubiattach -d 0 -m ${MISC_MTD_NUM}
if [ $? -ne 0 ]; then
	pr "UBI attach misc part failed, fix now ..."
	flash_erase ${MISC_MTD} 0 0 2&>1 > /dev/null
	ubiformat ${MISC_MTD} -q -y
	if [ $? -ne 0 ]; then
		pr "UBI format misc part failed."
		return 1
	fi
	pr "UBI attaching misc part again ...";
	ubiattach -d 0 -m ${MISC_MTD_NUM}
fi
# Check ubi volume with ubinfo
ubinfo ${MISC_UBI_VOL} 2&>1 > /dev/null
if [ $? -ne 0 ]; then
	pr "UBI misc volume not exists, fix now ..."
	ubimkvol ${MISC_UBI} -N misc -m 2&>1 > /dev/null
	if [ $? -ne 0 ]; then
		pr "UBI misc volume create failed."
		return 1
	fi
fi
