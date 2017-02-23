//
//  ComMehod.h
//  ShiponK
//
//  Created by Bhushan on 5/17/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "appShareManager.h"

@interface ComMehod : NSObject
{
     appShareManager *objappShareManager;
}
-(void)getVehicleTypeMethod;
-(NSString *)checkNetworkRechability;
-(NSString*)spacecheck:(NSString *)str;
-(void)getBusineTypeMethod;
-(void)getTransporterCategory;

-(void)cancelBid :(NSString *)spid;

@end
