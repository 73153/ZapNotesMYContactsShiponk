//
//  otherAdditemViewController.h
//  ShiponK
//
//  Created by datt on 06/04/1938 SAKA.
//  Copyright © 1938 SAKA com.zaptechsolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface otherAdditemViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIScrollView *mainScrollview;

@property (strong, nonatomic) IBOutlet UIButton *btnimgItem;

- (IBAction)btnItemAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *viewHeader;
@property (strong, nonatomic) IBOutlet UIButton *btnDone;
@property (strong, nonatomic) IBOutlet UIView *viewAdditem;
@property (strong, nonatomic) IBOutlet UIImageView *imgBG;

- (IBAction)btnDoneAction:(id)sender;
- (IBAction)btnCloseAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnClose;

@property (weak, nonatomic) IBOutlet UITextField *txtItemTitle;

@property (weak, nonatomic) IBOutlet UITextField *txtWidthM;
@property (weak, nonatomic) IBOutlet UITextField *txtWidthCM;
@property (weak, nonatomic) IBOutlet UITextField *txtHeightM;
@property (weak, nonatomic) IBOutlet UITextField *txtHeightCM;

@property (weak, nonatomic) IBOutlet UITextField *txtQty;
@property (weak, nonatomic) IBOutlet UITextField *txtWeight;
@property (weak, nonatomic) IBOutlet UIButton *btnimgItem2;

@property (weak, nonatomic) IBOutlet UIButton *btnimgItem3;
@property (weak, nonatomic) IBOutlet UIButton *btnimgItem4;

@end
