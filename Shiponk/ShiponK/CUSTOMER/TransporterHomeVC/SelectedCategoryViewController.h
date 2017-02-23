//
//  SelectedCategoryViewController.h
//  ShiponK
//
//  Created by Bhushan on 6/14/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SectionView.h"
@interface SelectedCategoryViewController : UIViewController<SectionView>
- (IBAction)btnSeaechAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *viewMain;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewMain;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewCategory;

@property (strong, nonatomic) IBOutlet UITableView *tblCategorySelect;
- (IBAction)btnCategorySubmitAction:(id)sender;
- (IBAction)btnCategoryClearAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *viewCategory;

- (IBAction)btnCategoryAction:(id)sender;
- (IBAction)btnMoreFiltersAction:(id)sender;
- (IBAction)btnOthersAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnMoreFiltersOutlet;
@property (weak, nonatomic) IBOutlet UIButton *btnOthersOutlet;

@property (weak, nonatomic) IBOutlet UIImageView *imgOthersbtnArrow;


@property (weak, nonatomic) IBOutlet UIImageView *imgCategorybtnArrow;
@property (weak, nonatomic) IBOutlet UIImageView *imgMoreFiltersbtnArrow;
@property (weak, nonatomic) IBOutlet UIView *viewMoreFilters;
@property (weak, nonatomic) IBOutlet UIView *viewOthers;
@property (weak, nonatomic) IBOutlet UITextField *txtMovingFrom;
@property (weak, nonatomic) IBOutlet UITextField *txtMovingTo;
@property (weak, nonatomic) IBOutlet UITableView *city_tbl_view;

- (IBAction)btnPackingServiceChekbox:(id)sender;

- (IBAction)btnUrgentShipmentDeliveryChekBox:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *UrgentShipmentDeliveryChekBox;

@property (weak, nonatomic) IBOutlet UIButton *PackingServiceChekbox;
@property (strong, nonatomic) IBOutlet UIView *viewSubmitClear;

@end
