//
//  LoginCustomerViewController.h
//  ShiponK
//
//  Created by Bhushan on 5/11/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import "ViewController.h"

@interface RegistrationCustomerViewController : ViewController

@property (strong, nonatomic) IBOutlet UITextField *txt_firstName;
@property (strong, nonatomic) IBOutlet UITextField *txt_lastName;

@property (strong, nonatomic) IBOutlet UITextField *txt_userName;

@property (strong, nonatomic) IBOutlet UITextField *txt_emaiAddress;

@property (strong, nonatomic) IBOutlet UITextField *txt_mobileNumber;
@property (strong, nonatomic) IBOutlet UITextField *txt_password;

@property (strong, nonatomic) IBOutlet UIView *viewProfileUpdate;

@property (strong, nonatomic) IBOutlet UITextField *txt_cobfirmPassword;


@property (strong, nonatomic) IBOutlet UIButton *btn_registration;
@property (strong, nonatomic) IBOutlet UIView *viewProfileMenuBtn;

@property (strong, nonatomic) IBOutlet UIScrollView *scr_view;
@property (strong, nonatomic) IBOutlet UILabel *Lbl_title;
@property (strong, nonatomic) IBOutlet UIImageView *img_profile_browse;

//- (IBAction)btn_fbActions:(id)sender;
- (IBAction)btn_backAction:(id)sender;
- (IBAction)btn_registrationAction:(id)sender;
- (IBAction)btn_img_Browse:(id)sender;
- (IBAction)btn_back_Action:(id)sender;
- (IBAction)btnProfileImgAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imgPassBG;
@property (weak, nonatomic) IBOutlet UIImageView *imgConPassBG;
@property (weak, nonatomic) IBOutlet UIButton *btnJoinShiponk;
@property (weak, nonatomic) IBOutlet UIButton *btnEditProfile;
@property (weak, nonatomic) IBOutlet UIView *viewProfileImg;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UIButton *btnmenu;

@end
