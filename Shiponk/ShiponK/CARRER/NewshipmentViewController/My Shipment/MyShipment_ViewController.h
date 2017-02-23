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

@property (strong, nonatomic) IBOutlet UIButton *menuButton;
@property (strong,nonatomic) NSMutableArray *shipmentArray;
@property (nonatomic,strong)NSDictionary *shipmentDic;
@property (strong,nonatomic)NSMutableArray *shipmentTitleArray,*shipmentImageArray,*shipmentDateArray;

@end
