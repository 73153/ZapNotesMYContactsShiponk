//
//  ViewBranchViewController.h
//  ShiponK
//
//  Created by Bhushan on 6/29/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewBranchViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tblViewBranch;

- (IBAction)btnCloseAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewBranchView;

@property (weak, nonatomic) IBOutlet UIButton *btnCLose;

@end
