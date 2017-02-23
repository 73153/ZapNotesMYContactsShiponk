//
//  carrier_page1_vc.h
//  ShiponK
//
//  Created by Bhushan on 5/23/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface carrier_page1_vc : UIViewController



@property (strong, nonatomic) IBOutlet UITextField *txt_firstname;

@property (strong, nonatomic) IBOutlet UITextField *txt_lastname;
@property (strong, nonatomic) IBOutlet UITextField *txt_emailaddress;

@property (strong, nonatomic) IBOutlet UITextField *txt_confirmemailaddress;

@property (strong, nonatomic) IBOutlet UITextField *txt_mobilenumber;
@property (strong, nonatomic) IBOutlet UITextField *txt_password;

@property (strong, nonatomic) IBOutlet UITextField *txt_conf_password;
@property (strong, nonatomic) IBOutlet UIButton *btnhome;
@property (strong, nonatomic) IBOutlet UIButton *btnoffice;
@property (weak, nonatomic) IBOutlet UIImageView *imgHomePhn;
@property (weak, nonatomic) IBOutlet UIImageView *imgOfficePhn;


- (IBAction)btn_ContinueAction_1:(id)sender;
- (IBAction)btn_homeAction:(id)sender;
- (IBAction)btn_officeAction:(id)sender;
- (IBAction)btnBackAction:(id)sender;

@end
