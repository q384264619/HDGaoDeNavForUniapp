//
//  GaoDePoiInfo.h
//  testGaoDe
//
//  Created by vnetoo on 2019/7/11.
//  Copyright © 2019  All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMapNaviKit/AMapNaviKit.h"
NS_ASSUME_NONNULL_BEGIN

@interface GaoDePoiInfo : NSObject
@property(nonatomic,copy)NSString * name;
@property(nonatomic,strong) AMapNaviPoint * coordinate;
@property(nonatomic,copy)NSString * poiid;
@end

NS_ASSUME_NONNULL_END
