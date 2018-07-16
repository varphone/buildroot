# Mount procfs if not ready
pr "Checking [proc] vfs ..."
test -r /proc/mounts
if [ $? -ne 0 ]; then
	mount -t proc proc /proc
fi

# Mount devtmpfs if not ready
pr "Checking [devtmpfs] vfs ..."
grep -q devtmpfs /proc/mounts
if [ $? -ne 0 ]; then
	mount -t devtmpfs devtmpfs /dev
fi

# Mount sysfs if not ready
# Note: ubiattach required sysfs to run
pr "Checking [sysfs] vfs ..."
grep -q sysfs /proc/mounts
if [ $? -ne 0 ]; then
	mount -t sysfs sysfs /sys
fi

