//
//  ViewBranchTableViewCell.h
//  ShiponK
//
//  Created by nirzar on 6/29/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewBranchTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblTotalAmount;
@property (weak, nonatomic) IBOutlet UILabel *lblCity;
@property (weak, nonatomic) IBOutlet UILabel *lblMobileNo;
@property (weak, nonatomic) IBOutlet UILabel *lblZipcode;
@end
