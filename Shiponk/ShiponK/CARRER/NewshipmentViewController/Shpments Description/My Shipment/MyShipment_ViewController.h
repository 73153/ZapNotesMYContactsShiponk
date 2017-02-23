//
//  MyShipment_ViewController.h
//  ShiponK
//
//  Created by ronakj on 5/27/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyShipment_ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tblView_myshipment;
@property (strong, nonatomic) IBOutlet UIView *view_noShipmentFound;

@property (strong, nonatomic) IBOutlet UIButton *menuButton;
@property (strong,nonatomic) NSMutableArray *shipmentArray;
@property (nonatomic,strong)NSMutableArray *shipmentDic;
@property (strong,nonatomic)NSMutableArray *shipmentTitleArray,*shipmentImageArray,*shipmentDateArray;
- (IBAction)btnActive_Actions:(id)sender;
- (IBAction)btn_Completed_Actions:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnActive;

@property (strong, nonatomic) IBOutlet UIButton *btnComp;



@end
