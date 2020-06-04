//
//  GaoDeNavModule.m
//  GaoDeNavLib
//
//  Created by vnetoo on 2019/7/12.
//  Copyright © 2019 . All rights reserved.
//

#import "DCGaoDeNavModule.h"
#import "GaoDeNavClient.h"
@implementation DCGaoDeNavModule
GaoDeNavClient *client;
@synthesize weexInstance;

- (instancetype)init
{
    self = [super init];
    if (self) {
        client =[GaoDeNavClient client] ;
    }
    return self;
}

WX_EXPORT_METHOD(@selector(startGaoDeNav:direct:))
WX_EXPORT_METHOD(@selector(startGaoDeNavTest))


-(void)startGaoDeNav: (NSDictionary*) dict direct:(Boolean)direct{
    [client startGaoDeNav:dict direct:direct];
    
}

- (void)startGaoDeNavTest{
      [client startGaoDeNavTest];
}
@end
