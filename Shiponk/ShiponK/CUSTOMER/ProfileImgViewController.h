//
//  ProfileImgViewController.h
//  ShiponK
//
//  Created by datt on 20/07/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileImgViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imgProfile;
- (IBAction)btnCloseAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewProfileimg;

@end
