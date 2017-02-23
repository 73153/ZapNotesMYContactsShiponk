//
//  ReferAFriendViewController.h
//  ShiponK
//
//  Created by Bhushan on 7/19/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReferAFriendViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *menuButton;
@property (strong, nonatomic) IBOutlet UIImageView *image_logo;

- (IBAction)btn_emailShareAction:(id)sender;
- (IBAction)btn_smsShareAction:(id)sender;

- (IBAction)btn_whatsUpShareAction:(id)sender;

@end
