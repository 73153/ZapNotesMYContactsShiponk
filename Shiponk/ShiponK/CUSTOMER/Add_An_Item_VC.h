//
//  Add_An_Item_VC.h
//  ShiponK
//
//  Created by bhavik on 5/27/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Add_An_Item_VC : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txt_ship_title_out;

- (IBAction)btn_browse_act:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *img_view_item;
- (IBAction)btn_done_act:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *view_add_an_item_out;
@property (weak, nonatomic) IBOutlet UITextField *txt_length_m_out;
@property (weak, nonatomic) IBOutlet UITextField *txt_length_cm_out;
@property (weak, nonatomic) IBOutlet UITextField *txt_width_m;
@property (weak, nonatomic) IBOutlet UITextField *txt_width_cm;
@property (weak, nonatomic) IBOutlet UITextField *txt_height_m;
@property (weak, nonatomic) IBOutlet UITextField *txt_height_cm;
@property (weak, nonatomic) IBOutlet UITextField *txt_weight;
@property (weak, nonatomic) IBOutlet UITextField *txt_qty;
@property (weak, nonatomic) IBOutlet UIScrollView *scrl_view_out;

@end
