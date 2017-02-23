
//
//  IteamDetailsViewcontroller.h
//  ShiponK
//
//  Created by Bhushan on 7/5/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IteamDetailsViewcontroller : UIViewController

@property (strong, nonatomic) IBOutlet UIView *viewItemDetail;
@property (strong , nonatomic) IBOutlet UIImageView *itemImg;
@property (strong , nonatomic) IBOutlet UILabel *itemTitle;
@property (strong , nonatomic) IBOutlet UILabel *itemData;
- (IBAction)btnCloseAction:(id)sender;
@property (strong , nonatomic) IBOutlet UICollectionView *collectionViewImg;
- (IBAction)btnRightArrowAction:(id)sender;
@property (strong , nonatomic) NSString *strItemID;
@property (strong , nonatomic) NSArray *itemImageArr;
@property (strong , nonatomic) NSString *strUrl;
@end
