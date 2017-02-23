//
//  AddBranchViewController.h
//  ShiponK
//
//  Created by Bhushan on 6/27/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddBranchViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *viewAddBranch;
- (IBAction)btnDoneAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldTotalAmt;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldCity;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldMobileNo;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldZipCode;
@property  NSString *strCompanyName, *strLicense;
- (IBAction)btnCloseAction:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *tblCity;
@property (weak, nonatomic) IBOutlet UIButton *btnClose;



@end
