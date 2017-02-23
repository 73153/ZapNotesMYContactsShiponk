//
//  MyShipment_ViewController.m
//  ShiponK
//
//  Created by ronakj on 5/27/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//
#import "RTLabel.h"
#import "MyShipment_ViewController.h"
#import "MyShipment_TableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "order_history_ViewController.h"
#import "Shipment_Description_ViewController.h"
#import "appShareManager.h"
#import "Constant.h"
#import "ApiCall.h"
#import <QuartzCore/QuartzCore.h>
#import "ApplicationData.h"
#import <CoreText/CoreText.h>
#import "SlideNavigationController.h"
#import "ApplicationData.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "Feedback_And_Review_ViewController.h"



@interface MyShipment_ViewController ()
{
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
    NSString *shipStr;
    NSString *activeCompStr,*page,*offset;
    NSString * pageStatus;
    NSDictionary *RatDicInfo;
  
}
@end

@implementation MyShipment_ViewController
@synthesize tblView_myshipment,shipmentDic;

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    _view_noShipmentFound.hidden = YES;
    objappsharemanager=[appShareManager sharedManager];
    
     [_menuButton addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleLeftMenu) forControlEvents:UIControlEventTouchUpInside];
    
    
    refreshControl = [[UIRefreshControl alloc]init];
    [tblView_myshipment addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(ReloadMyShipMent) forControlEvents:UIControlEventValueChanged];
    
        
    
    
   
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    
    pageStatus=@"0";
    page=@"0";
    offset=@"0";
    activeCompStr=@"0";
    shipmentDic=[[NSMutableArray alloc]init];
    [self My_Shipment_Detail];
}

//.......................................................................................

#pragma mark My_Shipment_Detail Post method calling..

-(void)My_Shipment_Detail
{
    [APPDATA showLoader];
   
    
    void (^successed)(id responseObject) = ^(id responseObject)
    {
        [APPDATA hideLoader];
         NSDictionary* dic=[responseObject objectForKey:@"data"];
        
        pageStatus=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"page"]];
        
        
        NSArray *arrTemp=[dic objectForKey:@"data"];
        
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
        }else
        {
              tblView_myshipment.hidden=NO;
             _view_noShipmentFound.hidden = YES;
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
    
    //page:page number , offset:number of iteam,activeCompStr:0=Active shipment,1=Completed,
    
    if ([pageStatus length]>0)
    {
        
        NSDictionary *dict1 = @{@"user_id":useridStr,@"offset":offset,@"page":page,@"status":activeCompStr};
        
        [ApiCall sendToService:API_SHIPMENT_LIST_FOR_CUSTOMER andDictionary:dict1 success:successed failure:failure];
    }
    else
    {
        [APPDATA hideLoader];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"Shipment not found"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
         [refreshControl endRefreshing];
    }
    
   
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//.......................................................................................

#pragma mark TableView Delegate Method.....

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
    
    
    [cell.lbl_Title setText:[[NSString stringWithFormat:@"%@",[[shipmentDic valueForKey:@"title"] objectAtIndex:indexPath.row]] uppercaseString]];
    
    
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
    
  
    cell.lblTotalBid.text=[NSString stringWithFormat:@"Total Bid: %@",[[shipmentDic valueForKey:@"total_bids"] objectAtIndex:indexPath.row]];
    cell.lblTotalBid.hidden=NO;
    
    NSString *strStus=[NSString stringWithFormat:@"%@",[[shipmentDic valueForKey:@"shipment_status"] objectAtIndex:indexPath.row]];
    
    
    NSCharacterSet *charsToTrim = [NSCharacterSet characterSetWithCharactersInString:@"< > null()  \n\""];
    
    NSString *tranStr=[NSString stringWithFormat:@"%@",[[shipmentDic valueForKey:@"accepted_transporter"] objectAtIndex:indexPath.row]];
    
    tranStr = [tranStr stringByTrimmingCharactersInSet:charsToTrim];
    
    //tranStr condiations:
    //[tranStr length]<1 & 0 :Action,1:Accepted,  2:Pick up , 3.Delivered, 4: Completed
    
    if ([tranStr length]<1)
    {
        [cell.imge_status setImage:[UIImage imageNamed:@"btnpin"]];
        cell.btn_cancel.hidden=YES;
        cell.btn_pickup.hidden=YES;
        cell.lblcompleted.hidden=NO;
        cell.lblcompleted.text=@"Active.";
        cell.btn_comp.hidden=YES;
    }else{
    
    if ([strStus isEqualToString:@"0"])
    {
         [cell.imge_status setImage:[UIImage imageNamed:@"btnpin"]];
         cell.btn_cancel.hidden=NO;
         cell.btn_pickup.hidden=YES;
         cell.lblcompleted.hidden=NO;
         cell.btn_comp.hidden=YES;
    }else if([strStus isEqualToString:@"1"]){
        
         [cell.imge_status setImage:[UIImage imageNamed:@"btnhole"]];
        
        [cell.btn_pickup setTitle:@"PICKED" forState:UIControlStateNormal];
        cell.btn_cancel.hidden=NO;
        cell.btn_pickup.hidden=NO;
        cell.lblcompleted.hidden=YES;
        cell.btn_comp.hidden=YES;
    }else if([strStus isEqualToString:@"2"])
    {
        [cell.imge_status setImage:[UIImage imageNamed:@"btnhole"]];
        [cell.btn_pickup setTitle:@"PICKED" forState:UIControlStateNormal];
        cell.btn_cancel.hidden=YES;
        cell.btn_pickup.hidden=NO;
        cell.lblcompleted.hidden=YES;
        cell.btn_comp.hidden=YES;
        
    }else if([strStus isEqualToString:@"3"])
    {
        [cell.imge_status setImage:[UIImage imageNamed:@"btnhole"]];
        
        [cell.btn_pickup setTitle:@"DELIVERED" forState:UIControlStateNormal];
        cell.btn_pickup.backgroundColor = [self colorWithHexString:@
                                           "#269900" alpha:1];
        
        cell.btn_cancel.hidden=YES;
        cell.btn_pickup.hidden=NO;
        cell.lblcompleted.hidden=YES;
        cell.btn_comp.hidden=YES;
        
    }else
    {
        [cell.imge_status setImage:[UIImage imageNamed:@"btnhole"]];
        cell.btn_cancel.hidden=YES;
        cell.btn_pickup.hidden=YES;
        cell.lblcompleted.hidden=YES;
        cell.btn_comp.hidden=NO;
        cell.lblTotalBid.hidden=YES;
       
    }
    }
    cell.btn_pickup.tag=indexPath.row;
    
    [cell.btn_pickup addTarget:self
                        action:@selector(pickBtnMethod:)
     forControlEvents:UIControlEventTouchUpInside];
    
    
    
    cell.btn_cancel.tag=indexPath.row;
    
    [cell.btn_cancel addTarget:self
                        action:@selector(cancelBtnMethod:)
              forControlEvents:UIControlEventTouchUpInside];
    
    
    return cell;
    
    
    
}
- (UIColor *)colorWithHexString:(NSString *)str_HEX  alpha:(CGFloat)alpha_range{
    int red = 0;
    int green = 0;
    int blue = 0;
    sscanf([str_HEX UTF8String], "#%02X%02X%02X", &red, &green, &blue);
    return  [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha_range];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    objappsharemanager.Shipment_id=[NSString stringWithFormat:@"%@",[[shipDict valueForKey:@"id"]objectAtIndex:indexPath.row]];
    
    
    Shipment_Description_ViewController *objviewController =(Shipment_Description_ViewController *) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"Shipment_Description_ViewController"];
    
    objviewController.ShipmentidStr = [NSString stringWithFormat:@"%@",[[shipmentDic valueForKey:@"id"] objectAtIndex:indexPath.row]];
    
    [[self navigationController]pushViewController:objviewController animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
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



//----------------------------------------------------------------------------
#pragma mark PickBtnMethod Delevery in tableview cell btn actions........


-(IBAction)pickBtnMethod:(id)sender
{
    UIButton *button = (UIButton *)sender;
    
    NSString *currentTitleStr=[NSString stringWithFormat:@"%@",button.currentTitle];
    
    NSString *strid=[NSString stringWithFormat:@"%@",[[shipmentDic valueForKey:@"accepted_transporter"]objectAtIndex:button.tag]];
    objappsharemanager.carrieridStr=[NSString stringWithFormat:@"%@",strid];
    
    NSString *bidid=[NSString stringWithFormat:@"%@",[[shipmentDic valueForKey:@"bidid"]objectAtIndex:button.tag]];
    
    NSString *strS;

    if ([currentTitleStr isEqualToString:@"PICKED"])
    {
        strS=@"3";
    }else if([currentTitleStr isEqualToString:@"DELIVERED"])
    {
        strS=@"4";
    }
    
    
    shipStr=[NSString stringWithFormat:@"%@",[[shipmentDic valueForKey:@"id"]objectAtIndex:button.tag]];
    
    
    
    NSString *msg;
    
    if ([strS isEqualToString:@"3"])
    {
        msg=@"Please click 'OK' if shipment is picked up by transporter.";
        
    }else if([strS isEqualToString:@"4"]){
         msg=@"Please click 'OK' if shipment is delievered.";
    }
    
    
    
    
    RatDicInfo=@{@"from_city":[NSString stringWithFormat:@"%@",[[shipmentDic valueForKey:@"from_city"]objectAtIndex:button.tag]],@"to_city":[NSString stringWithFormat:@"%@",[[shipmentDic valueForKey:@"to_city"]objectAtIndex:button.tag]],@"accepted_transporter":[NSString stringWithFormat:@"%@",[[shipmentDic valueForKey:@"accepted_transporter"]objectAtIndex:button.tag]],@"price":[NSString stringWithFormat:@"%@",[[shipmentDic valueForKey:@"price"]objectAtIndex:button.tag]],@"kilometers":[NSString stringWithFormat:@"%@",[[shipmentDic valueForKey:@"kilometers"]objectAtIndex:button.tag]],@"shipment_id":shipStr};
    
    
    
    
   



    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@""
                                  message:msg
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             
                             [self accptBidMethod:bidid second:strS];
                             
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


-(void)accptBidMethod:(NSString *)str second:(NSString *)mname
{
    
    [APPDATA showLoader];
    
    void (^successed)(id responseObject) = ^(id responseObject)
    {
        
        [APPDATA hideLoader];
        
        
        
        
        NSString *strCode=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"code"]];
        
        if ([strCode isEqualToString:@"1"]) {
            
            NSDictionary *dic=[responseObject objectForKey:@"data"];
            NSString *statusStr=[NSString stringWithFormat:@"%@",[dic valueForKey:@"status"]];
            
            if ([statusStr intValue]>=4)            {
                [self rateViewMthod];
            }
         
            
        }
        
        
        
        shipmentDic=[[NSMutableArray alloc]init];
        page=@"0";
        offset=@"0";
        activeCompStr=@"0";
        [self My_Shipment_Detail];
        
        
        
    };
    
    void (^failure)(NSError * error) = ^(NSError *error)
    {
        [APPDATA hideLoader];
    };
    
   
        
        NSDictionary *dict1 = @{@"shipmentid":shipStr,@"carrierid":objappsharemanager.carrieridStr,@"bidid":str,@"status":[NSString stringWithFormat:@"%@",mname]};
        
        
        [ApiCall sendToService:API_ACCEPT_BIDS andDictionary:dict1 success:successed failure:failure];
        
    
    

}

//---------------------------------------------------------------------------------------
#pragma mark RateviewMethod.......

-(void)rateViewMthod
{
    
        Feedback_And_Review_ViewController *controller2 =(Feedback_And_Review_ViewController *) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"Feedback_And_Review_ViewController"];
    
         controller2.raDict =RatDicInfo;
    
        controller2.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    
    
        [self.view addSubview:controller2.view];
        [self addChildViewController:controller2];
        [controller2 didMoveToParentViewController:self];
    
        [UIView animateWithDuration:0.3/1.5 animations:^{
            controller2.view.transform=CGAffineTransformScale(CGAffineTransformIdentity,1.1,1.1);
            
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/2 animations:^{
                controller2.view.transform=CGAffineTransformScale(CGAffineTransformIdentity,0.9,0.9);
                
            }completion:^(BOOL finished) {
                [UIView animateWithDuration:0.3/2 animations:^{
                    controller2.view.transform=CGAffineTransformIdentity;
                    
                    
                }];
            }];
        }];
        
    }


//--------------------------------------------------------------------------------
#pragma mark CancelBtn in tableview cell Method.........
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
                             
                               NSString *transporter_idStr=[NSString stringWithFormat:@"%@",[[shipmentDic valueForKey:@"transporter_id"] objectAtIndex:[sender tag]]];
                             
                             [APPDATA showLoader];
                             
                             void (^successed)(id responseObject) = ^(id responseObject)
                             {
                                 [APPDATA hideLoader];
                                 shipmentDic=[[NSMutableArray alloc]init];
                                 page=@"0";
                                 offset=@"0";
                                 activeCompStr=@"0";
                                 [self My_Shipment_Detail];
                                 
                                 
                             };
                             
                             void (^failure)(NSError * error) = ^(NSError *error)
                             {
                                 [APPDATA hideLoader];
                             };
                             
                             useridStr=[NSString stringWithFormat:@"%@",[objappsharemanager.loginDic valueForKey:@"user_id"]];
                             
                             NSDictionary *dict1 = @{@"carrier_id":transporter_idStr,@"shipmentid":sid,@"customer_id":useridStr};
                             
                             [ApiCall sendToService:API_CUSTOMER_CANCEL_BID andDictionary:dict1 success:successed failure:failure];
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
//----------------------------------------------------------------------------
/*
#pragma mark alertView Delegate Method ........
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
 */
//--------------------------------------------------------------------------------
#pragma mark Filter for active Shipment....
- (IBAction)btnActive_Actions:(id)sender {
    
    [_btnActive setBackgroundColor:[UIColor yellowColor]];
    [_btnComp setBackgroundColor:[UIColor lightGrayColor]];
    
    shipmentDic=[[NSMutableArray alloc]init];
    page=@"0";
    offset=@"0";
    pageStatus=@"0";
    activeCompStr=@"0";
    [self My_Shipment_Detail];
}

//--------------------------------------------------------------------------------

#pragma mark Filter for Completed Shipment....
- (IBAction)btn_Completed_Actions:(id)sender {
    
    [_btnActive setBackgroundColor:[UIColor lightGrayColor]];
    [_btnComp setBackgroundColor:[UIColor yellowColor]];
    shipmentDic=[[NSMutableArray alloc]init];
    page=@"0";
    offset=@"0";
    pageStatus=@"0";
    activeCompStr=@"1";
    [self My_Shipment_Detail];
}




-(void)ReloadMyShipMent
{
    [APPDATA showLoader];
    
    void (^successed)(id responseObject) = ^(id responseObject)
    {
        [APPDATA hideLoader];
        NSDictionary* dic=[responseObject objectForKey:@"data"];
        
        pageStatus=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"page"]];
        
        
        NSArray *arrTemp=[dic objectForKey:@"data"];
        
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
        }else
        {
            tblView_myshipment.hidden=NO;
            _view_noShipmentFound.hidden = YES;
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
    
    //page:page number , offset:number of iteam,activeCompStr:0=Active shipment,1=Completed,
    
    if ([pageStatus length]>0)
    {
        int NextPage=[page intValue];
        NextPage=NextPage+1;
        page=[NSString stringWithFormat:@"%d",NextPage];
        offset=[NSString stringWithFormat:@"%d",NextPage*10];
        
        NSDictionary *dict1 = @{@"user_id":useridStr,@"offset":offset,@"page":page,@"status":activeCompStr};
        
        [ApiCall sendToService:API_SHIPMENT_LIST_FOR_CUSTOMER andDictionary:dict1 success:successed failure:failure];
    }
    else
    {
        [APPDATA hideLoader];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"Shipment not found"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
        [refreshControl endRefreshing];
    }
    
    
}




@end
