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
4. 到高德网站下载导航依赖包 [传送门](https://lbs.amap.com/api/ios-navi-sdk/download/)  
5. 将下载的**AMapNaviKit.framework** 放到下载的源码中:(本来想一起上传，但超过100M了gitHub不让上传，没有办法，各位自己下载吧。)
   
    ```
    GaoDeNavPlusSource
    ├── AMapNaviKit.framework
    │   ├── AMap.bundle
    │   ├── AMapNavi.bundle
    │   ├── Headers
    │   └── Modules
    ├── DerivedData
    │   ├── HBuilder-Integrate
    │   └── ModuleCache.noindex
    ├── GaoDeNavLib
    │   ├── GaoDeNavLib
    │   └── GaoDeNavLib.xcodeproj
    ├── HBuilder-Integrate
    │   ├── Base.lproj
    │   ├── Pandora
    │   ├── en.lproj
    │   ├── icon
    │   └── splash
    └── HBuilder-Integrate.xcodeproj
        ├── project.xcworkspace
        └── xcuserdata
   ```
6. 使用xcode打开**GaoDeNavPlusSource** 或双击**HBuilder-Integrate.xcodeproj**
8. 修改bundleID :

   ![alt 修改bundleID](https://github.com/q384264619/HDGaoDeNavForUniapp/blob/master/cap1.png)
   

9. 打开**amapinfo.plist**填写高德api key  如下：

    ![alt ](https://github.com/q384264619/HDGaoDeNavForUniapp/blob/master/cap2.png)


   
10. 修改证书内容(如果是模拟器运行，则不用此过程):

  
     ![alt ](https://github.com/q384264619/HDGaoDeNavForUniapp/blob/master/cap3.png)



# 结束

 ![](https://img.cdn.aliyun.dcloud.net.cn/stream/plugin_screens/37b935c0-a4ab-11e9-94c2-07d75fe37f11_0.png?v=1591168937)




