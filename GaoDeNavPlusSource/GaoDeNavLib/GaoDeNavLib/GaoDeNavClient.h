//
//  GaoDeNavClient.h
//  testGaoDe
//
//  Created by vnetoo on 2019/7/11.
//  Copyright © 2019  All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GaoDeNavClient : NSObject
-(void)startGaoDeNavTest;
-(void)startGaoDeNav:(NSDictionary*)dict direct:(Boolean)direct;
+(instancetype) client;
@end

NS_ASSUME_NONNULL_END
