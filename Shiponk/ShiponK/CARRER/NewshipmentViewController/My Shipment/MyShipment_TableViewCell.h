//
//  MyShipment_TableViewCell.h
//  ShiponK
//
//  Created by ronakj on 5/27/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyShipment_TableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lbl_Title;

@property (strong, nonatomic) IBOutlet UIImageView *img_ship;
@property (strong, nonatomic) IBOutlet UITextView *txtDescriptionView;
@property (strong, nonatomic) IBOutlet UILabel *lblDate;
@property (strong, nonatomic) IBOutlet UILabel *lblTime;


@end
