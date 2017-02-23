//
//  LoginCarrerViewController.m
//  ShiponK
//
//  Created by Bhushan on 5/11/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import "JoinCarrerViewController.h"
#include "Constant.h"
#import "VehicleTypeViewController.h"
#import "ComMehod.h"
#import "MBProgressHUD.h"
#import "IQKeyboardManager.h"

@interface JoinCarrerViewController ()
{
    NSArray *busnessArray;
    appShareManager*objappShareManager;
    ComMehod *objComMehod;
    NSString *ishome;
    NSString *bTypeid;
    
    
    
}

@end

@implementation JoinCarrerViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
      objappShareManager = [appShareManager sharedManager];
    
    objappShareManager.carrierSignupDict=[[NSMutableDictionary alloc]init];
       
    [self addChildViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"carrier_page1_vc"]];
    [self addChildViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"carrier_page2_vc"]];
    [self addChildViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"carrier_page3_vc"]];
    [self addChildViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"carrier_page4_vc"]];
    // [self addChildViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"carrier_page5_vc"]];
    
   //  [self addChildViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"carrier_page6_vc"]];
    if ([objappShareManager.CarrierProfileViewShowID isEqualToString:@"1"]) {
        
        
        
        _lbl_tital.text=[NSString stringWithFormat:@"Update Profile"];
        
    }
    else{
  
    }
    
     
       
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}



#pragma mark Back button action............................

- (IBAction)btn_backAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
