//
//  Create_Bid_ViewController.m
//  ShiponK
//
//  Created by krutagn on 10/06/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import "Create_Bid_ViewController.h"
#import "Constant.h"
#import "ComMehod.h"
#import "ApiCall.h"
#import "ApplicationData.h"
#import "appShareManager.h"
#import "Transporter_Description_ViewController.h"


@interface Create_Bid_ViewController ()<UIAlertViewDelegate,UITextViewDelegate>
{
    appShareManager *objappsharemanager;
    NSDictionary *bidDict,*bidDataDict;
    NSString *ShipmentidStr;
    NSString *tandCStr;
    NSString *ComStr;
    IBOutlet UIButton *btn_sumit;
}
@property (strong, nonatomic) IBOutlet UIButton *btn_tandC;
@property (strong, nonatomic) IBOutlet UIButton *btn_5Commissiom;
@end

@implementation Create_Bid_ViewController
@synthesize txt_Amount,txt_View_T_and_C,strAmount,strDecs,strEdit;

- (void)viewDidLoad
{
    [super viewDidLoad];
    objappsharemanager = [appShareManager sharedManager];
    
    if ([strEdit isEqualToString:@"1"])
    {
        self.txt_View_T_and_C.text=strDecs;
        self.txt_Amount.text=strAmount;
        [btn_sumit setTitle:@"UPDATE" forState:UIControlStateNormal];
        
        _lbl_title.text=@"Update Bid.";
        
    }
    
    self.txt_View_T_and_C.delegate = self;
    self.txt_View_T_and_C.text = @"PLEASE ENTER DESCRIPTION";
    self.txt_View_T_and_C.textColor = [UIColor lightGrayColor];
   tandCStr=@"0";
    ComStr=@"0";

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}

- (IBAction)btn_TandC:(id)sender
{
    if ([tandCStr isEqualToString:@"0"]) {
        
        tandCStr=@"1";
       
        
        UIImage *selectImage = [UIImage imageNamed:@"check.png"];
        [_btn_tandC setImage:selectImage forState:UIControlStateNormal];
        
        
    }else{
        tandCStr=@"0";
        
       
        UIImage *selectImage = [UIImage imageNamed:@"uncheck.png"];
        [_btn_tandC setImage:selectImage forState:UIControlStateNormal];
    }
    
}

- (IBAction)btn_commActions:(id)sender {
    
    if ([ComStr isEqualToString:@"0"]) {
        
        ComStr=@"1";
        
        
        UIImage *selectImage = [UIImage imageNamed:@"check.png"];
        [_btn_5Commissiom setImage:selectImage forState:UIControlStateNormal];
        
        
    }else{
        ComStr=@"0";
        
        
        UIImage *selectImage = [UIImage imageNamed:@"uncheck.png"];
        [_btn_5Commissiom setImage:selectImage forState:UIControlStateNormal];
    }
}

- (IBAction)btn_Cancle:(id)sender
{

    
    self.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, .3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
       
        [self.view removeFromSuperview];
        
        [self removeFromParentViewController];
        
        [self didMoveToParentViewController:nil];
        

    });
   
    
       [UIView animateWithDuration:0.3/1.5 animations:^{
        self.view.transform=CGAffineTransformScale(CGAffineTransformIdentity,.9,0.9);
        
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3/2 animations:^{
            self.view.transform=CGAffineTransformScale(CGAffineTransformIdentity,0.001,0.001);
            
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/2 animations:^{
                self.view.transform=CGAffineTransformIdentity;
                
                
            }];
        }];
    }];
    
    
}

- (IBAction)btn_Submit:(id)sender
{
    
    if ([txt_Amount.text isEqualToString:@""])
    {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter Amount." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if ([txt_View_T_and_C.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter Description." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else if ([tandCStr isEqualToString:@"0"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"You Agree to the Terms & Conditions for Shionk.Please check this" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    
    else if ([ComStr isEqualToString:@"0"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please check shiponk commission.!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        [self Create_Bid];
    }
}
-(void)Create_Bid
{
    [APPDATA showLoader];
    void (^successed)(id responseObject) = ^(id responseObject)
    {
        [APPDATA hideLoader];
        
        
        
        bidDict=[responseObject objectForKey:@"data"];
    
        NSLog(@"Message:=%@",[responseObject valueForKey:@"message"]);
        
        

        
        UIAlertView *err4 = [[UIAlertView alloc]
                             initWithTitle:@"" message:@"Successfully bid created" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [err4 show];
        
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"My_Shipment_Bids"
         object:nil];

    };
    
    void (^failure)(NSError * error) = ^(NSError *error)
    {
        [APPDATA hideLoader];
        
    };
    
    
    NSString *useridStr=[NSString stringWithFormat:@"%@",[objappsharemanager.loginDic valueForKey:@"user_id"]];
    
    
   
    
    
    if ([strEdit isEqualToString:@"1"])
    {
        
         NSDictionary *dict = @{@"carrier_id":useridStr,@"shipmentid":objappsharemanager.Shipment_id,@"bid_amount":self.txt_Amount.text,@"description":@"agree"};
        
        [ApiCall sendToService:API_EDIT_BID andDictionary:dict success:successed failure:failure];
    }else{
        
         NSDictionary *dict = @{@"user_id":useridStr,@"shipment_id":objappsharemanager.Shipment_id,@"bid_amount":self.txt_Amount.text,@"description":@"agree"};
        [ApiCall sendToService:API_CREATE_BID andDictionary:dict success:successed failure:failure];
    }
    
    
    
    
    self.txt_Amount.text = nil;
    self.txt_View_T_and_C.text = nil;

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    self.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, .3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        
        [self.view removeFromSuperview];
        
        [self removeFromParentViewController];
        
        [self didMoveToParentViewController:nil];
        
        
    });
    
    
    [UIView animateWithDuration:0.3/1.5 animations:^{
        self.view.transform=CGAffineTransformScale(CGAffineTransformIdentity,.9,0.9);
        
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3/2 animations:^{
            self.view.transform=CGAffineTransformScale(CGAffineTransformIdentity,0.001,0.001);
            
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/2 animations:^{
                self.view.transform=CGAffineTransformIdentity;
                
                
            }];
        }];
    }];
    
  }

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([self.txt_View_T_and_C.text isEqualToString:@"PLEASE ENTER DESCRIPTION"]) {
        self.txt_View_T_and_C.text = @"";
        self.txt_View_T_and_C.textColor = [UIColor blackColor]; //optional
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([self.txt_View_T_and_C.text isEqualToString:@""]) {
        self.txt_View_T_and_C.text = @"PLEASE ENTER DESCRIPTION";
        self.txt_View_T_and_C.textColor = [UIColor lightGrayColor]; //optional
    }
    [textView resignFirstResponder];
}
@end
