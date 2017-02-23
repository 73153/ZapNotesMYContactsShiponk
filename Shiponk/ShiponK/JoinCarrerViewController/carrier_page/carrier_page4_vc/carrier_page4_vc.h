//
//  carrier_page4_vc.h
//  ShiponK
//
//  Created by Bhushan on 5/23/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface carrier_page4_vc : UIViewController
@property (strong, nonatomic) IBOutlet UIScrollView *mainScrollView;

@property (strong, nonatomic) IBOutlet UITableView *btl_vehicalType;

@property (strong, nonatomic) IBOutlet UIImageView *imgProfile;
@property (strong, nonatomic) IBOutlet UIView *viewUpdateProfile;

- (IBAction)btnBackAction:(id)sender;

- (IBAction)btn_submitAction:(id)sender;

- (IBAction)btnImgBrowseAction:(id)sender;

@end
