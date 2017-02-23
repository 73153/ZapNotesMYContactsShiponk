//
//  ViewController.h
//  ShiponK
//
//  Created by Bhushan on 5/9/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"

@interface ViewController : UIViewController<SlideNavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *lbl_getshiping;
@property (strong, nonatomic) IBOutlet UIView *View_bg;
@property (strong, nonatomic) IBOutlet UIButton *btn_join;

@property (strong, nonatomic) IBOutlet UIView *view_down;

@property (strong, nonatomic) IBOutlet UIButton *btn_singin;


- (IBAction)btn_customeMainAction:(id)sender;

- (IBAction)brn_carrierMainAction:(id)sender;


- (IBAction)btn_joinAction:(id)sender;

- (IBAction)btn_singinAction:(id)sender;






@end

