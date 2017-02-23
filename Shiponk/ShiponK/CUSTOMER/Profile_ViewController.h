//
//  Profile_ViewController.h
//  ShiponK
//
//  Created by datt on 16/03/1938 SAKA.
//  Copyright © 1938 SAKA com.zaptechsolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Profile_ViewController : UIViewController
- (IBAction)btn_Edit_Action:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *menuBtn;
@property (weak, nonatomic) IBOutlet UILabel *lbl_username;
@property (weak, nonatomic) IBOutlet UIImageView *img_userProfileimg;
@property (strong, nonatomic) IBOutlet UIImageView *noimageView;
@property (strong, nonatomic) IBOutlet UIButton *btnMyReview;
- (IBAction)btnMyReviewAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (strong, nonatomic) IBOutlet UIView *carrier_view;


@property (strong, nonatomic) IBOutlet UITextField *tr_txtfirst_name;

@property (strong, nonatomic) IBOutlet UITextField *tr_lastname;

@property (strong, nonatomic) IBOutlet UITextField *tr_email;

@property (strong, nonatomic) IBOutlet UITextField *tr_moble;

@property (strong, nonatomic) IBOutlet UIButton *btn_home;
@property (strong, nonatomic) IBOutlet UIButton *btn_office;
@property (weak, nonatomic) IBOutlet UIImageView *imgMobilePhn;
@property (weak, nonatomic) IBOutlet UIImageView *imgOfficePhn;

@property (strong, nonatomic) IBOutlet UITextField *tr_companyname;
@property (strong, nonatomic) IBOutlet UITextField *tr_txt_comp_pan;

@property (strong, nonatomic) IBOutlet UITextField *tr_txt_comp_address;

@property (strong, nonatomic) IBOutlet UITextField *tr_city;
@property (strong, nonatomic) IBOutlet UITextField *tr_zip;

@property (weak, nonatomic) IBOutlet UITableView *tblCity;


@property (strong, nonatomic) IBOutlet UIButton *btn_updateVehicleType;

- (IBAction)btnEditVehicalTypeAction:(id)sender;

- (IBAction)btn_updateBusinessAction:(id)sender;

- (IBAction)btn_viewBranchAction:(id)sender;
- (IBAction)btn_addBranchAction:(id)sender;
- (IBAction)btn_homeAction:(id)sender;
- (IBAction)btnEditProfileImgAction:(id)sender;

- (IBAction)btn_officeAction:(id)sender;
- (IBAction)btn_updateProfile:(id)sender;

@end
