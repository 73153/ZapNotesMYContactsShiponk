//
//  ViewRatingAndReviewVC.h
//  ShiponK
//
//  Created by bhavik on 6/14/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASStarRatingView.h"
@class ASStarRatingView;

@interface ViewRatingAndReviewVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imgViewProfileImgOut;
@property (weak, nonatomic) IBOutlet UILabel *lblUsernameOut;

@property (weak, nonatomic) IBOutlet UITableView *tblViewReviewFeedbackOut;
@property (strong,nonatomic) NSString *StrTransporterId;

@property (weak, nonatomic) IBOutlet UILabel *lblBusinessNameOurt;
@property (weak, nonatomic) IBOutlet UILabel *lblVehicleTypeOut;
@property (weak, nonatomic) IBOutlet UILabel *lblRatingAvg;
- (IBAction)btnBackAct:(id)sender;

@property (weak, nonatomic) IBOutlet ASStarRatingView *ViewAvgStarOut;

@property (strong,nonatomic)IBOutlet UILabel *lblRatingPoints1;
@property (strong,nonatomic)IBOutlet UILabel *lblRatingPoints2;
@property (strong,nonatomic)IBOutlet UILabel *lblRatingPoints3;
@property (strong,nonatomic)IBOutlet UILabel *lblRatingPoints4;
@property (strong,nonatomic)IBOutlet UILabel *lblRatingPoints5;
@property (strong,nonatomic)IBOutlet UIView *viewRating1;
@property (strong,nonatomic)IBOutlet UIView *viewRating2;
@property (strong,nonatomic)IBOutlet UIView *viewRating3;
@property (strong,nonatomic)IBOutlet UIView *viewRating4;
@property (strong,nonatomic)IBOutlet UIView *viewRating5;

@property (strong,nonatomic)IBOutlet UIView *viewReviewUser1;
@property (strong,nonatomic)IBOutlet UIView *viewReviewUser2;
@property (strong,nonatomic)IBOutlet UIView *viewReviewUser3;
@property (strong,nonatomic)IBOutlet UIView *viewReviewUser4;
@property (strong,nonatomic)IBOutlet UIView *viewReviewUser5;
- (IBAction)btn_writeareviewActions:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnWriteReview;

@end
