cvr-mil-v2
==========

技术开发公司研发部自行研发的嵌入式产品各种板型说明。

目录说明
--------

- `/board/tdc/` 技术开发公司的板型目录。
- `/configs/` 存放各个板型默认配置文件的目录。

开发备注
--------

### 版本分支

由于各个不同板型，可能需要在 `2017.11-tdc` 代码树的基础上进行裁减或修改，因此各个板型的代码都有自己的专属分支来存放这些差异内容。

在构建不同的板型时，需要检出相应的分支代码。

> 例如要构建 CVR-MIL-V2 设备的系统

> ```sh
git checkout 2017.11-cvr-mil-v2-viv-5.x
make O=/opt/tdc/2017.11-cvr-mil-v2-5.x ......
```

**注意：**如果你是开发、测试编译，并非用于发行，最好使用自己的编译目录，也就是将 `O=...` 的目录改为自己的目录。

> 例如：`make O=~/workspace/boards/xxxx ...`

这样你所有编译生成的结果都会存放在自己的用户目录下，不会与他人造成冲突。

### 用户认证

为了保证代码安全，属于我们公司的项目，都会被设为私有项目，需要用户认证通过后才能访问。

通常情况下用户会将用户名及密码放在 URL 中，这虽然可以解决认证问题，但是会存在用户名及密码泄露的风险。

为了防止用户名及密码泄露，我们会使用 make 变量的方式来传递用户名及密码给 buildroot，方法是：

```sh
make ... WGET_USER=xxx WGET_PASSWORD=xxxx
```

- `WGET_USER` 变量为用户名。
- `WGET_PASSWORD` 变量为用户密码。

**例如：**

```sh
make O=/opt/company/board source WGET_USER=A000 WGET_PASSWORD=123456
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

```file
# local.mk

LINUX_OVERRIDE_SRCDIR = /home/varphone/workspace/sources/linux-stable
UBOOT_OVERRIDE_SRCDIR = /home/varphone/workspace/sources/u-boot
#CVR_MIL_QT_OVERRIDE_SRCDIR = /home/varphone/workspace/projects/cvr-mil-qt
#GSTVAFILTERS_OVERRIDE_SRCDIR = /home/varphone/workspace/projects/gstvafilters
```

Board: cvr-mil-v2
-----------------

军用车载行车记录仪，第二版，采用投影方式呈现，基于 `IMX6Q+Qt5.6` 构建。

[详细资料](board/tdc/cvr-mil-v2/README.md)

### Prepare

执行 `Build` 之前，请确认当前代码库是否已经处于 `2017.11-cvr-mil-v2-viv-5.x` 分支，如果没有，执行 `git checkout 2017.11-cvr-mil-v2-viv-5.x` 检出。

### Build

```sh
make O=/opt/tdc/2017.11-cvr-mil-v2-viv-5.x tdc_cvr_mil_v2_defconfig
make O=/opt/tdc/2017.11-cvr-mil-v2-viv-5.x source WGET_USER=... WGET_PASSWORD=...
make O=/opt/tdc/2017.11-cvr-mil-v2-viv-5.x
```

Board: cvr-mil-v2-a
-------------------

平板车载辅助驾驶系统，第二版，采用 HDMI 液晶屏方式呈现，基于 `IMX6Q+Qt5.6` 构建。

[详细资料](board/tdc/cvr-mil-v2-a/README.md)

### Prepare

执行 `Build` 之前，请确认当前代码库是否已经处于 `2017.11-cvr-mil-v2-viv-5.x` 分支，如果没有，执行 `git checkout 2017.11-cvr-mil-v2-viv-5.x` 检出。

### Build

```sh
make O=/opt/tdc/2017.11-cvr-mil-v2-a-viv-5.x tdc_cvr_mil_v2_a_defconfig
make O=/opt/tdc/2017.11-cvr-mil-v2-a-viv-5.x source WGET_USER=... WGET_PASSWORD=...
make O=/opt/tdc/2017.11-cvr-mil-v2-a-viv-5.x
```

Board: cvr-mil-v2-b
-------------------

博宇车载辅助驾驶系统，第二版，采用 LVDS 液晶屏方式呈现，基于 `IMX6Q+Qt5.6` 构建。

[详细资料](board/tdc/cvr-mil-v2-b/README.md)

### Prepare

执行 `Build` 之前，请确认当前代码库是否已经处于 `2017.11-cvr-mil-v2-viv-5.x` 分支，如果没有，执行 `git checkout 2017.11-cvr-mil-v2-viv-5.x` 检出。

### Build

```sh
make O=/opt/tdc/2017.11-cvr-mil-v2-b-viv-5.x tdc_cvr_mil_v2_b_defconfig
make O=/opt/tdc/2017.11-cvr-mil-v2-b-viv-5.x source WGET_USER=... WGET_PASSWORD=...
make O=/opt/tdc/2017.11-cvr-mil-v2-b-viv-5.x
```

