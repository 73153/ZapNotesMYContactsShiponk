//
//  Shipment_Category_ViewController.h
//  ShiponK
//
//  Created by datt on 04/03/1938 SAKA.
//  Copyright © 1938 SAKA com.zaptechsolution. All rdetrights reserved.
//

#import <UIKit/UIKit.h>
#import "CustCellCollView.h"

@interface Shipment_Category_ViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>



@property (weak, nonatomic) IBOutlet UICollectionView *CollViewOut;
- (IBAction)btnBackAct:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnBackOut;

@property (weak, nonatomic) IBOutlet UIButton *btnmenu;




@end
