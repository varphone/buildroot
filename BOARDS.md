# BOARDS

技术开发公司各种板型说明。


## 目录说明

- /board/tdc/ 技术开发公司的板型目录。
- /board/myzr/ 明远智睿的板型目录。
- /configs/ 存放各个板型默认配置文件的目录。


## myzr/myimx6ek200-6q

明远智睿的 IMX6 开发板。

### Build

```
export O=/opt/myzr/myimxek200-6q-4.1.15
make myzr_myimx6ek200_6q_4.1.15_defconfig
make source
make
```

## tdc/6a-v2

新 6A 板子。

### Build

```
export O=/opt/tdc/6a-v2
make tdc_6a_v2_defconfig
make source
make
```


## tdc/etlmd-v2

