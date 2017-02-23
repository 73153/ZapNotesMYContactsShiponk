//
//  Create_Bid_ViewController.h
//  ShiponK
//
//  Created by krutagn on 10/06/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Create_Bid_ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *txt_Amount;

@property (strong, nonatomic) IBOutlet UITextView *txt_View_T_and_C;
@property (strong, nonatomic) IBOutlet UILabel *lbl_title;

@property(strong,nonatomic)NSString *strAmount;
@property(strong,nonatomic)NSString *strDecs;
@property(strong,nonatomic)NSString *strEdit;
@property (strong, nonatomic) IBOutlet UIImageView *img_check;
- (IBAction)btn_TandC:(id)sender;
- (IBAction)btn_commActions:(id)sender;

- (IBAction)btn_Cancle:(id)sender;
- (IBAction)btn_Submit:(id)sender;
@end
