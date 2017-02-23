//
//  ChnagepasswordViewController.h
//  ShiponK
//
//  Created by Bhushan on 5/31/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChnagepasswordViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *txt_OldPassword;

@property (strong, nonatomic) IBOutlet UITextField *txt_NewPassword;
@property (strong, nonatomic) IBOutlet UITextField *txt_ConfirmPassword;
- (IBAction)btn_SubmitAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *menu_Action;

@end
