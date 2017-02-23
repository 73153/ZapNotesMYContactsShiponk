//
//  order_history_ViewController.h
//  ShiponK
//
//  Created by dharmesh on 5/27/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftMenuViewController.h"
@interface order_history_ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,SlideNavigationControllerDelegate>
{
 NSMutableArray *nameArr;

}
@property (strong, nonatomic) IBOutlet UITableView *tbl_order_history;
- (IBAction)btn_back_act:(id)sender;
@end
