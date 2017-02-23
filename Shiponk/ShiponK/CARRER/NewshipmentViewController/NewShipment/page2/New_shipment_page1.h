//
//  New_shipment_page1.h
//  ShiponK
//
//  Created by bhavik on 5/25/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface New_shipment_page1 : UIViewController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
}
@property (weak, nonatomic) IBOutlet UITextField *txt_city_moving_from_out;
@property (weak, nonatomic) IBOutlet UITextField *txt_moving_date;
@property (weak, nonatomic) IBOutlet UITextField *txt_city_moving_to_out;
@property (weak, nonatomic) IBOutlet UITextField *txt_pickup_time;
@property (weak, nonatomic) IBOutlet UITextField *txtPickupPlusTime;


- (IBAction)btn_continue_act:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *view_date_picker_out;
@property (weak, nonatomic) IBOutlet UIDatePicker *date_picker_out;
- (IBAction)btn_pick_up_time_act:(id)sender;

- (IBAction)btn_moving_date_act:(id)sender;

- (IBAction)btn_date_picker_down:(id)sender;

@property  (strong,atomic) NSString *strcity;
@property (strong, nonatomic) IBOutlet UITableView *tbl_City;
@property (strong, nonatomic) IBOutlet UIView *City_tbl_view;

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;


- (IBAction)btn_Insurance_Checkbox:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btn_Insurance_Checked_UnChecked;
@property (strong, nonatomic) IBOutlet UIButton *btn_out_urgent_deliv;

- (IBAction)btn_act_urgent_deliv:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btn_out_pickup_service;

- (IBAction)btn_act_pickup_service:(id)sender;
- (IBAction)btnCancleDatePickerAct:(id)sender;


@property (strong, nonatomic) IBOutlet UITextField *lxt_pickupEarlist_Date;

@property (strong, nonatomic) IBOutlet UITextField *txt_pickupLatest_Date;

@property (strong, nonatomic) IBOutlet UIButton *btnPickupResidential;

- (IBAction)btnPickupResidentail_Action:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *txt_DeliveryEariest_Date;

@property (strong, nonatomic) IBOutlet UITextField *txt_DeliverLatest_Date;

@property (strong, nonatomic) IBOutlet UIButton *btnDeliverResidential;
- (IBAction)btnDelverResidentialAction:(id)sender;

@property (strong, nonatomic)NSString *strpickupResidence;
@property (strong, nonatomic)NSString *strDeliveryResidence;


- (IBAction)btnSubmitAction:(id)sender;

- (IBAction)btnBackAction:(id)sender;

- (IBAction)btnHomeAction:(id)sender;
- (IBAction)btnPackagingTypeAction:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *txtPromoCode;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;
@property (weak, nonatomic) IBOutlet UIImageView *imgtxtPromoCode;
@property (weak, nonatomic) IBOutlet UIView *viewSubmitBtn;

@property (weak, nonatomic) IBOutlet UIButton *btnPackagingType;

- (IBAction)btnPromoCodeApplyAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnPromoCodeApply;
@property (weak, nonatomic) IBOutlet UIImageView *imgDone;

@end
