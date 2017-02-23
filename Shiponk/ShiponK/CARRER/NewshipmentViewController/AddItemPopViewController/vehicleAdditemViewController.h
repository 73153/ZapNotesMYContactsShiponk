//
//  vehicleAdditemViewController.h
//  ShiponK
//
//  Created by datt on 06/04/1938 SAKA.
//  Copyright © 1938 SAKA com.zaptechsolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface vehicleAdditemViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *btnimgItem;
- (IBAction)btnItemimgAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *viewHeader;
@property (strong, nonatomic) IBOutlet UIButton *btnDone;
@property (strong, nonatomic) IBOutlet UIView *viewAdditem;
@property (strong, nonatomic) IBOutlet UIImageView *imgBG;

- (IBAction)btnDoneAction:(id)sender;
- (IBAction)btnCloseAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnClose;

@property (weak, nonatomic) IBOutlet UITextField *txtItemTitle;


@property (weak, nonatomic) IBOutlet UITextField *txtQty;
@property (weak, nonatomic) IBOutlet UIButton *btnNew;
- (IBAction)btnNewAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnOld;
- (IBAction)btnOldAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnimgItem2;
@property (weak, nonatomic) IBOutlet UIButton *btnimgItem3;
@property (weak, nonatomic) IBOutlet UIButton *btnimgItem4;

@end
