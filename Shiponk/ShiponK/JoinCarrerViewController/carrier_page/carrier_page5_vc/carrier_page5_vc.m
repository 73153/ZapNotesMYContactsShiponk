//
//  carrier_page5_vc.m
//  ShiponK
//
//  Created by Bhushan on 5/24/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import "carrier_page5_vc.h"
#import "appShareManager.h"
#import "ComMehod.h"

@interface carrier_page5_vc ()
{
     appShareManager *objappShareManager;
    
     ComMehod *objComMehod;
    
}
@end

@implementation carrier_page5_vc

- (void)viewDidLoad {
    [super viewDidLoad];
   objappShareManager = [appShareManager sharedManager];
    
    objComMehod=[[ComMehod alloc]init];
    
    
     if ([objappShareManager.CarrierProfileViewShowID isEqualToString:@"1"]) {
         
         NSMutableArray *Arr=[[NSMutableArray alloc]init];
         Arr=[objappShareManager.carrierProfileDataDict valueForKey:@"profile"];
         NSLog(@"%@",objappShareManager.carrierProfileDataDict);
         
         
         _txt_bankName.text=[NSString stringWithFormat:@"%@",[[Arr objectAtIndex:0]valueForKey:@"bank_name"]];
         
         _txt_accountNumber.text=[NSString stringWithFormat:@"%@",[[Arr objectAtIndex:0]valueForKey:@"bank_account_no"]];
         
         _txt_ac_holder.text=[NSString stringWithFormat:@"%@",[[Arr objectAtIndex:0]valueForKey:@"account_holder_name"]];
         
         _txt_bank_IFSC.text=[NSString stringWithFormat:@"%@",[[Arr objectAtIndex:0]valueForKey:@"ifsc_code"]];
         
         _txt_pan_number.text=[NSString stringWithFormat:@"%@",[[Arr objectAtIndex:0]valueForKey:@"pan_number"]];
         
         _txt_cst_number.text=[NSString stringWithFormat:@"%@",[[Arr objectAtIndex:0]valueForKey:@"cst_number"]];

     }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)btn_ContinueAction:(id)sender
{
    if([[objComMehod spacecheck:_txt_bankName.text] isEqualToString:@"0"]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter bank name." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else if([[objComMehod spacecheck:_txt_accountNumber.text] isEqualToString:@"0"]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter bank account number." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else if([[objComMehod spacecheck:_txt_ac_holder.text] isEqualToString:@"0"]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter bank account holder." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else if([[objComMehod spacecheck:_txt_bank_IFSC.text] isEqualToString:@"0"]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter bank branch IFSC. " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else if([[objComMehod spacecheck:_txt_pan_number.text] isEqualToString:@"0"]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter pan number. " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else if([[objComMehod spacecheck:_txt_cst_number.text] isEqualToString:@"0"]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter CST. " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else
    {

    [objappShareManager.carrierSignupDict setObject:_txt_bankName.text forKey:@"bankname"];
    
    [objappShareManager.carrierSignupDict setObject:_txt_accountNumber.text forKey:@"accountNumber"];
        
    [objappShareManager.carrierSignupDict setObject:_txt_ac_holder.text forKey:@"ac_holder"];
        
    [objappShareManager.carrierSignupDict setObject:_txt_bank_IFSC.text forKey:@"bank_IFSC"];
        
    [objappShareManager.carrierSignupDict setObject:_txt_pan_number.text forKey:@"pan_number"];
        
    [objappShareManager.carrierSignupDict setObject:_txt_cst_number.text forKey:@"cst_number"];
    
        
        
        
        
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"VehicalSet"
     object:nil];
    }
}
@end
