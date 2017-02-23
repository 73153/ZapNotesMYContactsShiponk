//
//  PayMentViewController.h
//  Transporter
//
//  Created by datt on 27/03/1938 SAKA.
//  Copyright © 1938 SAKA shivani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayMentViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *viewPayment;
@property (weak, nonatomic) IBOutlet UITableView *tblPaymentList;

- (IBAction)btnCancel:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalAmtOut;

- (IBAction)btnPayActions:(id)sender;
@end
