//
//  ApiCall.h
//  ShiponK
//
//  Created by Bhushan on 5/13/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "Constant.h"
@interface ApiCall : NSObject
typedef void(^completion_handler_t)(NSMutableDictionary *, NSError*error, long code);
typedef void(^dashboard_completion_block)(NSDictionary *result,NSString *, int status);

+(void) sendToService:(NSString *)urlStr andDictionary:(NSDictionary *)parameter success:(void (^)(id responseObject_))success_ failure:(void (^)(NSError* _error))failure_ ;

+(void)callGetWebService:(NSString *)urlStr andDictionary:(NSDictionary *)parameter success:(void (^)(id responseObject_))success_ failure:(void (^)(NSError* _error))failure_ ;
+(void) sendToServices:(NSString *)urlStr andDictionary:(NSDictionary *)parameter success:(void (^)(id responseObject_))success_ failure:(void (^)(NSError* _error))failure_ ;


@end
