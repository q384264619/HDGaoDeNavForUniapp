//
//  DCGaoDeNavProxy.m
//  GaoDeNavLib
//
//  Created by vnetoo on 2019/7/12.
//  Copyright © 2019  All rights reserved.
//

#import "DCGaoDeNavProxy.h"
#import "AMapNaviKit/AMapNaviKit.h"
BOOL haveGaoDeConfig;
@implementation DCGaoDeNavProxy

- (void)onCreateUniPlugin {
    NSLog(@"onCreateUniPlugin  GaoDeNav plugin start");
}

- (BOOL)application:(UIApplication *_Nullable)application didFinishLaunchingWithOptions:(NSDictionary *_Nullable)launchOptions{
  NSLog(@"onCreateUniPlugin  application didFinishLaunchingWithOptions start");
    NSString *plistPath= [[NSBundle mainBundle] pathForResource:@"amapinfo" ofType:@"plist"];
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    if(dictionary[@"AMAPSDK"]!=nil){
        [AMapServices sharedServices].apiKey = dictionary[@"AMAPSDK"];
        haveGaoDeConfig = true;
        NSLog(@"onCreateUniPlugin  GaoDeNav configed Success");
    }
    else
    {
        NSLog(@"onCreateUniPlugin  can not find AMAPSDK in Info.plist");
        haveGaoDeConfig= false;
    }

    return YES;
}

@end


