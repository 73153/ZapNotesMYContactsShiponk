//
//  MyBideViewController.h
//  ShiponK
//
//  Created by Bhushan on 7/1/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import "MyShipment_ViewController.h"
#import "MyShipment_TableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "order_history_ViewController.h"
#import "Shipment_Description_ViewController.h"
#import "appShareManager.h"
#import "Constant.h"
#import "ApiCall.h"
#import <QuartzCore/QuartzCore.h>
#import "ApplicationData.h"
#import <CoreText/CoreText.h>
#import "SlideNavigationController.h"
#import "ApplicationData.h"

#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import <UIKit/UIKit.h>

@interface MyBideViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

- (IBAction)btnActiveAction:(id)sender;
- (IBAction)btnCompAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnactive;
@property (strong, nonatomic) IBOutlet UIButton *btncompleted;

@property (weak, nonatomic) IBOutlet UITableView *tblView_myshipment;
@property (strong, nonatomic) IBOutlet UIView *view_noShipmentFound;

@property (strong, nonatomic) IBOutlet UIButton *menuButton;
@property (strong,nonatomic) NSMutableArray *shipmentArray;
@property (nonatomic,strong)NSMutableArray *shipmentDic;
@property (strong,nonatomic)NSMutableArray *shipmentTitleArray,*shipmentImageArray,*shipmentDateArray;
@end
