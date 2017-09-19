# Board: LCDS-500-II

数字像源设备，第一版，基于 IMX6Q 平台构建。

## GnuPG 信息

- 默认标识：`lcds-500-ii`
- 证书密码：`d3XhwcYv`

## NAND 分区

- `barebox` *4M* - 存放 barebox 启动器。
- `barebox-environment` *1M* - 存放 barebox 环境变量。
- `root` *(剩余空间)* - UBI 设备分区。

### UBI 设备分区

- `primary` *256M* - 主根目录分区。
- `secondary` *256* - 备根目录分区。
- `security`*64M* - 安全分区，存放安全及启动相关数据，在恢复出厂值时，这些数据依然存在。
- `data` *256M* - 用户数据分区，存放用户应用程序相关的数据。
- `cache` *(剩余空间)* - 存放可变的文件或设备在出厂后安装的程序或更新，通过 overlayfs 覆盖在只读的 rootfs 之上。


## 分区挂载点

分区       | 挂载点      | 备注
-----------|-------------|----------------------------
primary    | /           | 根据启动设定选择性加载
secondary  | /           | 根据启动设定选择性加载
security   | /security   |
data       | /data       |
cache      | /           | 以 overlayfs 方式覆盖在根目录上


## 注意事项


