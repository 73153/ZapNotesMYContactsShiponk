//
//  MyShipment_ViewController.m
//  ShiponK
//
//  Created by ronakj on 5/27/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

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



@interface MyShipment_ViewController ()
{
    appShareManager *objappsharemanager;
    NSDictionary *shipDict,*shipDict1;
    NSMutableArray *shipDictArray1;
    NSString *dateString,*stringDate1,*stringDate;
    NSDateFormatter *dateFormatter,*dateFormatter1,*dateFormatter2;
    NSDate *dateFromString;
}
@end

@implementation MyShipment_ViewController
@synthesize tblView_myshipment,shipmentDic;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    objappsharemanager=[appShareManager sharedManager];
    
       
    
     [_menuButton addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleLeftMenu) forControlEvents:UIControlEventTouchUpInside];
   
    [tblView_myshipment reloadData];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [self My_Shipment_Detail];
    
}
-(void)My_Shipment_Detail
{
    
    
    [APPDATA showLoader];
    
    void (^successed)(id responseObject) = ^(id responseObject)
    {
        [APPDATA hideLoader];
        
        
        
        self.tblView_myshipment.delegate=self;
        self.tblView_myshipment.dataSource=self;
        
        shipmentDic=[responseObject objectForKey:@"data"];
        shipDict=[shipmentDic objectForKey:@"data"];
        
        NSLog(@"%@",shipDict);
        //shipDict1=[_shipmentDic objectForKey:@"shipment_image_url"];
       
        
       
        [tblView_myshipment reloadData];
        
    };
    
    void (^failure)(NSError * error) = ^(NSError *error)
    {
        [APPDATA hideLoader];
    };
    
    NSString *useridStr=[NSString stringWithFormat:@"%@",[objappsharemanager.loginDic valueForKey:@"user_id"]];
    
    NSDictionary *dict = @{@"user_id":useridStr,@"offset":@"0",@"page":@"0"};
    
    [ApiCall sendToService:API_SHIPMENT_LIST_FOR_CUSTOMER andDictionary:dict success:successed failure:failure];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return shipDict.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"MyShipment_Cell";
    
    MyShipment_TableViewCell *cell = (MyShipment_TableViewCell *)[tblView_myshipment dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if(cell == nil) {
        cell = [[MyShipment_TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.lbl_Title.text=[NSString stringWithFormat:@"%@",[[shipDict valueForKey:@"title"] objectAtIndex:indexPath.row]];
  
   cell.txtDescriptionView.text=[NSString stringWithFormat:@"%@",[[shipDict valueForKey:@"description"] objectAtIndex:indexPath.row]];
    
    
//    
//    cell.img_ship.layer.cornerRadius=cell.img_ship.frame.size.width/2.0;
//    cell.img_ship.layer.masksToBounds=YES;
//    cell.img_ship.clipsToBounds=YES;
//    NSString *img=[NSString stringWithFormat:@"%@%@",shipDict1,[[shipDict valueForKey:@"photo"] objectAtIndex:indexPath.row]];
//    [cell.img_ship sd_setImageWithURL:[NSURL URLWithString:img]];
//    
    
    
    
    dateString = [NSString stringWithFormat:@"%@",[[shipDict valueForKey:@"created_at"] objectAtIndex:indexPath.row]];
    dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
     dateFromString= [[NSDate alloc] init];
   
    dateFromString = [dateFormatter dateFromString:dateString];
    
    
     dateFormatter1= [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"dd-MMM-yyyy"];
     stringDate= [dateFormatter1 stringFromDate:dateFromString];
    cell.lblDate.text=stringDate;
    
    //For Time fetching
    dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"hh:mm"];
    stringDate1 = [dateFormatter2 stringFromDate:dateFromString];
    
    cell.lblTime.text=stringDate1;
    
    
    return cell;
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 160;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
     Shipment_Description_ViewController *objviewController =(Shipment_Description_ViewController *) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"Shipment_Description_ViewController"];
    
    objviewController.ShipmentidStr = [NSString stringWithFormat:@"%@",[[shipDict valueForKey:@"id"] objectAtIndex:indexPath.row]];
    
      [[self navigationController]pushViewController:objviewController animated:YES];
}


- (IBAction)menu_Action:(id)sender {
}
@end
