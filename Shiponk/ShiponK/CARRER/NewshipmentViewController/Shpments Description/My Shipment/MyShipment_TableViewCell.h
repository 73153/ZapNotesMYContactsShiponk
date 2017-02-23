//
//  MyShipment_TableViewCell.h
//  ShiponK
//
//  Created by ronakj on 5/27/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTLabel.h"

@interface MyShipment_TableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lbl_Title;

@property (strong, nonatomic) IBOutlet UIImageView *img_ship;
@property (strong, nonatomic) IBOutlet UILabel *lblDate;
@property (strong, nonatomic) IBOutlet UILabel *lblTime;
@property (strong, nonatomic) IBOutlet UILabel *lbl_description;
@property (strong, nonatomic) IBOutlet UILabel *lbl_km;

@property (strong, nonatomic) IBOutlet UILabel *lbl_pickup_date;

@property (strong, nonatomic) IBOutlet UILabel *lbl_to;

@property (strong, nonatomic) IBOutlet UILabel *lbl_deliveryDate;

@property (strong, nonatomic) IBOutlet UILabel *lbl_from;

@property (strong, nonatomic) IBOutlet UIImageView *imge_status;
@property (strong, nonatomic) IBOutlet UIButton *btn_pickup;
@property (strong, nonatomic) IBOutlet UILabel *lblcompleted;

@property (strong, nonatomic) IBOutlet UIImageView *image_myship;
@property (strong, nonatomic) IBOutlet UIButton *btn_cancel;
@property (strong, nonatomic) IBOutlet UIButton *btn_quotenow;


@property (strong, nonatomic) IBOutlet UIButton *btn_comp;
@property (strong, nonatomic) IBOutlet UILabel *lblTotalBid;

@end
