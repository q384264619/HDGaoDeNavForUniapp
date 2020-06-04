//
//  GaoDeNavClient.m
//  testGaoDe
//
//  Created by vnetoo on 2019/7/11.
//  Copyright © 2019  All rights reserved.
//

#import "GaoDeNavClient.h"
#import "AMapNaviKit/AMapNaviKit.h"
#import "MAMapKit/MAMapKit.h"
#import "GaoDePoiInfo.h"
extern BOOL haveGaoDeConfig;
@interface GaoDeNavClient()<AMapNaviCompositeManagerDelegate>
//@property (nonatomic, strong) AMapNaviCompositeManager *compositeManager;
@end
@implementation GaoDeNavClient

static AMapNaviCompositeManager *compositeManager;

+ (instancetype)client{
    GaoDeNavClient *mself = [[GaoDeNavClient alloc] init];
    return mself;
}



- (void)startGaoDeNavTest{

    NSMutableDictionary *mdict = [NSMutableDictionary dictionary];
    NSMutableDictionary *carInfo =[NSMutableDictionary dictionary];
    [carInfo setObject:@"京N66Y66" forKey:@"carNumber"];
     [carInfo setObject:@1 forKey:@"carType"];
     [carInfo setObject:@4 forKey:@"vehicleSize"];
     [carInfo setObject:@3 forKey:@"vehicleWidth"];
     [carInfo setObject:@3.9 forKey:@"vehicleHeight"];
     [carInfo setObject:@15 forKey:@"vehicleLength"];
     [carInfo setObject:@50 forKey:@"vehicleWeight"];
     [carInfo setObject:@45 forKey:@"vehicleLoad"];
     [carInfo setObject:@6 forKey:@"vehicleAxis"];
     [carInfo setObject:@true forKey:@"vehicleLoadSwitch"];
     [carInfo setObject:@true forKey:@"restriction"];
     mdict[@"carInfo"] =carInfo;
    
    NSMutableArray *poilist = [NSMutableArray array];
    //起点
     NSMutableDictionary *first =[NSMutableDictionary dictionary];
         [first setObject:@"三元桥" forKey:@"name"];
         [first setObject:@"" forKey:@"poiid"];
       NSMutableDictionary *latlin =[NSMutableDictionary dictionary];
        [latlin setObject:@39.96087 forKey:@"latitude"];
        [latlin setObject:@116.45798 forKey:@"longitude"];
        [first setObject:latlin forKey:@"coordinate"];
     [poilist addObject:first];
    //途经
    NSMutableDictionary *way =[NSMutableDictionary dictionary];
    [way setObject:@"团结湖" forKey:@"name"];
    [way setObject:@"" forKey:@"poiid"];
    NSMutableDictionary *latlinway =[NSMutableDictionary dictionary];
    [latlinway setObject:@39.93413 forKey:@"latitude"];
    [latlinway setObject:@116.461676 forKey:@"longitude"];
    [way setObject:latlinway forKey:@"coordinate"];
    [poilist addObject:way];
    //终点
    NSMutableDictionary *end =[NSMutableDictionary dictionary];
    [end setObject:@"北京站" forKey:@"name"];
    [end setObject:@"B000A83M61" forKey:@"poiid"];
    NSMutableDictionary *latlinEnd =[NSMutableDictionary dictionary];
    [latlinEnd setObject:@39.904556 forKey:@"latitude"];
    [latlinEnd setObject:@116.427231 forKey:@"longitude"];
    [end setObject:latlinway forKey:@"coordinate"];
    [poilist addObject:end];
    
    [mdict setObject:poilist forKey:@"poiList"];
    
    [self startGaoDeNav:mdict direct:true];

}

-(void)startGaoDeNav: (NSDictionary*) dict direct:(Boolean)direct{
    NSLog(@"%@",dict);
    if(!haveGaoDeConfig)
     [NSException raise:@"have not bean configed" format:@"please config with GaoDe_APIKey "];
    
    
    if (!compositeManager) {
        compositeManager = [[AMapNaviCompositeManager alloc] init];  // 初始化
        compositeManager.delegate = self;  // 如果需要使用AMapNaviCompositeManagerDelegate的相关回调（如自定义语音、获取实时位置等），需要设置delegate
    }
    
    
    if(dict == NULL ||dict.count<=0){
        //启动
        [compositeManager presentRoutePlanViewControllerWithOptions:nil];
        return;
    }
    
    
    //导航组件配置类 since 5.2.0
    AMapNaviCompositeUserConfig *config = [[AMapNaviCompositeUserConfig alloc] init];
    
    [config setNeedDestoryDriveManagerInstanceWhenDismiss:true];
    //直接进入导航界面
    [config setStartNaviDirectly:direct];

    NSDictionary *carInfoDict = dict[@"carInfo"];
    
    if(carInfoDict!=NULL && carInfoDict.count>0){
        
        //设置车辆信息
        AMapNaviVehicleInfo *info = [[AMapNaviVehicleInfo alloc] init];
        info.vehicleId = carInfoDict[@"carNumber"]  ;//设置车牌号
        info.type = [carInfoDict[@"carType"] integerValue];              //设置车辆类型,0:小车; 1:货车. 默认0(小车).
        info.size = [carInfoDict[@"vehicleSize"] integerValue];              //设置货车的类型(大小)
        info.width = [carInfoDict[@"vehicleWidth"] floatValue];             //设置货车的宽度,范围:(0,5],单位：米
        info.height =[carInfoDict[@"vehicleHeight"] floatValue];          //设置货车的高度,范围:(0,10],单位：米
        info.length = [carInfoDict[@"vehicleLength"] floatValue];           //设置货车的长度,范围:(0,25],单位：米
        info.weight = [carInfoDict[@"vehicleWeight"] floatValue];           //设置货车的总重量,范围:(0,100]
        info.load = [carInfoDict[@"vehicleLoad"] floatValue];             //设置货车的核定载重,范围:(0,100],核定载重应小于总重量
        info.axisNums = [carInfoDict[@"vehicleAxis"] floatValue];          //设置货车的轴数（用来计算过路费及限重）
        info.isLoadIgnore=[carInfoDict[@"vehicleLoadSwitch"] boolValue];//设置车辆的载重是否参与算路
        info.isETARestriction=[carInfoDict[@"restriction"] boolValue];////设置是否躲避车辆限行。
        [config setVehicleInfo:info];
    }
    
    NSMutableArray<GaoDePoiInfo*> *mpois = [NSMutableArray array];
    
    NSArray *poislist=  dict[@"poiList"];
    
    if(poislist == NULL ||poislist.count<=0){
        //启动
        [compositeManager presentRoutePlanViewControllerWithOptions:nil];
        return;
    }
    
    for (NSDictionary* poi in poislist) {
        GaoDePoiInfo * poiInfo = [[GaoDePoiInfo alloc]init];
        poiInfo.name =poi[@"name"];
        NSDictionary *poiLat =poi[@"coordinate"];
        poiInfo.coordinate= [AMapNaviPoint locationWithLatitude:[poiLat[@"latitude"] doubleValue] longitude:[poiLat[@"longitude"] doubleValue] ];
        poiInfo.poiid =poi[@"poiid"];
        [mpois addObject:poiInfo];
    }

    
    if(mpois.count == 1){
        //传入终点，并且带高德POIId
        [config setRoutePlanPOIType:AMapNaviRoutePlanPOITypeEnd location:mpois[0].coordinate name:mpois[0].name POIId:mpois[0].poiid];
    }
    else if(mpois.count==2){
        //传入起点，并且带高德POIId
       [config setRoutePlanPOIType:AMapNaviRoutePlanPOITypeStart location:mpois[0].coordinate name:mpois[0].name POIId:mpois[0].poiid];
        //传入终点，并且带高德POIId
       [config setRoutePlanPOIType:AMapNaviRoutePlanPOITypeEnd location:mpois[1].coordinate name:mpois[1].name POIId:mpois[1].poiid];
    }
    else {
        int counts =mpois.count;
        NSLog(@"poilist conuts:%d",counts);
        //传入起点，并且带高德POIId
        [config setRoutePlanPOIType:AMapNaviRoutePlanPOITypeStart location:mpois[0].coordinate name:mpois[0].name POIId:mpois[0].poiid];
        
        for(int i=1;i<mpois.count-2;i++){
              [config setRoutePlanPOIType:AMapNaviRoutePlanPOITypeWay location:mpois[i].coordinate name:mpois[i].name POIId:mpois[i].poiid];
        }
        
        //传入终点，并且带高德POIId
        [config setRoutePlanPOIType:AMapNaviRoutePlanPOITypeEnd location:mpois[counts-1].coordinate name:mpois[counts-1].name POIId:mpois[counts-1].poiid];
        
    }
    
    //启动
    [compositeManager presentRoutePlanViewControllerWithOptions:config];
}


#pragma mark - AMapNaviCompositeManagerDelegate

// 发生错误时,会调用代理的此方法
- (void)compositeManager:(AMapNaviCompositeManager *)compositeManager error:(NSError *)error {
    NSLog(@"error:{%ld - %@}", (long)error.code, error.localizedDescription);
}

// 算路成功后的回调函数,路径规划页面的算路、导航页面的重算等成功后均会调用此方法
- (void)compositeManagerOnCalculateRouteSuccess:(AMapNaviCompositeManager *)compositeManager {
    NSLog(@"onCalculateRouteSuccess,%ld",(long)compositeManager.naviRouteID);
}

// 算路失败后的回调函数,路径规划页面的算路、导航页面的重算等失败后均会调用此方法
- (void)compositeManager:(AMapNaviCompositeManager *)compositeManager onCalculateRouteFailure:(NSError *)error {
    NSLog(@"onCalculateRouteFailure error:{%ld - %@}", (long)error.code, error.localizedDescription);
}

// 开始导航的回调函数
- (void)compositeManager:(AMapNaviCompositeManager *)compositeManager didStartNavi:(AMapNaviMode)naviMode {
    NSLog(@"didStartNavi,%ld",(long)naviMode);
}

// 当前位置更新回调
- (void)compositeManager:(AMapNaviCompositeManager *)compositeManager updateNaviLocation:(AMapNaviLocation *)naviLocation {
    NSLog(@"updateNaviLocation,%@",naviLocation);
}

// 导航到达目的地后的回调函数
- (void)compositeManager:(AMapNaviCompositeManager *)compositeManager didArrivedDestination:(AMapNaviMode)naviMode {
    NSLog(@"didArrivedDestination,%ld",(long)naviMode);
}

//// 以下注释掉的3个回调方法，如果需要自定义语音，可开启
//
//// SDK需要实时的获取是否正在进行导航信息播报，需要开发者根据实际播报情况返回布尔值
//- (BOOL)compositeManagerIsNaviSoundPlaying:(AMapNaviCompositeManager *)compositeManager {
//    return [[SpeechSynthesizer sharedSpeechSynthesizer] isSpeaking];
//}
//
//// 导航播报信息回调函数
//- (void)compositeManager:(AMapNaviCompositeManager *)compositeManager playNaviSoundString:(NSString *)soundString soundStringType:(AMapNaviSoundType)soundStringType {
//    NSLog(@"playNaviSoundString:{%ld:%@}", (long)soundStringType, soundString);
//    [[SpeechSynthesizer sharedSpeechSynthesizer] speakString:soundString];
//}
//
//// 停止导航语音播报的回调函数，当导航SDK需要停止外部语音播报时，会调用此方法
//- (void)compositeManagerStopPlayNaviSound:(AMapNaviCompositeManager *)compositeManager {
//    [[SpeechSynthesizer sharedSpeechSynthesizer] stopSpeak];
//}

- (void)compositeManager:(AMapNaviCompositeManager *_Nonnull)compositeManager didBackwardAction:(AMapNaviCompositeVCBackwardActionType)backwardActionType{
    if(backwardActionType==AMapNaviCompositeVCBackwardActionTypeDismiss){
        compositeManager.delegate = nil;
        compositeManager = nil;
    }
}

@end
