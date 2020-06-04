# 高德地图导航的插件
为uniapp在iOS使用原生高德地图导航的插件

**注意本插件目录只支持离线打包方式需要对xcode配制有一定了解**

# 使用方式

使用方式也很简单，几步就可以解决：

1. 到官网下载IOSSDK[传送门](https://nativesupport.dcloud.net.cn/AppDocs/download/ios) 到本地 如: /Users/test/Downloads/IOSSDK

2. 克隆本插件

    ```bash
     git clone  https://github.com/q384264619/HDGaoDeNavForUniapp.git
    ```
3. 复制**GaoDeNavPlusSource**到IOSSDK目录下面 结构如下：

   ```
    iOSSDK@2.0.1.64837_20190614
    ├── GaoDeNavPlusSource
    │   ├── AMapNaviKit.framework
    │   ├── DerivedData
    │   ├── GaoDeNavLib
    │   ├── HBuilder-Integrate
    │   └── HBuilder-Integrate.xcodeproj
    └── SDK
        ├── Bundles
        ├── Libs
        └── inc
   ```   

4. 使用xcode打开**GaoDeNavPlusSource** 或双击**HBuilder-Integrate.xcodeproj**

5. 打开**amapinfo.plist**填写高德api key  如下：
   
   




