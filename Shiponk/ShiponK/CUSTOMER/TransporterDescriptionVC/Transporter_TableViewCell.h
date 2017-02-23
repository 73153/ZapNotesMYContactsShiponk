//
//  Transporter_TableViewCell.h
//  ShiponK
//
//  Created by ronakj on 6/7/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Transporter_TableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lbl_bid_amt_out;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Bidder;
@property (strong, nonatomic) IBOutlet UIImageView *img_Bid_View;

@property (strong, nonatomic) IBOutlet UIButton *btn_Accept_out;
@property (strong, nonatomic) IBOutlet UIButton *btneditBid;
@property (strong, nonatomic) IBOutlet UIButton *btn_call;
@property (strong, nonatomic) IBOutlet UIButton *btn_cancel;
@property (weak, nonatomic) IBOutlet UILabel *lblCompleted;

@end
