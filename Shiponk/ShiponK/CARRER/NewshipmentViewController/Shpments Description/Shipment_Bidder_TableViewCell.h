//
//  Shipment_Bidder_TableViewCell.h
//  ShiponK
//
//  Created by krutagn on 27/05/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Shipment_Bidder_TableViewCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UILabel *lbl_bid_amt_out;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Bidder;
@property (strong, nonatomic) IBOutlet UIImageView *img_Bid_View;
@property (strong, nonatomic) IBOutlet UIButton *btn_Accept_out;
@property (strong, nonatomic) IBOutlet UILabel *lbl_amout;
@property (strong, nonatomic) IBOutlet UIButton *btn_cancel;
@property (strong, nonatomic) IBOutlet UIButton *btn_call;

@end
