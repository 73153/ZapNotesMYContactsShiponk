//
//  carrier_page2_vc.h
//  ShiponK
//
//  Created by Bhushan on 5/23/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface carrier_page2_vc : UIViewController
@property (strong, nonatomic) IBOutlet UITableView *tblCity;

@property (strong, nonatomic) IBOutlet UITextField *txt_companyName;

@property (strong, nonatomic) IBOutlet UITextField *txt_comp_address;
@property (strong, nonatomic) IBOutlet UITextField *txt_city;
@property (strong, nonatomic) IBOutlet UITextField *txt_zip;
@property (weak, nonatomic) IBOutlet UITextField *txtPanNumber;

@property (weak, nonatomic) IBOutlet UITextField *txtCstNumber;

@property (strong, nonatomic) IBOutlet UIScrollView *mainScrollView;

@property (weak, nonatomic) IBOutlet UIImageView *imgLicensePlace;
@property (weak, nonatomic) IBOutlet UIButton *btnCancleChequeImg;

@property (weak, nonatomic) IBOutlet UIButton *btnLicenseImgOut;

@property (weak, nonatomic) IBOutlet UIImageView *imgCanclePlace;


- (IBAction)btn_coneinueAction:(id)sender;

- (IBAction)btnAddBranchAction:(id)sender;
- (IBAction)btnViewBranchAction:(id)sender;
- (IBAction)btnBackAction:(id)sender;
- (IBAction)imgLicense:(id)sender;


@end
