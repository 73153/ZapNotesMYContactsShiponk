//
//  MenuViewController.h
//  SlideMenu
//
//  Created by Aryan Gh on 4/24/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"
#import "appShareManager.h"

@interface LeftMenuViewController : UIViewController{
    
    BOOL acFlage;
    appShareManager *objappShareManager;
}


@property (nonatomic, assign) BOOL slideOutAnimationEnabled;

@property (strong, nonatomic) IBOutlet UIImageView *img_acplus;

@property (strong, nonatomic) IBOutlet UIView *view_account;

@property (strong, nonatomic) IBOutlet UILabel *lbl_useName;

@property (strong, nonatomic) IBOutlet UIView *view_carrier;
@property (weak, nonatomic) IBOutlet UILabel *lbl_notification2;

@property (weak, nonatomic) IBOutlet UILabel *lbl_notification;
@property (weak, nonatomic) IBOutlet UIImageView *imgNotification;
@property (weak, nonatomic) IBOutlet UIImageView *imgNotification2;

@property (weak, nonatomic) IBOutlet UIImageView *img_profile;

@property (weak, nonatomic) IBOutlet UILabel *lbl_notCust;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView_carrier;



- (IBAction)btn_Cust_MyShipmentAction:(id)sender;

- (IBAction)btn_Cust_ChnagePassAction:(id)sender;

- (IBAction)btn_Cust_ProfileAction:(id)sender;



- (IBAction)btn_Cust_homeAction:(id)sender;

- (IBAction)btn_Cust_messageAction:(id)sender;


- (IBAction)btn_Cust_SignOutAction:(id)sender;



- (IBAction)btn_Carr_NewShipmentAction:(id)sender;

- (IBAction)btn_Carr_account:(id)sender;

- (IBAction)btn_Carr_NotificationAction:(id)sender;




- (IBAction)btn_Carr_AboutusAction:(id)sender;

- (IBAction)btn_Carr_signOutAction:(id)sender;
- (IBAction)btn_Ref_friendAction:(id)sender;

- (IBAction)btn_Carr_MyreviewAction:(id)sender;

- (IBAction)btn_CarrPaymentHistoryAction:(id)sender;


- (IBAction)btnHelpAction:(id)sender;


@property (strong, nonatomic) IBOutlet UIView *viewPayNow;
- (IBAction)btnPayNowAction:(id)sender;
- (IBAction)btn_CarrMyBide:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lblRemainingTimeOut;
@property (strong, nonatomic) IBOutlet UILabel *lblDueAmtOut;
@property (strong, nonatomic) IBOutlet UIImageView *imgClock;

@end
