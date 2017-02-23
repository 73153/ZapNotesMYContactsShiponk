//
//  TblViewCellViewRatingAndReview.h
//  ShiponK
//
//  Created by bhavik on 6/14/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASStarRatingView.h"

#import <CoreText/CoreText.h>



@interface TblViewCellViewRatingAndReview : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblDescriptionOut;

@property (weak, nonatomic) IBOutlet UILabel *lblTitleTblOut;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewProfileTblOut;

@property (weak, nonatomic) IBOutlet ASStarRatingView *ViewStarRatingTblOut;

@end
