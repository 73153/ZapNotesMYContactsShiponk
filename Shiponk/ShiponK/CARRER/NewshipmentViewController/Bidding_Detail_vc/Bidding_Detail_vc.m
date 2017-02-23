//
//  Bidding_Detail_vc.m
//  ShiponK
//
//  Created by bhavik on 5/30/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import "Bidding_Detail_vc.h"
#import "tbl_cust_cell.h"

@implementation Bidding_Detail_vc

- (IBAction)btn_menu_act:(id)sender
{
    
}

- (IBAction)btn_accept_act:(id)sender
{
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"tbl_cust_cell";
    
    tbl_cust_cell *cell = (tbl_cust_cell *)[self.tbl_view_out dequeueReusableCellWithIdentifier:simpleTableIdentifier];
   
        if (cell == nil)
        {
            NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"tbl_cust_cell1" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            
            
        }
        
        
        return cell;
        
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


- (IBAction)btn_backAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
