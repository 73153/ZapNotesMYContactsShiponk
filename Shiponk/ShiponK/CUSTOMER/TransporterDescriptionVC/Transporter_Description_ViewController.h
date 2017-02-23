//
//  Transporter_Description_ViewController.h
//  ShiponK
//
//  Created by ronakj on 6/7/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Transporter_TableViewCell.h"
#import <MapKit/MapKit.h>
@interface Transporter_Description_ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *Googlemap_View;
@property (strong, nonatomic) IBOutlet UIView *View_No_Biddies_Found;
@property (strong, nonatomic) IBOutlet UIView *View_Detail_Transporter;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Title;
@property (strong, nonatomic) IBOutlet UIImageView *img_Title_View;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Date;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Time;
@property (strong, nonatomic) IBOutlet UITextView *txt_Desc_View;
@property (strong, nonatomic) IBOutlet UILabel *lbl_movingto;
@property (strong, nonatomic) IBOutlet UILabel *lbl_movingfrom;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Amount;

@property (strong, nonatomic) IBOutlet UITableView *tbl_Transporter_Out;
@property (strong, nonatomic) IBOutlet UIScrollView *scrllView;
@property (weak, nonatomic) IBOutlet UICollectionView *TransporterCollectionView;


@property (nonatomic, assign) NSString *strid;

@property (strong, nonatomic) IBOutlet MKMapView *MapView;
@property (strong, nonatomic) IBOutlet UILabel *lbl_noiteam;
@property (weak, nonatomic) IBOutlet UILabel *lblCompleted;

- (IBAction)btnCreateAction:(id)sender;
- (IBAction)btnBackAct:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btnCreateBid;
@property (strong, nonatomic) IBOutlet UILabel *lblbidderlist;
- (IBAction)btnSatelliteAction:(id)sender;
- (IBAction)btnMapAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnMap;


@property (strong, nonatomic) IBOutlet UIButton *btnSatelliteAction;
@end
