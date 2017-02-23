//
//  MyBideViewController.m
//  ShiponK
//
//  Created by Bhushan on 7/1/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//
#import "TransporterDetailViewController.h"
#import "TransporterDetailTableViewCell.h"
#import "ApiCall.h"
#import "Constant.h"
#import "ApplicationData.h"
#import "appShareManager.h"
#import "ComMehod.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "ApplicationData.h"
#import "Transporter_Description_ViewController.h"
#import "SlideNavigationController.h"
#import "ComMehod.h"
#import "SelectedCategoryViewController.h"
#import "PayMentViewController.h"
#import "MyShipment_TableViewCell.h"
#import "MyBideViewController.h"

@interface MyBideViewController () <UITableViewDataSource,UITableViewDelegate>{
    appShareManager *objappsharemanager;
    NSDictionary *shipDict,*shipDict1,*shipImagesDict;
    NSMutableArray *shipDictArray1;
    NSString *dateString,*stringDate1,*stringDate;
    NSDateFormatter *dateFormatter,*dateFormatter1,*dateFormatter2;
    NSDate *dateFromString;
    CGSize optimumSize;
    NSString *strFromLat,*strFromLong,*strToLat,*strToLong,*strFromLatLong,*strToLatLong,*datestr,*timestr;
    
    NSData *alldata;
    NSMutableDictionary *data1;
    NSString *useridStr,*ShipmentidStr;
    MyShipment_TableViewCell *cell;
    NSDictionary *dict;
    NSString *ulimge;
    UIRefreshControl *refreshControl;
    NSString * page;
    NSString *offsetStr;
    NSString *activeCompStr;
    
}
@end

@implementation MyBideViewController

@synthesize tblView_myshipment,shipmentDic;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _view_noShipmentFound.hidden = YES;
    objappsharemanager=[appShareManager sharedManager];
    
    
    [_menuButton addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleLeftMenu) forControlEvents:UIControlEventTouchUpInside];
    
    
    refreshControl = [[UIRefreshControl alloc]init];
    [tblView_myshipment addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(My_Shipment_Detail) forControlEvents:UIControlEventValueChanged];
    
    shipmentDic=[[NSMutableArray alloc]init];
    
    page=@"0";
    offsetStr=@"0";
    activeCompStr=@"0";
    [self My_Shipment_Detail];
    [tblView_myshipment reloadData];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    
    
}


-(void)My_Shipment_Detail
{
    if(![page isEqual:@""])
    {
        
    [APPDATA showLoader];
    
    void (^successed)(id responseObject) = ^(id responseObject)
    {
        [APPDATA hideLoader];
        
        page=[responseObject valueForKey:@"page"];
        offsetStr=[responseObject valueForKey:@"offset"];
        NSDictionary* dic=[responseObject objectForKey:@"data"];
        NSArray *arrTemp=[[responseObject valueForKey:@"data"]valueForKey:@"bid_list"];
        
        for (int i=0; i<arrTemp.count; i++)
        {
            [shipmentDic addObject:[arrTemp objectAtIndex:i]];
        }
        
        
        ulimge=[dic objectForKey:@"category_image_url"];
        
        objappsharemanager.Shipment_id=[[NSString alloc]init];
        
        
        if (shipmentDic.count<1)
        {
            tblView_myshipment.hidden=YES;
            _view_noShipmentFound.hidden = NO;
        }
        
        self.tblView_myshipment.delegate=self;
        self.tblView_myshipment.dataSource=self;
        
        
        [refreshControl endRefreshing];
        [tblView_myshipment reloadData];
        
    };
    
    void (^failure)(NSError * error) = ^(NSError *error)
    {
        [APPDATA hideLoader];
    };
    
    useridStr=[NSString stringWithFormat:@"%@",[objappsharemanager.loginDic valueForKey:@"user_id"]];
    
        if ([page length]>0)
        {
            
            NSDictionary *dict1 = @{@"carrier_id":useridStr,@"offset":offsetStr,@"page":page,@"status":activeCompStr};
            
            [ApiCall sendToService:API_TRANSPORTER_BID_LIST andDictionary:dict1 success:successed failure:failure];
            
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                            message:@"Shipment not found"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        
   
    }else{
        
        
        [refreshControl endRefreshing];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//--------------------------/ TableView Delegate /-----------------------------------


#pragma mark TableView Delegate Method ..............
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return shipmentDic.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 140;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"MyShipment_Cell";
    
    cell = (MyShipment_TableViewCell *)[tblView_myshipment dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if(cell == nil) {
        cell = [[MyShipment_TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.lbl_Title.text=[[NSString stringWithFormat:@"%@",[[shipmentDic valueForKey:@"title"] objectAtIndex:indexPath.row]] uppercaseString];
    
    
    cell.lbl_pickup_date.text=[NSString stringWithFormat:@"%@",[[shipmentDic valueForKey:@"pickup_date_time"] objectAtIndex:indexPath.row]];
    
    
    cell.img_ship.layer.cornerRadius=cell.img_ship.frame.size.width/2.0;
    cell.img_ship.layer.masksToBounds=YES;
    cell.img_ship.clipsToBounds=YES;
    
    NSString *img=[NSString stringWithFormat:@"%@%@",ulimge,[[shipmentDic valueForKey:@"sub_category_image"] objectAtIndex:indexPath.row]];
    
    NSString *imgCo=[NSString stringWithFormat:@"%@",[shipmentDic valueForKey:@"sub_category_image"]];
    
    
    if ([imgCo length]<1)
    {
        [cell.img_ship setImage:[UIImage imageNamed:@"CollCellStaticImg"]];
        
    }else{
        [cell.img_ship setImageWithURL:[NSURL URLWithString:img] placeholderImage:[UIImage imageNamed:@"myImage.jpg"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    
    cell.lbl_from.text=[NSString stringWithFormat:@"%@",[[shipmentDic valueForKey:@"from_city"] objectAtIndex:indexPath.row]];
    
    
    
    cell.lbl_km.text=[NSString stringWithFormat:@"%@ Km",[[shipmentDic valueForKey:@"kilometers"] objectAtIndex:indexPath.row]];
    
    
    
    NSString *strStus=[NSString stringWithFormat:@"%@",[[shipmentDic valueForKey:@"transporter_status"] objectAtIndex:indexPath.row]];
    
    cell.lblTotalBid.text=[NSString stringWithFormat:@"Total Bid: %@",[[shipmentDic valueForKey:@"total_bids"] objectAtIndex:indexPath.row]];
    
    
    cell.lblTotalBid.hidden=NO;
   
    
    if ([strStus isEqualToString:@"0"])
    {
        [cell.imge_status setImage:[UIImage imageNamed:@"btnpin"]];
        cell.btn_cancel.hidden=NO;
        cell.btn_pickup.hidden=YES;
        cell.lblcompleted.hidden=YES;
         cell.btn_comp.hidden=YES;
    }else if([strStus isEqualToString:@"1"]){
        
        [cell.imge_status setImage:[UIImage imageNamed:@"btnhole"]];
        
        UIImage * buttonImage = [UIImage imageNamed:@"btn_pickup"];
        
        [cell.btn_pickup setImage:buttonImage forState:UIControlStateNormal];
        
        cell.btn_cancel.hidden=NO;
        cell.btn_pickup.hidden=YES;
        cell.lblcompleted.hidden=NO;
         cell.btn_comp.hidden=YES;
        cell.lblcompleted.text=@"Change in your bid!";
        cell.lblcompleted.textColor=[UIColor redColor];
        
    }else if([strStus isEqualToString:@"2"])
    {
        [cell.imge_status setImage:[UIImage imageNamed:@"btnhole"]];
        
        UIImage * buttonImage = [UIImage imageNamed:@"btn_deliverd"];
        
        [cell.btn_pickup setImage:buttonImage forState:UIControlStateNormal];
         cell.btn_cancel.hidden=NO;
         cell.btn_pickup.hidden=YES;
         cell.lblcompleted.hidden=NO;
         cell.lblTotalBid.text=@"Accepted";
         cell.lblTotalBid.textColor=[UIColor grayColor];
         cell.btn_comp.hidden=YES;
    }else if([strStus isEqualToString:@"3"])
    {
        [cell.imge_status setImage:[UIImage imageNamed:@"btnhole"]];
        
        UIImage * buttonImage = [UIImage imageNamed:@"btn_deliverd"];
        
        [cell.btn_pickup setImage:buttonImage forState:UIControlStateNormal];
        cell.btn_cancel.hidden=YES;
        cell.btn_pickup.hidden=YES;
        cell.lblcompleted.hidden=NO;
        cell.lblTotalBid.text=@"Picked";
        cell.lblTotalBid.textColor=[UIColor grayColor];
        cell.btn_comp.hidden=YES;
    }
    
    else
    {
        //btnhole
        
        [cell.imge_status setImage:[UIImage imageNamed:@"btnhole"]];
        cell.btn_cancel.hidden=YES;
        cell.btn_pickup.hidden=YES;
       
        cell.lblcompleted.hidden=YES;
        
        cell.btn_comp.hidden=NO;
        cell.lblTotalBid.hidden=YES;
    }
    
    
    
    
    cell.btn_cancel.tag=indexPath.row;
    
    [cell.btn_cancel addTarget:self
                        action:@selector(cancelBtnMethod:)
              forControlEvents:UIControlEventTouchUpInside];
    
    
    
    return cell;
    
    
    
}


-(IBAction)cancelBtnMethod:(id)sender
{
    
    
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@""
                                  message:@"You are sure delete your bid."
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             
                             NSString *sid=[NSString stringWithFormat:@"%@",[[shipmentDic valueForKey:@"id"] objectAtIndex:[sender tag]]];
                             
                             
                             [APPDATA showLoader];
                             
                             void (^successed)(id responseObject) = ^(id responseObject)
                             {
                                 [APPDATA hideLoader];
                                 page=@"0";
                                 offsetStr=@"0";
                                 shipmentDic=[[NSMutableArray alloc]init];
                                 [self My_Shipment_Detail];
                                 
                             };
                             
                             void (^failure)(NSError * error) = ^(NSError *error)
                             {
                                 [APPDATA hideLoader];
                             };
                             
                             useridStr=[NSString stringWithFormat:@"%@",[objappsharemanager.loginDic valueForKey:@"user_id"]];
                             
                             NSDictionary *dict1 = @{@"carrier_id":useridStr,@"shipmentid":sid};
                             
                             [ApiCall sendToService:API_CANCEL_BID andDictionary:dict1 success:successed failure:failure];
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    [alert addAction:ok];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
  
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Transporter_Description_ViewController *objviewController =(Transporter_Description_ViewController *) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"Transporter_Description_ViewController"];
    
    objappsharemanager.Shipment_id=[NSString stringWithFormat:@"%@",[[shipmentDic objectAtIndex:indexPath.row]valueForKey:@"id"]];
    
    [[self navigationController]pushViewController:objviewController animated:YES];
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 0)
    {
        void (^successed)(id responseObject) = ^(id responseObject)
        {
            [APPDATA hideLoader];
            
            [self.tblView_myshipment reloadData];
            [self My_Shipment_Detail];
        };
        
        void (^failure)(NSError * error) = ^(NSError *error)
        {
            [APPDATA hideLoader];
            
        };
        [ApiCall sendToService:API_DELETE_SHIPMENT andDictionary:dict success:successed failure:failure];
        
        
    }
    else
    {
        [self.tblView_myshipment reloadData];
        
    }
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        useridStr =[NSString stringWithFormat:@"%@",[objappsharemanager.loginDic valueForKey:@"user_id"]];
        
        ShipmentidStr = [NSString stringWithFormat:@"%@",[[shipDict valueForKey:@"id"]objectAtIndex:indexPath.row]];
        
        dict = @{@"userid":useridStr,@"shipmentid":ShipmentidStr};
        
        
        //
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@""                                                          message:@"Do you want delete shipment ?"                                                         delegate:self                                                cancelButtonTitle:@"OK"                                                otherButtonTitles:@"Cancel",nil];
        
        [message show];
    }
    
}

- (IBAction)btnActiveAction:(id)sender {
    page=@"0";
    offsetStr=@"0";
    activeCompStr=@"0";
    shipmentDic=[[NSMutableArray alloc]init];
    [self My_Shipment_Detail];
    [_btnactive setBackgroundColor:[UIColor yellowColor]];
    [_btncompleted setBackgroundColor:[UIColor lightGrayColor]];

}

- (IBAction)btnCompAction:(id)sender {
    
    [_btnactive setBackgroundColor:[UIColor lightGrayColor]];
    [_btncompleted setBackgroundColor:[UIColor yellowColor]];
    page=@"0";
    offsetStr=@"0";
    activeCompStr=@"1";
    shipmentDic=[[NSMutableArray alloc]init];
    [self My_Shipment_Detail];

}
@end
