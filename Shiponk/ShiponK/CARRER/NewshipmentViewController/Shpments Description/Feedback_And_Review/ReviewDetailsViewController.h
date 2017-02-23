//
//  ReviewDetailsViewController.h
//  ShiponK
//
//  Created by Bhushan on 8/1/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASStarRatingView.h"

@interface ReviewDetailsViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIImageView *imgProfile;


@property (strong, nonatomic) IBOutlet ASStarRatingView *viewStarRat;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblReview;




- (IBAction)btnCloseAction:(id)sender;

@end
