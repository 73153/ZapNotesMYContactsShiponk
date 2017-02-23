//
//  cellMessageTblCell.h
//  shiphon_demo
//
//  Created by krutagn on 18/05/16.
//  Copyright © 2016 bhavik@zaptech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface cellMessageTblCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lbl_username_message;
@property (weak, nonatomic) IBOutlet UITextView *txt_desc;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UIImageView *imgeMsgReadandUnread;
@property (strong, nonatomic) IBOutlet UIButton *btn_close;

@end
