//
//  ResidentialViewController.h
//  ShiponK
//
//  Created by Bhushan on 6/18/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResidentialViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITableView *TblViewResidentialOut;
@property (strong,nonatomic) NSString *strResidenceBtnTag;
- (IBAction)btnCloseAction:(id)sender;
@end
