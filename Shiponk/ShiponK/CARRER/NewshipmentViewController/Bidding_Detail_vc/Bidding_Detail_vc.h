//
//  Bidding_Detail_vc.h
//  ShiponK
//
//  Created by bhavik on 5/30/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Bidding_Detail_vc : UIViewController<UITableViewDelegate,UITableViewDataSource>


- (IBAction)btn_accept_act:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *txt_view_rating;
@property (weak, nonatomic) IBOutlet UITableView *tbl_view_out;
- (IBAction)btn_backAction:(id)sender;

@end
