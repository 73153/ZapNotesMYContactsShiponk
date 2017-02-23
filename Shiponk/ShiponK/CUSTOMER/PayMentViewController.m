//
//  PayMentViewController.m
//  Transporter
//
//  Created by datt on 27/03/1938 SAKA.
//  Copyright © 1938 SAKA shivani. All rights reserved.
//

#import "PayMentViewController.h"
#import "PayMentTableViewCell.h"
#import "ApplicationData.h"
#import "appShareManager.h"
#import "PaymentPageViewController.h"

@interface PayMentViewController()<UITableViewDataSource,UITableViewDelegate>
{
    PayMentTableViewCell *cell;
    NSMutableArray *bid_amount_arr;
    NSMutableArray *commission_percent_arr;
    NSMutableArray *shipment_title_arr;
    
    appShareManager *objappShareManager;
    float totalAmt;
    
}

@end

@implementation PayMentViewController

-(id)init
{
    self = [super initWithNibName:@"PayMentViewController"  bundle:nil];
    if (self != nil) {
        // further initialization needed
        

    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    totalAmt = 0.0;
     objappShareManager=[appShareManager sharedManager];
    
    _btnCancel.layer.cornerRadius = _btnCancel.frame.size.width/2;
    _btnCancel.clipsToBounds = YES;
    
    [APPDATA showLoader];
    void (^successed)(id responseObject) = ^(id responseObject)
    {
        [APPDATA hideLoader];
        
        NSDictionary *dic=[responseObject objectForKey:@"data"];
        
        
        
        
        bid_amount_arr=[[NSMutableArray alloc]init];
        
        bid_amount_arr=[[dic valueForKey:@"payment"]valueForKey:@"bid_amount"];
        
        commission_percent_arr=[[NSMutableArray alloc]init];
        
        commission_percent_arr=[[dic valueForKey:@"payment"]valueForKey:@"commission_percent"];
        
        shipment_title_arr=[[NSMutableArray alloc]init];
        
        shipment_title_arr=[[dic valueForKey:@"payment"]valueForKey:@"shipment_title"];
        NSLog(@"Data==>%@",dic);

//        NSLog(@"Message:=%@",[responseObject valueForKey:@"message"]);
//        UIAlertView *err4 = [[UIAlertView alloc]
//                             initWithTitle:@"" message:[responseObject valueForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [err4 show];
//        
        //        self.txt_Amount.text = [NSString stringWithFormat:@"%@",[bidDataDict valueForKey:@"bid_amount"]];
        //
        //        self.txt_View_T_and_C.text = [NSString stringWithFormat:@"%@",[bidDataDict valueForKey:@"description"]];
        for (int i = 0; i<bid_amount_arr.count; i++)
        {
        
            float fltBidAmt = [[bid_amount_arr objectAtIndex:i] floatValue];
            float fltComPer = [[commission_percent_arr objectAtIndex:i]floatValue];
            float FltComAmt = (fltBidAmt*fltComPer)/100;
           
//            cell.lblCommissionAmtOut.text = [NSString stringWithFormat:@"%.2f",FltComAmt];
            totalAmt  = totalAmt + FltComAmt;
            self.lblTotalAmtOut.text = [NSString stringWithFormat:@"%.2f",totalAmt];
        
        }
       
        //NSString *bitAmt = [NSString stringWithFormat:@"%@",([bid_amount_arr objectAtIndex:indexPath.row]*[commission_percent_arr objectAtIndex:indexPath.row])/(100)];
        //cell.lblCommissionAmtOut.text=
        
        [_tblPaymentList reloadData];
        
    };
    
    void (^failure)(NSError * error) = ^(NSError *error)
    {
        [APPDATA hideLoader];
        
    };
    
    
//    NSString *useridStr=[NSString stringWithFormat:@"%@",[objappsharemanager.loginDic valueForKey:@"user_id"]];
//    
    NSDictionary *dict = @{@"carrier_id":[NSString stringWithFormat:@"%@",[objappShareManager.loginDic valueForKey:@"user_id"]]};
    
    [ApiCall sendToService:API_PAYMENT_LIST andDictionary:dict success:successed failure:failure];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 
    return [bid_amount_arr count];
    //return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"PayMentTableViewCell";
    
    
    cell=(PayMentTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    
    if (cell == nil) {
        cell = [[PayMentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        

    }
    cell.lblBidAmount.text=[NSString stringWithFormat:@"%@",[bid_amount_arr objectAtIndex:indexPath.row]];
     cell.lblCommisionPercentage.text=[NSString stringWithFormat:@"%@",[commission_percent_arr objectAtIndex:indexPath.row]];
    
    cell.lblShipmentTitle.text=[NSString stringWithFormat:@"%@",[shipment_title_arr objectAtIndex:indexPath.row]];
    
    float fltBidAmt = [[bid_amount_arr objectAtIndex:indexPath.row] floatValue];
    float fltComPer = [[commission_percent_arr objectAtIndex:indexPath.row]floatValue];
    float FltComAmt = (fltBidAmt*fltComPer)/100;
    cell.lblCommissionAmtOut.text = [NSString stringWithFormat:@"%.2f",FltComAmt];
  
    

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


- (IBAction)btnCancel:(id)sender {
    
    
    self.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, .3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        
        [self.view removeFromSuperview];
        
        [self removeFromParentViewController];
        
        [self didMoveToParentViewController:nil];
        
        
    });
    
    
    [UIView animateWithDuration:0.3/1.5 animations:^{
        self.view.transform=CGAffineTransformScale(CGAffineTransformIdentity,.9,0.9);
        
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3/2 animations:^{
            self.view.transform=CGAffineTransformScale(CGAffineTransformIdentity,0.001,0.001);
            
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/2 animations:^{
                self.view.transform=CGAffineTransformIdentity;
                
                
            }];
        }];
    }];
    

    
    
}

- (IBAction)btnPayActions:(id)sender
{
    
    self.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, .3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        
        [self.view removeFromSuperview];
        
        [self removeFromParentViewController];
        
        [self didMoveToParentViewController:nil];
        
        
    });
    
    
    [UIView animateWithDuration:0.3/1.5 animations:^{
        self.view.transform=CGAffineTransformScale(CGAffineTransformIdentity,.9,0.9);
        
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3/2 animations:^{
            self.view.transform=CGAffineTransformScale(CGAffineTransformIdentity,0.001,0.001);
            
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/2 animations:^{
                self.view.transform=CGAffineTransformIdentity;
                
                
            }];
        }];
    }];
    
    
    
    
    
    PaymentPageViewController *objPaymentPageViewController =(PaymentPageViewController *) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"PaymentPageViewController"];
    
    
    [APPDATA pushNewViewController:objPaymentPageViewController];

    
    
}
@end
