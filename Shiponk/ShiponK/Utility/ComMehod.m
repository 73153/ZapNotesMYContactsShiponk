//
//  ComMehod.m
//  ShiponK
//
//  Created by Bhushan on 5/17/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import "ComMehod.h"
#import "ApiCall.h"
#import "appShareManager.h"
#import "Reachability.h"

@implementation ComMehod

-(NSString *)checkNetworkRechability
{
    NSString* resp_val;
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Disconnected"
        //                                                        message:@"Internet Connection Failed"
        //                                                       delegate:self
        //                                              cancelButtonTitle:@"Cancel"
        //                                              otherButtonTitles:@"Ok",nil];
        //        [alert show];
        
        resp_val = [NSString stringWithFormat:@"NO"];
        
    } else {
        
        // NSLog(@"Internet is available");
        resp_val = [NSString stringWithFormat:@"YES"];
    }
    return resp_val;
}

-(void)getVehicleTypeMethod{
    @try
    {
        
        void (^successed)(id responseObject) = ^(id responseObject)
        {
            objappShareManager = [appShareManager sharedManager];
            
            NSDictionary *dict=[responseObject objectForKey:@"data"];
            
            objappShareManager.VehicleTypeArray=[dict objectForKey:@"vehicle_types"];
            
            
            objappShareManager.sFlageArray=[[NSMutableArray alloc]init];
            objappShareManager.selectVelicalArray=[[NSMutableArray alloc]init];
            
            for (int i=0;  i<objappShareManager.VehicleTypeArray.count; i++)
            {
                [objappShareManager.sFlageArray addObject:@"0"];
                
            }
        };
        
        void (^failure)(NSError * error) = ^(NSError *error)
        {
            [self getVehicleTypeMethod];
        };
        
        
        
        [ApiCall callGetWebService:API_VEHICLE_TYPE andDictionary:nil success:successed failure:failure];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
}

-(void)getTransporterCategory{
    
    @try
    {
        
        void (^successed)(id responseObject) = ^(id responseObject)
        {
            NSLog(@"%@",responseObject);
            objappShareManager = [appShareManager sharedManager];
            
            NSMutableArray *catelistArr = [responseObject valueForKey:@"data"];
            
            objappShareManager.CatagoryArr=[[NSMutableArray alloc]init];
            objappShareManager.CatagoryArr=catelistArr;
            
            objappShareManager.TransportFlageArray=[[NSMutableArray alloc]init];
            for (int i=0; i< catelistArr.count; i++) {
                
                NSMutableArray *categoryArray = [[NSMutableArray alloc] init];
                [categoryArray addObject:@"0"];
                
                NSMutableArray *tmpArr=[[NSMutableArray alloc]init];
                
                
                
                for (int j=0; j< [[[[catelistArr objectAtIndex:i]valueForKey:@"children"]valueForKey:@"category_title"] count ];j++)
                {
                    
                    [tmpArr addObject:@"0"];
                    
                }
                
                
                
                
                
                [categoryArray addObject:tmpArr];
                
                [objappShareManager.TransportFlageArray addObject:categoryArray];
                
                
            }
            
            NSLog(@"%@",objappShareManager.TransportFlageArray);
            
        };
        
        void (^failure)(NSError * error) = ^(NSError *error)
        {
            
            NSLog(@"%@",error);
            [self getTransporterCategory];
            
        };
        
        [ApiCall callGetWebService:API_CATEGORY_TREE  andDictionary:nil success:successed failure:failure];
        
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
}


-(NSString*)spacecheck:(NSString *)str{
    
    NSString *sr;
    NSCharacterSet *set = [NSCharacterSet whitespaceCharacterSet];
    if ([[str stringByTrimmingCharactersInSet: set] length] == 0)
    {
          sr=@"0";
         return sr;
    }else{
        sr=@"1";
        return sr;
    }
}


-(void)getBusineTypeMethod {
    @try
    {
       
        
        void (^successed)(id responseObject) = ^(id responseObject)
        {
             objappShareManager = [appShareManager sharedManager];
            
            NSDictionary *Dict=[responseObject objectForKey:@"data"];
            
            objappShareManager.AppbusnessArray=[Dict objectForKey:@"business_types"];
            
            
        };
        
        void (^failure)(NSError * error) = ^(NSError *error)
        {
            [self getBusineTypeMethod];
            
        };
        
        
        
        [ApiCall callGetWebService:API_BUSINESS_TYPE andDictionary:nil success:successed failure:failure];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
}




@end
