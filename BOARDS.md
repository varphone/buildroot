# BOARDS

技术开发公司研发部自行研发的嵌入式产品各种板型说明。


## 目录说明

- `/board/tdc/` 技术开发公司的板型目录。
- `/board/myzr/` 明远智睿的板型目录。
- `/configs/` 存放各个板型默认配置文件的目录。


## 开发备注

### 版本分支

由于各个不同板型，可能需要在 master 代码树的基础上进行裁减或修改，因此各个板型的代码都有自己的专属分支来存放这些差异内容。

在构建不同的板型时，需要检出相应的分支代码。

> 例如要构建 PPMD-V1 设备的系统

> ```
git checkout ppmd-v1
make O=/opt/tdc/ppmd-v1 ......
```

**注意：**如果你是开发、测试编译，并非用于发行，最好使用自己的编译目录，也就是将 `O=...` 的目录改为自己的目录。

> 例如：`make O=~/workspace/boards/xxxx ...`

这样你所有编译生成的结果都会存放在自己的用户目录下，不会与他人造成冲突。



### 用户认证

为了保证代码安全，属于我们公司的项目，都会被设为私有项目，需要用户认证通过后才能访问。

通常情况下用户会将用户名及密码放在 URL 中，这虽然可以解决认证问题，但是会存在用户名及密码泄露的风险。

为了防止用户名及密码泄露，我们会使用 make 变量的方式来传递用户名及密码给 buildroot，方法是：

```
make ... WGET_USER=xxx WGET_PASSWORD=xxxx
```

- `WGET_USER` 变量为用户名。
- `WGET_PASSWORD` 变量为用户密码。


**例如：**

```
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

```
# local.mk

LINUX_OVERRIDE_SRCDIR = /home/varphone/workspace/sources/linux-stable
LIBAVT_OVERRIDE_SRCDIR = /home/varphone/workspace/projects/libavt
#LIBPWC_OVERRIDE_SRCDIR = /home/varphone/workspace/projects/libpwc
PPMD_3531_OVERRIDE_SRCDIR = /home/varphone/workspace/projects/ppmd-3531

```



## Board: myzr/myimx6ek200-6q

明远智睿的 IMX6 开发板。

### Build

```
make O=/opt/myzr/myimxek200-6q-4.1.15 myzr_myimx6ek200_6q_4.1.15_defconfig
make O=/opt/myzr/myimxek200-6q-4.1.15 source WGET_USER=... WGET_PASSWORD=...
make O=/opt/myzr/myimxek200-6q-4.1.15
```

## Board: tdc/6a-v2

新 6A 板子。

### Build

```
make O=/opt/tdc/6a-v2 tdc_6a_v2_defconfig
make O=/opt/tdc/6a-v2 source WGET_USER=... WGET_PASSWORD=...
make O=/opt/tdc/6a-v2
```


## Board: tdc/etlmd-v2

输电线路监控设备(第二版)，基于低功耗 `x86_64` 平台构建。

[详细资料](board/tdc/etlmd-v2/README.md)

### Build

```
make O=/opt/tdc/etlmd-v2 tdc_etlmd_v2_defconfig
make O=/opt/tdc/etlmd-v2 source WGET_USER=... WGET_PASSWORD=...
make O=/opt/tdc/etlmd-v2
```


## Board: tdc/ppmd-v1

光浮台电监控设备(第一版)，基于 `Hi3531` 平台。

[详细资料](board/tdc/ppmd-v1/README.md)

### Prepare

执行 `Build` 之前，请确认当前代码库是否已经处于 `ppmd-v1` 分支，如果没有，执行 `git checkout ppmd-v1` 检出。


### Build

```
make O=/opt/tdc/ppmd-v1 tdc_ppmd_v1_defconfig
make O=/opt/tdc/ppmd-v1 source WGET_USER=... WGET_PASSWORD=...
make O=/opt/tdc/ppmd-v1
```


