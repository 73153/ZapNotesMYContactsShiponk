//
//  EditVehicleTypeViewController.h
//  ShiponK
//
//  Created by datt on 19/07/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditVehicleTypeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tblVehicleType;



- (IBAction)btnCloseAction:(id)sender;

- (IBAction)btnDoneAction:(id)sender;

@end
