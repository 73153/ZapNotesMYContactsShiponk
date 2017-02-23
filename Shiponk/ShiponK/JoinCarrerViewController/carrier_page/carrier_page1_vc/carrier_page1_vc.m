//
//  carrier_page1_vc.m
//  ShiponK
//
//  Created by Bhushan on 5/23/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import "carrier_page1_vc.h"
#import "JoinCarrerViewController.h"
#import "base_carrier_vc.h"
#import "ComMehod.h"
#import "appShareManager.h"
#import "ApplicationData.h"
#import "carrier_page2_vc.h"


@interface carrier_page1_vc ()
{
    ComMehod* objComMehod;
    appShareManager* objappShareManager;
    

    NSString *isHome;
}
@end

@implementation carrier_page1_vc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    objComMehod=[[ComMehod alloc]init];
    isHome=@"1";
    
     objappShareManager = [appShareManager sharedManager];
    
    
    if ([objappShareManager.CarrierProfileViewShowID isEqualToString:@"1"]) {
        _txt_confirmemailaddress.userInteractionEnabled=NO;
         _txt_emailaddress.userInteractionEnabled=NO;
          [self getCarrierSignupData];
    }
    else{
        _txt_confirmemailaddress.userInteractionEnabled=YES;
        _txt_emailaddress.userInteractionEnabled=YES;
    }
    
    
  
    
    
    
}
-(void)getCarrierSignupData
{
    

            NSMutableArray *Arr=[[NSMutableArray alloc]init];
            Arr=[objappShareManager.carrierProfileDataDict valueForKey:@"data"];
    
            
            
            _txt_firstname.text=[NSString stringWithFormat:@"%@",[[Arr objectAtIndex:0]valueForKey:@"first_name"]];
            
            _txt_lastname.text=[NSString stringWithFormat:@"%@",[[Arr objectAtIndex:0]valueForKey:@"last_name"]];
            
            _txt_emailaddress.text=[NSString stringWithFormat:@"%@",[[Arr objectAtIndex:0]valueForKey:@"email"]];
            
            _txt_confirmemailaddress.text=[NSString stringWithFormat:@"%@",[[Arr objectAtIndex:0]valueForKey:@"email"]];
            
            _txt_mobilenumber.text=[NSString stringWithFormat:@"%@",[[Arr objectAtIndex:0]valueForKey:@"mobile_number"]];
            
            NSString *strhome=[[Arr valueForKey:@"is_home"]objectAtIndex:0];
            
            if ([strhome isEqualToString:@"1"])
            {
                
                [self btn_homeAction:nil];
                
            }else{
                
                [self btn_officeAction:nil];
                
            }

            
//            
//        };
//        
//        void (^failure)(NSError * error) = ^(NSError *error)
//        {
//            [self getCarrierSignupData];
//        };
//        
//        
//        [ApiCall sendToService:API_USER_PROFILE andDictionary:dicttt success:successed failure:failure];
//    }
//    @catch (NSException *exception) {
//        [APPDATA hideLoader];
//        
//    }
//    @finally {
//        [APPDATA hideLoader];
//        
//    }


    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
        objappShareManager.carrierSignupDict = [[NSMutableDictionary alloc]init];
    
    if ([objappShareManager.carrierSignupDict count]>0)
    {
        _txt_firstname.text=[objappShareManager.carrierSignupDict valueForKey:@"firstname"];
        _txt_lastname.text=[objappShareManager.carrierSignupDict valueForKey:@"lastname"];
        
        _txt_emailaddress.text=[objappShareManager.carrierSignupDict valueForKey:@"emailaddress"];
        _txt_confirmemailaddress.text=[objappShareManager.carrierSignupDict valueForKey:@"emailaddress"];
        
         _txt_mobilenumber.text=[objappShareManager.carrierSignupDict valueForKey:@"mobilenumber"];
        
        NSString *strhome=[objappShareManager.carrierSignupDict valueForKey:@"isHome"];
        
        if ([strhome isEqualToString:@"1"])
        {
            
            [self btn_homeAction:nil];
            
        }else{
            
            [self btn_officeAction:nil];
            
        }
        
        
    }
    
}





- (IBAction)btn_ContinueAction_1:(id)sender
{
    
    
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,10}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    
    if([[objComMehod spacecheck:_txt_firstname.text]isEqualToString:@"0"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter first name." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else if([[objComMehod spacecheck:_txt_lastname.text]isEqualToString:@"0"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter list name." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    
    else if ([emailTest evaluateWithObject:_txt_emailaddress.text] == NO) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please Enter Valid Email Address." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    } else if ([emailTest evaluateWithObject:_txt_confirmemailaddress.text] == NO) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please Enter Valid confirm Email Address." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }else if(![_txt_emailaddress.text isEqualToString:_txt_confirmemailaddress.text])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Email address do not match" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else if([[objComMehod spacecheck:_txt_mobilenumber.text ] isEqualToString:@"0"]){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter mobile number." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }else if([_txt_password.text length] <7){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please Enter password maximum 8 character." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }else if(![_txt_password.text isEqualToString:_txt_conf_password.text]){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Password do not match" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
    
         [objappShareManager.carrierSignupDict setObject:_txt_firstname.text forKey:@"firstname"];
        
         [objappShareManager.carrierSignupDict setObject:_txt_lastname.text forKey:@"lastname"];
        
         [objappShareManager.carrierSignupDict setObject:_txt_confirmemailaddress.text forKey:@"emailaddress"];
    
         [objappShareManager.carrierSignupDict setObject:isHome forKey:@"isHome"];
        
         [objappShareManager.carrierSignupDict setObject:_txt_mobilenumber.text forKey:@"mobilenumber"];
        
         [objappShareManager.carrierSignupDict setObject:_txt_conf_password.text forKey:@"password"];
        
        
        
//    [[NSNotificationCenter defaultCenter]
//     postNotificationName:@"VehicalSet"
//     object:nil];
        carrier_page2_vc  *objviewController =(carrier_page2_vc *) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"carrier_page2_vc"];
        
        
        [APPDATA pushNewViewController:objviewController];
        
        
        
    }

    
}




- (IBAction)btn_homeAction:(id)sender {
    
    
    isHome=@"1";
    
    _imgOfficePhn.hidden=YES;
    _imgHomePhn.hidden=NO;
    
    UIImage *btnImage = [UIImage imageNamed:@"check.png"];
    [_btnhome setImage:btnImage forState:UIControlStateNormal];
    
    
    UIImage *btnImage1 = [UIImage imageNamed:@"uncheck.png"];
    [_btnoffice setImage:btnImage1 forState:UIControlStateNormal];
    
}

- (IBAction)btn_officeAction:(id)sender
{
    isHome=@"2";
    _imgOfficePhn.hidden=NO;
    _imgHomePhn.hidden=YES;

    
    UIImage *btnImage = [UIImage imageNamed:@"check.png"];
    [_btnoffice setImage:btnImage forState:UIControlStateNormal];
    
    UIImage *btnImage1 = [UIImage imageNamed:@"uncheck.png"];
    [_btnhome setImage:btnImage1 forState:UIControlStateNormal];
}

- (IBAction)btnBackAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
