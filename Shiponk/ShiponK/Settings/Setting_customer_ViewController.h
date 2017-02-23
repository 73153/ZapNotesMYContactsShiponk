//
//  Setting_customer_ViewController.h
//  CustomTableView
//
//  Created by dharmesh on 6/9/16.
//  Copyright © 2016 shivani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Setting_customer_ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tblView;


@property (weak, nonatomic) IBOutlet UIButton *menuButton;

@end
