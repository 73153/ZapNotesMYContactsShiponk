//
//  TransporterDetailTableViewCell.h
//  ShiponK
//
//  Created by datt on 17/03/1938 SAKA.
//  Copyright © 1938 SAKA com.zaptechsolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransporterDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblTitleOut;
@property (weak, nonatomic) IBOutlet UILabel *lblDistanceOut;
@property (weak, nonatomic) IBOutlet UILabel *lblDeliveryTimeOut;
@property (weak, nonatomic) IBOutlet UILabel *lblPickupTimeOut;
@property (weak, nonatomic) IBOutlet UIImageView *ImgViewShipmentImgOut;
@property (strong, nonatomic) IBOutlet UILabel *lbl_to;

@property (strong, nonatomic) IBOutlet UILabel *lbl_from;
@property (strong, nonatomic) IBOutlet UILabel *lbl_disc;

@property (strong, nonatomic) IBOutlet UIImageView *img_status;

@property (strong, nonatomic) IBOutlet UIButton *btn_cancel;


@property (strong, nonatomic) IBOutlet UILabel *lbl_completed;


@end
