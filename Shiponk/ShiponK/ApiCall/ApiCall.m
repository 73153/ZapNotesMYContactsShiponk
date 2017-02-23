//
//  ApiCall.m
//  ShiponK
//
//  Created by Bhushan on 5/13/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import "ApiCall.h"


@implementation ApiCall
+(void) sendToService:(NSString *)urlStr andDictionary:(NSDictionary *)parameter success:(void (^)(id responseObject_))success_ failure:(void (^)(NSError* _error))failure_
{
   
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    AFJSONResponseSerializer *jsonReponseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
   
    jsonReponseSerializer.acceptableContentTypes = nil;
    manager.responseSerializer = jsonReponseSerializer;
    
    
    jsonReponseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        
        if(success_)
        {
            success_(responseObject);
            
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ////DEBUGLog(@"Error : %@", error.description);
        if(failure_) {
            failure_(error);
        }
    }];
}


+(void)callGetWebService:(NSString *)urlStr andDictionary:(NSDictionary *)parameter success:(void (^)(id responseObject_))success_ failure:(void (^)(NSError* _error))failure_ {
    
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    
    AFJSONResponseSerializer *jsonReponseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    jsonReponseSerializer.acceptableContentTypes = nil;
    manager.responseSerializer = jsonReponseSerializer;
    
    
    
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSLog(@"JSON: %@", responseObject);
        if(success_)
        {
            success_(responseObject);
            
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        if(failure_) {
            failure_(error);
        }
    }];
}
+(void) sendToServices:(NSString *)urlStr andDictionary:(NSDictionary *)parameter success:(void (^)(id responseObject_))success_ failure:(void (^)(NSError* _error))failure_
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
  manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSLog(@"JSON: %@", responseObject);
        if(success_)
        {
            success_(responseObject);
            
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        if(failure_) {
            failure_(error);
        }
    }];

}



@end
