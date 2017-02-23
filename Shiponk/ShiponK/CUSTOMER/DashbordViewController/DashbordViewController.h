//
//  DashbordViewController.h
//  ShiponK
//
//  Created by Bhushan on 5/17/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReviewAndRatingTableViewCell.h"
#import "LeftMenuViewController.h"
@interface DashbordViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,SlideNavigationControllerDelegate>
{
    IBOutlet UIButton *menuButton;
    NSMutableArray *nameArry;
}
@property (strong, nonatomic) IBOutlet UIImageView *imgRate;
@property (strong, nonatomic) IBOutlet UITableView *tbl_Review_And_Rating;
- (IBAction)btn_menuAction:(id)sender;

@end
