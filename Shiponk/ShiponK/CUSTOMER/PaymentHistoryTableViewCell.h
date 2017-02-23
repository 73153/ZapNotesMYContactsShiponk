//
//  PaymentHistoryTableViewCell.h
//  ShiponK
//
//  Created by Bhushan on 8/1/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentHistoryTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lblBidAmount;
@property (strong, nonatomic) IBOutlet UILabel *lblCommisionAmount;
@property (strong, nonatomic) IBOutlet UILabel *lblCommisionPercentage;
@property (strong, nonatomic) IBOutlet UILabel *lblShipmentTitle;

@end
