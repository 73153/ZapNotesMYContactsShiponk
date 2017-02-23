//
//  New_shipment_page2.h
//  ShiponK
//
//  Created by bhavik on 5/25/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface New_shipment_page2 : UIViewController<UITextViewDelegate>{
    
    IBOutlet UIView *ViewPlag;
}
@property (weak, nonatomic) IBOutlet UITextView *txt_view_description_out;
- (IBAction)btn_add_an_item_act:(id)sender;
- (IBAction)btn_continue_act:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txt_shipment_title_out;
@property(weak,nonatomic) NSMutableArray *add_iteam_mut_arr;

// add an item controllers outlet............

@property (weak, nonatomic) IBOutlet UIView *viewAddanItemOut;
@property (weak, nonatomic) IBOutlet UIScrollView *scrlviewAddAnItemOut;
@property (weak, nonatomic) IBOutlet UITextField *txtShipmentNameOut;
@property (weak, nonatomic) IBOutlet UITextField *txtLendthMOut;
@property (weak, nonatomic) IBOutlet UITextField *txtLengthCMOut;
@property (weak, nonatomic) IBOutlet UITextField *txtWidthMOut;
@property (weak, nonatomic) IBOutlet UITextField *txtWidthCMOut;

@property (weak, nonatomic) IBOutlet UITextField *txtHeightMOut;
@property (weak, nonatomic) IBOutlet UITextField *txtHeightCMOut;
@property (weak, nonatomic) IBOutlet UITextField *txtWeightOut;
@property (weak, nonatomic) IBOutlet UITextField *txtQtyOut;
- (IBAction)btnBrowseAct:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imgviewAddAnItemOut;
- (IBAction)btnDoneAct:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *viewItemConstraintsOut;

@property (strong, nonatomic) IBOutlet UIScrollView *mainScrollView;

- (IBAction)btnAdditemAction:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lblFistSelect;

- (IBAction)btnBackAction:(id)sender;

- (IBAction)btnHomeAction:(id)sender;


@end
