//
//  animalAdditemViewController.h
//  ShiponK
//
//  Created by datt on 06/04/1938 SAKA.
//  Copyright © 1938 SAKA com.zaptechsolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface animalAdditemViewController : UIViewController
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


@property (weak, nonatomic) IBOutlet UITextField *txtBreed;
@property (weak, nonatomic) IBOutlet UITextField *txtWeight;

- (IBAction)btnBreedAction:(id)sender;

@property (strong, nonatomic) IBOutlet UITableView *tblBreed;
@property (weak, nonatomic) IBOutlet UIButton *btnImgItem2;

@property (weak, nonatomic) IBOutlet UIButton *btnImgItem3;
@property (weak, nonatomic) IBOutlet UIButton *btnImgItem4;
- (IBAction)btnSelectBreedCloseAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewbreed;
@property (weak, nonatomic) IBOutlet UIButton *btnSelectBreedClose;

@end
