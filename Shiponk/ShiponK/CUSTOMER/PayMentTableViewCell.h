//
//  PayMentTableViewCell.h
//  Transporter
//
//  Created by datt on 27/03/1938 SAKA.
//  Copyright © 1938 SAKA shivani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayMentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblCommisionPercentage;
@property (weak, nonatomic) IBOutlet UILabel *lblBidAmount;
@property (weak, nonatomic) IBOutlet UILabel *lblShipmentTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblCommissionAmtOut;

@end
