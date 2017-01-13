# BOARDS

技术开发公司研发部自行研发的嵌入式产品各种板型说明。


## 目录说明

- `/board/tdc/` 技术开发公司的板型目录。
- `/board/myzr/` 明远智睿的板型目录。
- `/configs/` 存放各个板型默认配置文件的目录。


## Board: myzr/myimx6ek200-6q

明远智睿的 IMX6 开发板。

### Build

```
make O=/opt/myzr/myimxek200-6q-4.1.15 myzr_myimx6ek200_6q_4.1.15_defconfig
make O=/opt/myzr/myimxek200-6q-4.1.15 source
make O=/opt/myzr/myimxek200-6q-4.1.15
```

## Board: tdc/6a-v2

新 6A 板子。

### Build

```
make O=/opt/tdc/6a-v2 tdc_6a_v2_defconfig
make O=/opt/tdc/6a-v2 source
make O=/opt/tdc/6a-v2
```


## Board: tdc/etlmd-v2

输电线路监控设备(第二版)，基于低功耗 `x86_64` 平台构建。

[详细资料](board/tdc/etlmd-v2/README.md)

### Build

```
make O=/opt/tdc/etlmd-v2 tdc_etlmd_v2_defconfig
make O=/opt/tdc/etlmd-v2 source
make O=/opt/tdc/etlmd-v2
```


## Board: tdc/ppmd-v1

光浮台电监控设备(第一版)，基于 `Hi3531` 平台。

[详细资料](board/tdc/ppmd-v1/README.md)

### Build

```
make O=/opt/tdc/ppmd-v1 tdc_ppmd_v1_defconfig
make O=/opt/tdc/ppmd-v1 source
make O=/opt/tdc/ppmd-v1
```


