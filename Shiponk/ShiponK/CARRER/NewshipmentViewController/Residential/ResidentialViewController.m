//
//  ResidentialViewController.m
//  ShiponK
//
//  Created by Bhushan on 6/18/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import "ResidentialViewController.h"
#import "Constant.h"
#import "ApiCall.h"
#import "ApplicationData.h"
#import "appShareManager.h"

#import "ResidentialTblViewCell.h"
#import "New_shipment_page1.h"


@interface ResidentialViewController ()
{
    NSArray * idArray;
    NSArray * nameArray;
    appShareManager *objappShare;
    
}

@end

@implementation ResidentialViewController
@synthesize strResidenceBtnTag;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self LoginMainMethod];
    objappShare = [appShareManager sharedManager];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)LoginMainMethod
{
    
    [APPDATA showLoader];
    
    void (^successed)(id responseObject) = ^(id responseObject)
    {
        
        [APPDATA hideLoader];
        [self responsedata:responseObject];
        [self.TblViewResidentialOut reloadData];
    };
    
    void (^failure)(NSError * error) = ^(NSError *error)
    {
        [APPDATA hideLoader];
    };
    
    [ApiCall callGetWebService:API_WS_GET_LOACTIONS_TYPE andDictionary:nil success:successed failure:failure];
    
}
-(void)responsedata :(NSDictionary *)dic
{
    
    idArray = [[dic valueForKey:@"data"] valueForKey:@"id"];
    nameArray = [[dic valueForKey:@"data"] valueForKey:@"name"];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [nameArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"ResidentialTblViewCell";
    
    ResidentialTblViewCell* cell = (ResidentialTblViewCell *)[self.TblViewResidentialOut dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if(cell == nil) {
        cell = [[ResidentialTblViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.lblResidentialTblViewOut.text = [nameArray objectAtIndex:indexPath.row];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([strResidenceBtnTag isEqualToString:@"1"])
    {
        
        objappShare.pickResname=[NSString stringWithFormat:@"%@",[nameArray objectAtIndex:indexPath.row]];
        
        objappShare.pickResid=[NSString stringWithFormat:@"%@",[idArray objectAtIndex:indexPath.row]];
        
        
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"btnPickupText"
         object:nil];
        
        
    }
    else if ([strResidenceBtnTag isEqualToString:@"2"])
    {
        
       
        objappShare.DeliResname=[NSString stringWithFormat:@"%@",[nameArray objectAtIndex:indexPath.row]];
        
        objappShare.DeliResid=[NSString stringWithFormat:@"%@",[idArray objectAtIndex:indexPath.row]];
        
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"delisetbtnText"
         object:nil];
        
        
    }
    
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


- (IBAction)btnCloseAction:(id)sender {
    
    
    
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
@end
