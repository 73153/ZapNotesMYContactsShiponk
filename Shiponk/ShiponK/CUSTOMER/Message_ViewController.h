//
//  Message_ViewController.h
//  ShiponK
//
//  Created by datt on 06/03/1938 SAKA.
//  Copyright © 1938 SAKA com.zaptechsolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Message_ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *nameArry;
}


@property (strong, nonatomic) IBOutlet UILabel *lblnoNotifcation;

@property (weak, nonatomic) IBOutlet UITableView *tblView
;

@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (weak, nonatomic) IBOutlet UILabel *lbl_not;

@end
