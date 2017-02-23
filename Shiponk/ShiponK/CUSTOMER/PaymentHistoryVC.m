//
//  PaymentHistoryVC.m
//  ShiponK
//
//  Created by Bhushan on 8/1/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import "PaymentHistoryVC.h"
#import "PaymentHistoryTableViewCell.h"
#import "ApplicationData.h"
#import "appShareManager.h"
#import "SlideNavigationController.h"

@interface PaymentHistoryVC ()<UITableViewDataSource,UITableViewDelegate>
{
    PaymentHistoryTableViewCell *cell;
    NSMutableArray *bid_amount_arr;
    NSMutableArray *commission_percent_arr;
    NSMutableArray *shipment_title_arr;
    
    
    appShareManager *objappShareManager;
    float totalAmt;
    __block NSMutableArray *arr1;

}
@end

@implementation PaymentHistoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    objappShareManager=[appShareManager sharedManager];
    
     [_btnMenu addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleLeftMenu) forControlEvents:UIControlEventTouchUpInside];
    
    [APPDATA showLoader];

    void (^successed)(id responseObject) = ^(id responseObject)
    {
        [APPDATA hideLoader];

        NSDictionary *dic=[responseObject objectForKey:@"data"];
        
        bid_amount_arr=[[NSMutableArray alloc]init];
        
        bid_amount_arr=[[dic valueForKey:@"bid_list"]valueForKey:@"bid_amount"];
        
        commission_percent_arr=[[NSMutableArray alloc]init];
        
        commission_percent_arr=[[dic valueForKey:@"bid_list"]valueForKey:@"commission_percent"];
        
        shipment_title_arr=[[NSMutableArray alloc]init];
        
        shipment_title_arr=[[dic valueForKey:@"bid_list"]valueForKey:@"shipment_title"];
        NSLog(@"Data==>%@",dic);

        
        [_tblViewPaymentHistory reloadData];
    };
    
    void (^failure)(NSError * error) = ^(NSError *error)
    {
        [APPDATA hideLoader];
        
    };
    
    
    //    NSString *useridStr=[NSString stringWithFormat:@"%@",[objappsharemanager.loginDic valueForKey:@"user_id"]];
    //
    NSDictionary *dict = @{@"carrier_id":[NSString stringWithFormat:@"%@",[objappShareManager.loginDic valueForKey:@"user_id"]],@"page":@"0",@"offset":@"0"};
    
    [ApiCall sendToService:API_PAYMENT_HISTORY andDictionary:dict success:successed failure:failure];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [bid_amount_arr count];
   
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"PaymentHistoryTableViewCell";
    
    
    cell=(PaymentHistoryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    
    if (cell == nil) {
        cell = [[PaymentHistoryTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        
        
    }
    cell.lblBidAmount.text=[NSString stringWithFormat:@"%@",[bid_amount_arr objectAtIndex:indexPath.row]];
    cell.lblCommisionPercentage.text=[NSString stringWithFormat:@"%@",[commission_percent_arr objectAtIndex:indexPath.row]];
    
    cell.lblShipmentTitle.text=[NSString stringWithFormat:@"%@",[shipment_title_arr objectAtIndex:indexPath.row]];
    
////        cell.lblBidAmount.text=[NSString stringWithFormat:@"%@",[arr1 objectAtIndex:indexPath.row]];
//        cell.lblCommisionPercentage.text=[NSString stringWithFormat:@"%@",[commission_percent_arr objectAtIndex:indexPath.row]];
//    
//        cell.lblShipmentTitle.text=[NSString stringWithFormat:@"%@",[shipment_title_arr objectAtIndex:indexPath.row]];
    
   
    
    float fltBidAmt = [[bid_amount_arr objectAtIndex:indexPath.row] floatValue];
    float fltComPer = [[commission_percent_arr objectAtIndex:indexPath.row]floatValue];
    float FltComAmt = (fltBidAmt*fltComPer)/100;
    cell.lblCommisionAmount.text = [NSString stringWithFormat:@"%.2f",FltComAmt];
    
    
    
    return cell;
}


@end
