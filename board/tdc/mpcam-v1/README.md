mpcam-v1
========

基于 Zynq ZC702 实现多光路摄像头（第一版）。

关于设备代号 `mpcam-v1` 的命名说明：

- **mpcam** - 多光路摄像头(Multiple Path Camera)。
- **v1** - 第一个版本。

文件说明
--------

- **`patches`** - 各个包的补丁目录。
- **`rootfs_overlay`** - `rootfs` 的覆盖目录，这里面的内容会在生成 `rootfs` 镜像时覆盖在镜像的目录中。
- **`rootfs_overlay/lib/firmware/fpga.bin`** - FPGA 固件文件。
- **`device_table.txt`** - 设备文件权限列表，在生产镜像时会根据列表中的条目来设定对应文件或目录的权限属性。
- **`fakeroot.sh`** - 当所有包都编译完成后运行的附加脚本，你可以在次脚本中调整一些 `target` 目录中的文件或目录。
- **`genimage.cfg`** - 用于生成 SD 卡镜像文件的配置文件。
- **`image.its`** - 用于生成 FIT 格式镜像文件的配置文件。
- **`linux-4.14-xilinx.config`** - 包含全功能的 `linux` 内核配置文件。
- **`linux-4.14-xilinx-mini.config`** - 精简后的 `linux` 内核配置文件，用于 Flash 容量比较小的设备。
- **`mk-os-release.sh`** - 生成板子发行信息的脚本，生产的信息会存放在板子的 `/etc/os-release` 目录中。
- **`post-image.sh`** - 生成各个镜像后执行的脚本，你可以通过此脚本对生成的镜像进行额外的处理，例如发行、打包等等。
- **`pre-image.sh`**-  生成各个镜像前执行的脚本，你可以通过次脚本进行最后的镜像内容调整。
- **`uEnv.txt`** - 存在 SD 卡上的用户环境变量，设备在启动时会从 SD 卡导入到 `u-boot` 环境变量中。

开发备注
--------

### 版本分支

由于各个不同板型，可能需要在 `2018.05.1-tdc` 代码树的基础上进行裁减或修改，因此各个板型的代码都有自己的专属分支来存放这些差异内容。

在构建不同的板型时，需要检出相应的分支代码。

例如要构建 `mpcam-v1` 设备的系统：

```sh
git checkout 2018.05.1-mpcam-v1
make O=/opt/tdc/2018.05.1-mpcam-v1 ......
```

在以上命令中：`O=/opt/tdc/2018.05.1-mpcam-v1` 表示指定编译的输出目录为 `/opt/tdc/2018.05.1-mpcam-v1`，所有的编译文件源码、编译过程中生成的文件、工具链、编译好的二进制文件、最终生成的固件等等都会存在在此目录中。

**注意：** 如果你是开发、测试编译，并非用于发行，最好使用自己的编译目录，也就是将 `O=...` 的目录改为自己的目录。

> 例如：`make O=~/workspace/boards/xxxx ...`

这样你所有编译生成的结果都会存放在自己的用户目录下，不会与他人造成冲突。

### 用户认证

为了保证代码安全，属于我们公司的项目，都会被设为私有项目，需要用户认证通过后才能访问。

通常情况下用户会将用户名及密码放在 URL 中，这虽然可以解决认证问题，但是会存在用户名及密码泄露的风险。

为了防止用户名及密码泄露，我们会使用 make 变量的方式来传递用户名及密码给 buildroot，方法是：

```sh
make ... WGET_USER=xxx WGET_PASSWORD=xxxx
# 或者导出为环境变量，这样就不需要每次运行命令式都要输入
export WGET_USER=xxx WGET_PASSWORD=xxxx
make ...
```


- **`WGET_USER`** - 变量为用户名。
- **`WGET_PASSWORD`** - 变量为用户密码。

**例如：**

```sh
make O=/opt/tdc/2018.05.1-mpcam-v1 source WGET_USER=A000 WGET_PASSWORD=123456
```

**注意：**

在配置板型时，需要在 `Buildroot` 的 `menuconfig` 中设置 `Build Options -> Commands -> Wget command`。

在其命令参数行中添加：`--user=${WGET_USER} --password=${WGET_PASSWORD}`

### 使用本地开发目录进行编译

在某些情况下你需要对包源代码作出修改，然后重新编译，这是你可以使用本地覆盖目录功能来实现。

步骤如下：

1. 在编译的输出目录建立一个 `local.mk` 文件。
2. 在 `local.mk` 文件中添加一行 `{PACKAGE}_OVERRIDE_SRCDIR = {DIR}` 配置。

- `PACKAGE` 为包的名称，例如：`linux`, `libxxx`, 等等。
- `DIR` 为包的源代码所在的目录。


**示例：**

```sh
# local.mk

LINUX_OVERRIDE_SRCDIR = /home/varphone/workspace/sources/linux-stable
UBOOT_OVERRIDE_SRCDIR = /home/varphone/workspace/sources/u-boot
```

更新固件
--------

### 更新 SD 卡固件

设备上有两个 `MMC` 设备，一个是板载的 `eMMC`，一个是外置的 `SD` 卡。

在当前版本的内核中，`eMMC` 对应的是 `/dev/mmcblk0` 设备，`SD` 卡对应的是 `/dev/mmcblk1` 设备。

更新 SD 卡固件可以有多种方式，包括：设备外部更新、设备内部更新。

设备外部更新：

1. 将编译出的固件从 `xxx/images` 目录复制到你能烧录 SD 的机器上。
2. 将 SD 卡挂载到你能烧录 SD 的机器的 Linux 系统中。
3. 找到 SD 对象的设备文件，例如 `/dev/sdb`，这个设备文件一定不要搞错，否则就会损坏你系统上其他盘的数据。
4. 在 SD 卡镜像文件所在的目录中执行 `dd if=sdcard.img of=/dev/sdb bs=1` 将 SD 卡镜像文件烧录到 SD 卡中；再次警告：这个设备文件 `/dev/sdb` 一定不要搞错，否则就会损坏你系统上其他盘的数据。

设备内部更新：

1. 启动设备时在调试串口中按 `回车键` 进入 `u-boot` 环境。
2. 执行 `setenv bootconf '#ramdisk'` 将启动模式配置为 `Ramdisk` 模式。
3. 执行 `run sdboot` 或 `run qspiboot` 从 SD 或 QSPI Flash 启动系统。
4. 进入 Linux 系统后，使用 `TFTP` 或 `NFS` 将 SD 镜像文件传输到设备中。
5. 在 SD 卡镜像文件所在的目录中执行 `dd if=sdcard of=/dev/mmcblk1 bs=512` 将镜像烧录到 SD 中。

在设备内部更新 SD 固件时，推荐使用 `NFS` 方式来传输文件，关于 NFS 的使用见下面的常见问题中相关描述。

如果你不想烧录整个 `eMMC` 或 `SD` 卡，你可以将需要更新的分区挂载到系统中，然后更新其中的文件，例如：

```sh
mount /dev/mmcblk1p1 /mnt # 将 SD 卡 的 BOOT 分区挂载到 /mnt 目录
cp /nfs/mpcam-v1/images/image.itb /mnt # 使用 NFS 目录中的 image.itb 更新到 SD 卡中
sync # 同步系统缓存数据到存储设备中，确保数据完整
```

### 更新 QSPI Flash 固件

1. 将你已经更新过固件的 SD 卡插入设备中。
2. 在 u-boot 环境下运行 `run qspiupdate` 命令将 SD 上的固件更新到 QSPI Flash 中。

> 注意：更新到 QSPI Flash 中的固件大小不能超过 16MiB，否则会更新失败。

常见问题
--------

### 在 Linux 里更新 FPGA 程序

Linux 系统里提供了 Xilinx Zynq FPGA Manager 来更新 FPGA 程序。

操作方式如下：

1. 首先用 `echo 0 > /sys/class/fpga_manager/fpga0/flags` 命令清除 `fpga_manager` 的标志位。
2. 然后用 `echo fpga.bin > /sys/class/fpga_manager/fpga0/firmware` 命令向 `fpga_manager` 指定要写入的镜像文件，
   这些镜像文件须存放在 `/lib/firmware` 目录下。
3. 等待系统消息打印，当程序更新完成时，上一步的命令才会退出返回。

### 使用 NFS 传输文件及调试正常

想要在设备的 Linux 系统使用 NFS 传输文件及调试程序，你需要先在服务端配置好 NFS 服务器，当 NFS 服务器配置好后就可以按以下步骤使用。

> 推荐在配置 NFS 服务器时，将导出路径设置为：`/opt/nfs`，以下都是基于此路径进行演示。

1. 进入设备的 Linux 环境中控制台。
2. 确认当前设备的 `IP` 地址是否可以与服务器通信。
3. 使用 `mount -t nfs -o nolock 192.168.1.123:/opt/nfs /mnt` 将 `nfs` 文件系统挂载到 `/mnt` 目录下。
4. 进入 `/mnt` 目录你即可以看到你在服务器上复制到 `/opt/nfs` 里的所有文件。

### 使用工具链编译程序

假如你想单独编译某个 C/C++ 源文件，你可以使用编译好的工具链来实现。

假设你的编译输出目录是：`/opt/tdc/2018.05.1-mpcam-v1`，那么工具链程序就在 `/opt/tdc/2018.05.1-mpcam-v1/host/bin` 目录里面。

例如：

```sh
# 导出 C/C++ 编译器为环境变量，以免每次都需要输入完整路径
export CC=/opt/tdc/2018.05.1-mpcam-v1/host/bin/arm-linux-gcc
export CXX=/opt/tdc/2018.05.1-mpcam-v1/host/bin/arm-linux-g++
# 编译 test.c 并生成 test 二进制可执行文件
$CC test.c -o test
or
# 编译 test.cpp 并生成 test 二进制可执行文件
$CXX test.cpp -o test
```

### 如何恢复 u-boot 默认环境变量

当你更新固件或者有某些环境设置错误时，你可能需要恢复为默认值，其操作如下：

1. 设备开机时按 `回车键` 进入 `u-boot` 环境。
2. 执行 `env default -a -f` 将环境变量恢复为默认值。

### 如何更新设备固件中的 FPGA 固件文件

1. 将新的 FPGA 固件文替换 `board/tdc/mpcam-v1/rootfs_overlay/lib/firmware/` 目录下的 `fpga.bin`。
2. 执行 `make O=/opt/tdc/2018.05.1-mpcam-v1/ all` 重新生成固件。

如果你得到的是 `bit` 格式的文件，你需要使用 `fpga-bit-to-bin.py` 将其转换成 `bin` 文件格式，
命令使用方法如下：

```sh
fpga-bit-to-bin.py --flip fpga.bit fpga.bin
```

> 注意：`--flip` 参数不能遗缺，这是适配于 `Zynq FPGA` 的参数。
