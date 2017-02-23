//
//  VehicleTypeViewController.m
//  ShiponK
//
//  Created by Bhushan on 5/17/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import "VehicleTypeViewController.h"
#import "MBProgressHUD.h"
#import "ApiCall.h"
#import "appShareManager.h"
#import "VehicleTableViewCell.h"
#import "btypeTableViewCell.h"

@interface VehicleTypeViewController ()
{
    appShareManager *objappShareManager;
     NSString *btypeStr,*business_type;
    
}
@end

@implementation VehicleTypeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    objappShareManager = [appShareManager sharedManager];
    
    if ([objappShareManager.CarrierProfileViewShowID isEqualToString:@"1"])
    {
        business_type=[[[objappShareManager.carrierProfileDataDict valueForKey:@"profile"]objectAtIndex:0]valueForKey:@"business_type"];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btn_okAction:(id)sender
{
    //[self seleCtDictMethod];

    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
    
    
    
}
#pragma mark TableView Delegate

#pragma mark TableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex {
    
    
    return objappShareManager.AppbusnessArray.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"btypeTableViewCell";
    
    btypeTableViewCell  *cell = (btypeTableViewCell *)[self.tblvew_Vehicle dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSString *strtype = [NSString stringWithFormat:@"%@",[[objappShareManager.AppbusnessArray objectAtIndex:indexPath.row] valueForKey:@"name"]] ;
    
    NSString *bcheck;
    
    
    
    
    if ([business_type isEqualToString:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1]] ) {
        
        [cell.img_select setImage:[UIImage imageNamed:@"check.png"]];
    }
    else{
        
        bcheck = [NSString stringWithFormat:@"%@",[[objappShareManager.AppbusnessArray objectAtIndex:indexPath.row] valueForKey:@"id"]] ;
        if ([btypeStr isEqualToString:bcheck])
        {
            [cell.img_select setImage:[UIImage imageNamed:@"check.png"]];
        }else{
            [cell.img_select setImage:[UIImage imageNamed:@"uncheck.png"]];
        }
        
    }
    
    
    
    cell.lbl_name.text=strtype;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    business_type=nil;
    
    btypeStr=[NSString stringWithFormat:@"%@",[[objappShareManager.AppbusnessArray objectAtIndex:indexPath.row] valueForKey:@"id"]];
    [_tblvew_Vehicle reloadData];
    
    
}

-(void)seleCtDictMethod
{
    objappShareManager.selectVelicalArray=[[NSMutableArray alloc]init];
    objappShareManager.selectVelicalidArray=[[NSMutableArray alloc]init];
    for (int i=0; i<objappShareManager.VehicleTypeArray.count; i++) {
        
        
        NSString *strSel=[objappShareManager.sFlageArray objectAtIndex:i];
        if ([strSel isEqualToString:@"1"])
        {
            [objappShareManager.selectVelicalidArray addObject:[[objappShareManager.VehicleTypeArray objectAtIndex:i] valueForKey:@"id"]];
            
            [objappShareManager.selectVelicalArray addObject:[[objappShareManager.VehicleTypeArray objectAtIndex:i] valueForKey:@"name"]];
            
        }
        
        
    }
    
   
    
}



@end
