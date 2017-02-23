//
//  SignViewcontrollerViewController.h
//  ShiponK
//
//  Created by Bhushan on 5/13/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import "ApplicationData.h"
#import <Google/SignIn.h>

@interface SignViewcontrollerViewController : UIViewController <GIDSignInUIDelegate>

@property (strong, nonatomic) IBOutlet UIView *view_LoginView;
@property (strong, nonatomic) IBOutlet UIView *view_Fbview;
@property (strong, nonatomic) IBOutlet UITextField *txt_emailaddress;
@property (strong, nonatomic) IBOutlet UITextField *txt_password;
@property (strong, nonatomic) IBOutlet UIButton *btn_rememverme;
@property (strong, nonatomic) IBOutlet NSString *userTypestr;
- (IBAction)btn_:(id)sender;

- (IBAction)btn_BackAction:(id)sender;

- (IBAction)btn_fbloginAction:(id)sender;

- (IBAction)btn_signinAction:(id)sender;

-(void)LoginMainMethod;

- (IBAction)btn_remembermeAction:(id)sender;

- (IBAction)btn_forgotPasswordMethod:(id)sender;
- (IBAction)btn_TwitterLoginAction:(id)sender;
- (IBAction)btnGooglePressed:(id)sender;



@end
