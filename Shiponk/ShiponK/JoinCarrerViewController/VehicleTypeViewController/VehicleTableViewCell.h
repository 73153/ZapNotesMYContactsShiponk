//
//  VehicleTableViewCell.h
//  ShiponK
//
//  Created by Bhushan on 5/17/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VehicleTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lbl_Vehicalname;
@property (strong, nonatomic) IBOutlet UIButton *btn_select;
@property (strong, nonatomic) IBOutlet UIImageView *img_selecte;

@end
