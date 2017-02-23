//
//  appShareManager.m
//  ShiponK
//
//  Created by Bhushan on 5/13/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import "appShareManager.h"

@implementation appShareManager
@synthesize loginUserFlage;




+ (id)sharedManager {
    static appShareManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}
- (id)init {
    if (self = [super init]) {
        ;
        self.New_shipment_dic = [[NSMutableDictionary alloc] init];
        self.addAnItemArray = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}
@end
