//
//  New_shipment_page4.h
//  ShiponK
//
//  Created by Bhushan on 5/30/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface New_shipment_page4 : UIViewController

- (IBAction)btn_img2_act:(id)sender;
- (IBAction)btn_img1_act:(id)sender;
- (IBAction)btn_img3_act:(id)sender;
- (IBAction)btn_img4_act:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *img_view_1;
@property (strong, nonatomic) IBOutlet UIImageView *img_view_2;
@property (strong, nonatomic) IBOutlet UIImageView *img_view_3;
@property (strong, nonatomic) IBOutlet UIImageView *img_view_4;
- (IBAction)btn_submit_act:(id)sender;

@property (strong, nonatomic) IBOutlet UIImageView *imgPlaceHolder1;

@property (strong, nonatomic) IBOutlet UIImageView *imgPlaceholder2;

@property (strong, nonatomic) IBOutlet UIImageView *imgPlaceholder3;
@property (strong, nonatomic) IBOutlet UIImageView *imgPlaceholder4;

@end
