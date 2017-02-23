//
//  Feedback_And_Review_ViewController.h
//  ShiponK
//
//  Created by krutagn on 13/06/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ASStarRatingView.h"

@class ASStarRatingView;

@interface Feedback_And_Review_ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *lbl_exp;

@property (strong, nonatomic) IBOutlet UITextField *txt_feedBack;

@property (strong, nonatomic) IBOutlet ASStarRatingView *star_rating_view;
@property(strong,nonatomic) NSString *ShipmentidStr1;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Name;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Rp;

@property (strong, nonatomic) IBOutlet UILabel *lbl_to;
@property (strong, nonatomic) IBOutlet UILabel *lbl_from;
@property (strong, nonatomic) IBOutlet UILabel *lbl_km;

@property (strong, nonatomic) IBOutlet UIView *main_view;
@property (strong, nonatomic) IBOutlet UIImageView *image_view;
@property(nonatomic,retain)NSDictionary *raDict;

@property (strong, nonatomic) IBOutlet UIImageView *imgLike;

@property (strong, nonatomic) IBOutlet UILabel *lblThanks;

- (IBAction)btn_submit:(id)sender;
-(void)SetStare;
@end
