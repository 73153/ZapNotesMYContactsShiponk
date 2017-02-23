//
//  appShareManager.h
//  ShiponK
//
//  Created by Bhushan on 5/13/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface appShareManager : NSObject{
 NSString *loginUserFlage;
}

@property (nonatomic, retain) NSString *loginUserFlage;
@property (nonatomic, retain) NSDictionary *loginDic;
@property (nonatomic, retain) NSArray *VehicleTypeArray;
@property(strong,nonatomic)NSMutableArray *sFlageArray;
@property(strong,nonatomic)NSMutableArray *selectVelicalArray;
@property(strong,nonatomic)NSMutableArray *selectVelicalidArray;
@property (nonatomic, retain) NSString *remberMeStr;
@property (nonatomic, retain) NSString *Loginid;
@property(strong,nonatomic)NSMutableArray *AppbusnessArray;
@property (nonatomic, retain) NSMutableDictionary *carrierSignupDict;
@property (nonatomic, retain) NSString *ProfileViewShowID;
@property (nonatomic, retain) NSString *CarrierProfileViewShowID;
@property (nonatomic, retain) NSMutableDictionary *carrierProfileDataDict;
@property(nonatomic,retain)NSMutableDictionary * New_shipment_dic;
@property(nonatomic,retain)NSMutableArray *addAnItemArray,*addAnItemArray2, *arrAddBranch;

@property(nonatomic,retain)NSString *user_id;
@property(nonatomic,retain)NSString *Shipment_id;
@property(nonatomic,retain)NSString *ratingStr;



@property(strong,nonatomic)NSMutableArray *TransportFlageArray;
@property(nonatomic,retain)NSMutableArray *CatagoryArr;

@property(nonatomic,retain)NSMutableDictionary *SelectedCatagoryDic;

@property(nonatomic,retain)NSString *device_tokenApp;

@property(nonatomic,retain)NSString *pickResid;
@property(nonatomic,retain)NSString *DeliResid;

@property(nonatomic,retain)NSString *pickResname;
@property(nonatomic,retain)NSString *DeliResname;

@property(nonatomic,retain)NSString *carrieridStr;

@property(nonatomic,retain)NSString *catagoryIdStrForAdditem,*subCatagoryIdStrForAnimalBreed;



@property(nonatomic,retain)NSString *L_FNameStr;

@property(nonatomic,retain)NSString *L_P_FStr;

+ (id)sharedManager;
@end
