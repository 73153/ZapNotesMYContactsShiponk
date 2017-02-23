//
//  carrier_page5_vc.h
//  ShiponK
//
//  Created by Bhushan on 5/24/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface carrier_page5_vc : UIViewController


@property (strong, nonatomic) IBOutlet UITextField *txt_bankName;

@property (strong, nonatomic) IBOutlet UITextField *txt_accountNumber;
@property (strong, nonatomic) IBOutlet UITextField *txt_ac_holder;

@property (strong, nonatomic) IBOutlet UITextField *txt_bank_IFSC;

@property (strong, nonatomic) IBOutlet UITextField *txt_pan_number;


@property (strong, nonatomic) IBOutlet UITextField *txt_cst_number;

- (IBAction)btn_ContinueAction:(id)sender;


@end
