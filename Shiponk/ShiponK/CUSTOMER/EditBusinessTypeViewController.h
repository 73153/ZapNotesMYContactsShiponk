//
//  EditBusinessTypeViewController.h
//  ShiponK
//
//  Created by datt on 19/07/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditBusinessTypeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tblBusiness;



- (IBAction)btnCloseAction:(id)sender;

- (IBAction)btnDoneAction:(id)sender;
@end
