//
//  ASStarRatingView.h
//
//  Created by yanguango on 12/19/11.
//  Copyright (c) 2011 yanguango. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Feedback_And_Review_ViewController.h"
@class Feedback_And_Review_ViewController;
@class appShareManager;

#define kDefaultMaxRating 5
#define kDefaultLeftMargin 5
#define kDefaultMidMargin 5
#define kDefaultRightMargin 5
#define kDefaultMinAllowedRating 1
#define kDefaultMaxAllowedRating kDefaultMaxRating
#define kDefaultMinStarSize CGSizeMake(5, 5)

@interface ASStarRatingView : UIView {
    UIImage *_notSelectedStar;
    UIImage *_selectedStar;
    UIImage *_halfSelectedStar;
    BOOL _canEdit;
    int _maxRating;
    float _leftMargin;
    float _midMargin;
    float _rightMargin;
    CGSize _minStarSize;
    float _rating;
    float _minAllowedRating;
    float _maxAllowedRating;
    NSMutableArray *_starViews;
    Feedback_And_Review_ViewController *objFeedback;
    appShareManager *objappsharemanager;
}

@property (retain, nonatomic) UIImage *notSelectedStar;
@property (retain, nonatomic) UIImage *selectedStar;
@property (retain, nonatomic) UIImage *halfSelectedStar;
@property (assign, nonatomic) BOOL canEdit;
@property (assign, nonatomic) int maxRating;
@property (assign, nonatomic) float leftMargin;
@property (assign, nonatomic) float midMargin;
@property (assign, nonatomic) float rightMargin;
@property (assign, nonatomic) CGSize minStarSize;
@property (assign, nonatomic) float rating;
@property (assign, nonatomic) float minAllowedRating;
@property (assign, nonatomic) float maxAllowedRating;
@end
