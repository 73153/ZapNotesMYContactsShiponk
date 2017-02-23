//
//  ForgotPasswordViewController.h
//  ShiponK
//
//  Created by Bhushan on 5/18/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgotPasswordViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *txt_emailaddress;



- (IBAction)btn_sendAction:(id)sender;
- (IBAction)btn_cancelAction:(id)sender;



@end
