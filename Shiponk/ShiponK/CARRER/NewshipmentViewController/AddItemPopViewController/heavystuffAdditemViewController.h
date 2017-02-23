//
//  heavystuffAdditemViewController.h
//  ShiponK
//
//  Created by datt on 06/04/1938 SAKA.
//  Copyright © 1938 SAKA com.zaptechsolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface heavystuffAdditemViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *imgBG;

@property (strong, nonatomic) IBOutlet UIView *viewHeader;

@property (strong, nonatomic) IBOutlet UIButton *btnimgItem;
- (IBAction)btnItemimgAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (strong, nonatomic) IBOutlet UIButton *btnDone;
- (IBAction)btnDoneAction:(id)sender;
- (IBAction)btnCloseAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnClose;

@property (strong, nonatomic) IBOutlet UIView *viewAdditem;

@property (weak, nonatomic) IBOutlet UITextField *txtItemTitle;


@property (weak, nonatomic) IBOutlet UITextField *txtQty;
@property (weak, nonatomic) IBOutlet UITextField *txtBreed;
@property (weak, nonatomic) IBOutlet UITextField *txtModel;
@property (weak, nonatomic) IBOutlet UITextField *txtWeight;


@end
