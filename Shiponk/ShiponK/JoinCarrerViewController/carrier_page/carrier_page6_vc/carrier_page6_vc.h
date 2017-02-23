//
//  carrier_page6_vc.h
//  ShiponK
//
//  Created by Bhushan on 5/25/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface carrier_page6_vc : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *btn_imgeuploade;


@property (strong, nonatomic) IBOutlet UIImageView *img_Che;


- (IBAction)btn_imageUploadeAction:(id)sender;
- (IBAction)btn_submitAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *view_Profile_Picture;
@property (weak, nonatomic) IBOutlet UIImageView *img_Profile_Picture;

@end
