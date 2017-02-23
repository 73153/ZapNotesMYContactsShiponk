//
//  TransporterDetailViewController.m
//  ShiponK
//
//  Created by datt on 17/03/1938 SAKA.
//  Copyright © 1938 SAKA com.zaptechsolution. All rights reserved.
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

@interface TransporterDetailViewController() <UITableViewDataSource,UITableViewDelegate>{
    BOOL serachBtnClick;
   
    NSString *img_url;
    
    NSString *dateString,*stringDate1,*stringDate;
    
    NSString *ddateString,*dstringDate1,*dstringDate;
   
    NSDateFormatter *dateFormatter,*dateFormatter1,*dateFormatter2;
  
    NSDateFormatter *ddateFormatter,*ddateFormatter1,*ddateFormatter2;

    NSDate *dateFromString;
    NSDate *ddateFromString;
    NSMutableArray *shipmethArray;
    
    appShareManager *objappShareManager;
    
    NSMutableString * resultId;
    ComMehod *com;
    MyShipment_TableViewCell *cell;
    CGSize optimumSize;
    UIRefreshControl *refreshControl;
    NSString * page;
    NSString *offsetStr;
}


@end

@implementation TransporterDetailViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    com=[[ComMehod alloc]init];
    [com getTransporterCategory];

    serachBtnClick=YES;
    objappShareManager=[appShareManager sharedManager];
    [_btnMenuOut addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleLeftMenu) forControlEvents:UIControlEventTouchUpInside];
    
    shipmethArray=[[NSMutableArray alloc]init];
    
    objappShareManager=[appShareManager sharedManager];
    
    objappShareManager.CarrierProfileViewShowID=[NSString stringWithFormat:@"1"];
    
    
    
    
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:@"tableReload" object:nil];
    
    
    refreshControl = [[UIRefreshControl alloc]init];
    [self.tblTransporterDetail addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(getTransporterDetail) forControlEvents:UIControlEventValueChanged];
    
    
    
 
}


-(void)reloadData{
    
    page=@"0";
    offsetStr=@"0";
    
    shipmethArray=[[NSMutableArray alloc]init];
    [self  getTransporterDetail];
    
    [self.tblTransporterDetail reloadData];
    
    
}

-(void)getTransporterDetail
{
    
    
    [APPDATA showLoader];
    
        void (^successed)(id responseObject) = ^(id responseObject)
    {[APPDATA hideLoader];
        
        
        page=[responseObject valueForKey:@"page"];
        
        offsetStr=[responseObject valueForKey:@"offset"];
       
        
        img_url = [[responseObject valueForKey:@"data"]valueForKey:@"category_image_url"];
       
        
        NSArray *arrTemp=[[responseObject valueForKey:@"data"]valueForKey:@"data"];
        
        for (int i=0; i<arrTemp.count; i++)
        {
            [shipmethArray addObject:[arrTemp objectAtIndex:i]];
        }
       
       
        [refreshControl endRefreshing];
        [self.tblTransporterDetail reloadData];
        
    };
    
    void (^failure)(NSError * error) = ^(NSError *error)
    {
        [APPDATA hideLoader];
        
    };
    
        NSMutableDictionary *sendDic = [[NSMutableDictionary alloc]init];
        [sendDic setValue:offsetStr forKey:@"offset"];
        [sendDic setValue:page forKey:@"page"];
        [sendDic setValue:[objappShareManager.SelectedCatagoryDic valueForKey:@"SubCategoryID"] forKey:@"sub_category"];
        [sendDic setValue:[objappShareManager.SelectedCatagoryDic valueForKey:@"move_from"] forKey:@"move_from"];
        [sendDic setValue:[objappShareManager.SelectedCatagoryDic valueForKey:@"move_to"] forKey:@"move_to"];
        [sendDic setValue:[objappShareManager.SelectedCatagoryDic valueForKey:@"isurgent"] forKey:@"isurgent"];
    
        [sendDic setValue:[objappShareManager.loginDic valueForKey:@"user_id"] forKey:@"carrier_id"];
    
    
    
    
        [ApiCall sendToService:API_SHIPMENT_LIST_FOR_TRANSPORTER andDictionary:sendDic success:successed failure:failure];
    
   
    
}
-(void)viewWillAppear:(BOOL)animated
{
    if ([[objappShareManager.loginDic valueForKey:@"payment_pending"]isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        PayMentViewController *controller =(PayMentViewController *) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"PayMentViewController"];
        
        
        controller.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
        
        [self.view addSubview:controller.view];
        [self addChildViewController:controller];
        [controller didMoveToParentViewController:self];

        [UIView animateWithDuration:0.3/1.5 animations:^{
            controller.view.transform=CGAffineTransformScale(CGAffineTransformIdentity,1.1,1.1);
            
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/2 animations:^{
                controller.view.transform=CGAffineTransformScale(CGAffineTransformIdentity,0.9,0.9);
                
            }completion:^(BOOL finished) {
                [UIView animateWithDuration:0.3/2 animations:^{
                    controller.view.transform=CGAffineTransformIdentity;
                    
                    
                }];
            }];
        }];
   
        
        
    }
    
    page=@"0";
    offsetStr=@"0";
    shipmethArray=[[NSMutableArray alloc]init];
    [self getTransporterDetail];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
       return [shipmethArray count];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    static NSString *simpleTableIdentifier = @"MyShipment_Cell";
    
    cell = (MyShipment_TableViewCell *)[_tblTransporterDetail dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if(cell == nil) {
        cell = [[MyShipment_TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }

    cell.lbl_Title.text = [[[shipmethArray objectAtIndex:indexPath.row]valueForKey:@"title"] uppercaseString];
    cell.lbl_km.text = [NSString stringWithFormat:@"%@ KM",[[shipmethArray objectAtIndex:indexPath.row]valueForKey:@"kilometers"]];
    
    cell.lbl_to.text=[NSString stringWithFormat:@"%@",[[shipmethArray objectAtIndex:indexPath.row]valueForKey:@"to_city"]];
    
    cell.lbl_from.text=[NSString stringWithFormat:@"%@",[[shipmethArray objectAtIndex:indexPath.row]valueForKey:@"from_city"]];
    cell.lbl_pickup_date.text=[NSString stringWithFormat:@"%@",[[shipmethArray objectAtIndex:indexPath.row]valueForKey:@"pickup_date_time"]];
    

    NSString *imgstr=[NSString stringWithFormat:@"%@%@",img_url,[[shipmethArray objectAtIndex:indexPath.row]valueForKey:@"sub_category_image"]];
    
    cell.img_ship.layer.cornerRadius=cell.img_ship.frame.size.width/2.0;
    cell.img_ship.layer.masksToBounds=YES;
    cell.img_ship.clipsToBounds=YES;

     [cell.img_ship setImageWithURL:[NSURL URLWithString:imgstr] placeholderImage:[UIImage imageNamed:@""] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    NSCharacterSet *charsToTrim = [NSCharacterSet characterSetWithCharactersInString:@"< > null()  \n\""];
    
    NSString *strStus=[NSString stringWithFormat:@"%@",[[shipmethArray valueForKey:@"transporter_status"] objectAtIndex:indexPath.row]];
    
    strStus = [strStus stringByTrimmingCharactersInSet:charsToTrim];
     cell.lblTotalBid.text=[NSString stringWithFormat:@"Total Bid: %@",[[shipmethArray valueForKey:@"total_bids"] objectAtIndex:indexPath.row]];
  
    cell.lblTotalBid.hidden=NO;
    if ([strStus length]<1)
    {
          cell.image_myship.hidden=YES;
        
          cell.btn_quotenow.hidden=NO;
          cell.btn_cancel.hidden=YES;
          cell.lblcompleted.hidden=YES;
          cell.btn_comp.hidden=YES;
    } else if ([strStus isEqualToString:@"0"])
        {
            cell.image_myship.hidden=NO;
            [cell.imge_status setImage:[UIImage imageNamed:@"btnpin"]];
            cell.btn_cancel.hidden=YES;
            cell.btn_pickup.hidden=YES;
            cell.lblcompleted.hidden=YES;
            
            cell.btn_quotenow.hidden=NO;
            cell.btn_comp.hidden=YES;
        }else if([strStus isEqualToString:@"1"]){
            
            [cell.imge_status setImage:[UIImage imageNamed:@"btnhole"]];
            
            UIImage * buttonImage = [UIImage imageNamed:@"btn_pickup"];
            
            [cell.btn_pickup setImage:buttonImage forState:UIControlStateNormal];
            
            cell.btn_cancel.hidden=YES;
            cell.btn_pickup.hidden=YES;
            cell.lblcompleted.hidden=YES;
            
            cell.lblcompleted.text=@"Change in your bid!";
            cell.lblcompleted.textColor=[UIColor redColor];
            
            cell.image_myship.hidden=YES;
            cell.btn_quotenow.hidden=NO;
            cell.btn_comp.hidden=YES;
            
        }else if([strStus isEqualToString:@"2"])
        {
            [cell.imge_status setImage:[UIImage imageNamed:@"btnhole"]];
            
            UIImage * buttonImage = [UIImage imageNamed:@"btn_deliverd"];
            
            [cell.btn_pickup setImage:buttonImage forState:UIControlStateNormal];
            cell.btn_cancel.hidden=YES;
            cell.btn_pickup.hidden=YES;
            cell.lblcompleted.hidden=YES;
            cell.lblcompleted.text=@"Accepted";
            cell.lblcompleted.textColor=[UIColor grayColor];
            
            cell.image_myship.hidden=YES;
            cell.btn_quotenow.hidden=NO;
            cell.btn_comp.hidden=YES;
            
        }else if([strStus isEqualToString:@"3"])
        {
            [cell.imge_status setImage:[UIImage imageNamed:@"btnhole"]];
            
            UIImage * buttonImage = [UIImage imageNamed:@"btn_deliverd"];
            
            [cell.btn_pickup setImage:buttonImage forState:UIControlStateNormal];
            cell.btn_cancel.hidden=YES;
            cell.btn_pickup.hidden=YES;
            cell.lblcompleted.hidden=YES;
            cell.lblcompleted.text=@"Pick up";
            cell.lblcompleted.textColor=[UIColor grayColor];
            
            cell.image_myship.hidden=YES;
            cell.btn_quotenow.hidden=NO;
            
            cell.btn_comp.hidden=YES;
        }
        
        else
        {
            //btnhole
            
            [cell.imge_status setImage:[UIImage imageNamed:@"btnhole"]];
            cell.btn_cancel.hidden=YES; 
            cell.btn_pickup.hidden=YES;
            cell.lblcompleted.hidden=YES;
            
            cell.lblTotalBid.hidden=YES;
            
            cell.image_myship.hidden=YES;
            cell.btn_comp.hidden=NO;
            
        }
        
    
    
    cell.btn_quotenow.tag=indexPath.row;
    
    [cell.btn_quotenow addTarget:self
                        action:@selector(quotenowBtnMethod:)
              forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    // cell.btn_pickup.tag=indexPath.row;
    
    ///[cell.btn_pickup addTarget:self
    //                    action:@selector(pickBtnMethod:)
             // forControlEvents:UIControlEventTouchUpInside];
    
    
   // cell.btn_cancel.tag=indexPath.row;
    
    ///[cell.btn_cancel addTarget:self
                       // action:@selector(cancelBtnMethod:)
              //forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
     return cell;

    
}

-(IBAction)quotenowBtnMethod:(id)sender{
    
    Transporter_Description_ViewController *objviewController =(Transporter_Description_ViewController *) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"Transporter_Description_ViewController"];
    
    objappShareManager.Shipment_id=[NSString stringWithFormat:@"%@",[[shipmethArray objectAtIndex:[sender tag]]valueForKey:@"id"]];
    
    [[self navigationController]pushViewController:objviewController animated:YES];
    
}

-(IBAction)cancelBtnMethod:(id)sender
{
    
    
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@""
                                  message:@"You sure cancel this bid?"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             
                             NSString *sid=[NSString stringWithFormat:@"%@",[[shipmethArray valueForKey:@"id"] objectAtIndex:[sender tag]]];
                             
                             
                             [APPDATA showLoader];
                             
                             void (^successed)(id responseObject) = ^(id responseObject)
                             {
                                 [APPDATA hideLoader];
                                 
                                 
                                 page=@"0";
                                 offsetStr=@"0";
                                shipmethArray=[[NSMutableArray alloc]init];
                                 [self getTransporterDetail];
                                 
                                 
                             };
                             
                             void (^failure)(NSError * error) = ^(NSError *error)
                             {
                                 [APPDATA hideLoader];
                             };
                             
                             NSString *useridStr=[NSString stringWithFormat:@"%@",[objappShareManager.loginDic valueForKey:@"user_id"]];
                             
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


-(IBAction)pickBtnMethod:(id)sender{
    // no
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
         
    Transporter_Description_ViewController *objviewController =(Transporter_Description_ViewController *) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"Transporter_Description_ViewController"];

   objappShareManager.Shipment_id=[NSString stringWithFormat:@"%@",[[shipmethArray objectAtIndex:indexPath.row]valueForKey:@"id"]];
       
    [[self navigationController]pushViewController:objviewController animated:YES];
        
}
- (UIImage *) changeColorForImage:(UIImage *)image toColor:(UIColor*)color {
    UIGraphicsBeginImageContext(image.size);
    
    CGRect contextRect;
    contextRect.origin.x = 0.0f;
    contextRect.origin.y = 0.0f;
    contextRect.size = [image size];
    // Retrieve source image and begin image context
    CGSize itemImageSize = [image size];
    CGPoint itemImagePosition;
    itemImagePosition.x = ceilf((contextRect.size.width - itemImageSize.width) / 2);
    itemImagePosition.y = ceilf((contextRect.size.height - itemImageSize.height) );
    
    UIGraphicsBeginImageContext(contextRect.size);
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    // Setup shadow
    // Setup transparency layer and clip to mask
    CGContextBeginTransparencyLayer(c, NULL);
    CGContextScaleCTM(c, 1.0, -1.0);
    CGContextClipToMask(c, CGRectMake(itemImagePosition.x, -itemImagePosition.y, itemImageSize.width, -itemImageSize.height), [image CGImage]);
    // Fill and end the transparency layer
    
    
    const float* colors = CGColorGetComponents( color.CGColor );
    CGContextSetRGBFillColor(c, colors[0], colors[1], colors[2], .75);
    
    contextRect.size.height = -contextRect.size.height;
    contextRect.size.height -= 15;
    CGContextFillRect(c, contextRect);
    CGContextEndTransparencyLayer(c);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


- (IBAction)btnSearchAction:(id)sender
{

     SelectedCategoryViewController  *objViewController = (SelectedCategoryViewController *) [[UIStoryboard storyboardWithName:@"Main" bundle:nil]        instantiateViewControllerWithIdentifier:@"SelectedCategoryViewController"] ;
    [self.view addSubview:objViewController.view];
    [self addChildViewController:objViewController];
    [objViewController didMoveToParentViewController:self];


}



@end
