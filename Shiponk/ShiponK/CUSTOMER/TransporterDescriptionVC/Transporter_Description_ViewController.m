
//
//  Transporter_Description_ViewController.m
//  ShiponK
//
//  Created by ronakj on 6/7/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import "Transporter_Description_ViewController.h"
#import "Transporter_TableViewCell.h"
#import "TransporterCollectionViewCell.h"
#import "Create_Bid_ViewController.h"
#import "Constant.h"
#import <SDWebImage/UIImageView+WebCache.h>

#import "appShareManager.h"
#import "ApplicationData.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"

#import "MDDirectionService.h"
#import <GoogleMaps/GoogleMaps.h>
#import "MapRoute.h"
#import "newCollectionViewCell.h"
#import "IteamDetailsViewcontroller.h"

@interface Transporter_Description_ViewController ()<GMSMapViewDelegate>
{
    
    GMSMapView *mapView_;
    
    NSMutableArray *waypoints_;
    NSMutableArray *waypointStrings_,* transMoveFromLat,* transMoveToLat,* transMoveFromLong,* transMoveToLong;
    
    appShareManager *objappsharemanager;

    NSMutableArray *dataArray,*imgArray,*nameArray,*TransimageDict;
    NSDictionary *transporterDataDict,*transporterDatalistDict,*transporterImageurl;
    
    NSDictionary *TransitemDict,*TransDic,*TransporterBidDict,*TransBidListDict;
    NSArray *TransArray;
    NSString *TransDictimageurl;
    
    NSString *dateString,*stringDate1,*stringDate,*stringImage,*strFromLat,*strToLat,*strFromLong,*strToLong,*strFromLatLong,*strToLatLong,*shipment_id;
    NSDateFormatter *dateFormatter,*dateFormatter1,*dateFormatter2;
    NSDate *dateFromString;
    
    NSMutableDictionary *data1;
    NSData *alldata;
    
    NSMutableArray *RouteLocation;
    NSMutableArray *RouteName;
    

    NSArray *shipmentItemDataArr;
    
    NSString *bidAv;
    NSDictionary *DicShip;
    NSCharacterSet *charsToTrim;
    NSString *bid_Flag;

}
@end

@implementation Transporter_Description_ViewController
//Synthesizes Properties
@synthesize tbl_Transporter_Out;
@synthesize strid;
- (void)viewDidLoad
{
    [super viewDidLoad];
  
    _View_No_Biddies_Found.hidden = YES;    
    
    [self.scrllView setContentSize:(CGSizeMake(self.scrllView.frame.size.width,550))];
    
     objappsharemanager=[appShareManager sharedManager];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(My_Shipment_Bids)
                                                 name:@"My_Shipment_Bids" object:nil];
    
      bid_Flag=@"0";
     [tbl_Transporter_Out reloadData];
    
    
     }

- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];
    
    if([self isViewLoaded] && self.view.window == nil)
    {
        self.view = nil;
    }

  
    
    [super didReceiveMemoryWarning];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated] ;
    [mapView_ clear];
    [mapView_ stopRendering] ;
    [mapView_ removeFromSuperview] ;
    
    
    mapView_ = nil ;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self My_Transporter_Detail];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
       
                [self My_Shipment_Bids];

    });

}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if ([bidAv length]<1)
    {
        
        
        if (TransBidListDict.count<1)
        {
            _View_No_Biddies_Found.hidden = NO;
            
           
        }else
        {
            _View_No_Biddies_Found.hidden = YES;
        }
        
         return TransBidListDict.count;
    }
    else
    {
        
        if (TransBidListDict.count<1)
        {
             _View_No_Biddies_Found.hidden = NO;
            
            return  TransBidListDict.count;
        }else
        {
           return 1;
        }
        
        
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([bidAv length]>0)
    {
        int inr=[bidAv intValue];
        
        indexPath = [NSIndexPath indexPathForRow:inr inSection: 0];
    }
    
    
    static NSString *CellIdentifier = @"cell";
    
    Transporter_TableViewCell *cell = [tbl_Transporter_Out dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil) {
        cell = [[Transporter_TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSString *card= [NSString stringWithFormat:@"%@",[[TransBidListDict valueForKey:@"first_name"] objectAtIndex:indexPath.row]] ;
    
    for (int i = 0; i < card.length - 1; i++)
    {
        if (i == 0)
        {
            
        }
        else
        {
            if (![[card substringWithRange:NSMakeRange(i, 1)] isEqual:@" "]) {
                
                NSRange range = NSMakeRange(i, 1);
                card = [card stringByReplacingCharactersInRange:range withString:@"*"];
                
            }
        }
        
    }
   
    cell.lbl_Bidder.text = card;
    
    cell.lbl_bid_amt_out.text= [NSString stringWithFormat:@"%@",[[TransBidListDict valueForKey:@"bid_amount"]objectAtIndex:indexPath.row]];
    
    NSString *userid=[NSString stringWithFormat:@"%@",[objappsharemanager.loginDic valueForKey:@"user_id"]];
    
    NSString *transporter_idStr=[NSString stringWithFormat:@"%@",[[TransBidListDict valueForKey:@"transporter_id"]objectAtIndex:indexPath.row]];
    
    
    NSString *strin=[NSString stringWithFormat:@"%@",[DicShip valueForKey:@"transporter_status"]] ;
    
    strin = [strin stringByTrimmingCharactersInSet:charsToTrim];
    
    int stint=[strin intValue];
    
    
    
    

    
    if ([userid isEqualToString:transporter_idStr])
    {
        cell.btneditBid.hidden=NO;
        
        
        if (stint>=2)
        {
             cell.btn_call.hidden=YES;
             cell.btn_cancel.hidden=NO;
             cell.btneditBid.hidden=YES;
        }else if ([bid_Flag isEqualToString:@"1"])
        {
            
             [_btnCreateBid setTitle:@"Shipment Accepted for other transpotor." forState:UIControlStateNormal];
            [_btnCreateBid.titleLabel setFont:[UIFont systemFontOfSize:14]];
            
            [_btnCreateBid setBackgroundColor:[UIColor lightGrayColor]];
            _btnCreateBid.userInteractionEnabled=NO;
            cell.btneditBid.hidden=YES;
        }
        
        NSString *card= [NSString stringWithFormat:@"%@",[[TransBidListDict valueForKey:@"first_name"] objectAtIndex:indexPath.row]] ;
        cell.lbl_Bidder.text = card;
        
       
    }
    else
    {
        
        
        cell.btneditBid.hidden=YES;
        cell.btn_call.hidden=YES;
        cell.btn_cancel.hidden=YES;
    }
    
    if (stint==3) {
        cell.btn_call.hidden=YES;
        cell.btn_cancel.hidden=YES;
    }
    else if (stint==4) {
        cell.btn_call.hidden=YES;
        cell.btn_cancel.hidden=YES;
        cell.lblCompleted.hidden=NO;
    }
    
    [cell.btneditBid addTarget:self
               action:@selector(btnCreateAction:)
     forControlEvents:UIControlEventTouchUpInside];
    cell.btneditBid.tag=indexPath.row;
    
    [cell.btn_call addTarget:self
                        action:@selector(btnCalling_Action:)
              forControlEvents:UIControlEventTouchUpInside];
    cell.btn_call.tag=indexPath.row;
    
    
    [cell.btn_cancel addTarget:self
                      action:@selector(btnCancel_Action:)
            forControlEvents:UIControlEventTouchUpInside];
    cell.btn_cancel.tag=indexPath.row;
    
    
    return cell;
}



-(IBAction)btnCancel_Action:(id)sender{
    
    
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@""
                                  message:@"You are sure cancel this bid?"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             
                             NSString *sid=[NSString stringWithFormat:@"%@",[[TransBidListDict valueForKey:@"shipment_id"] objectAtIndex:[sender tag]]];
                             
                             
                             NSString *transporter_idStr=[NSString stringWithFormat:@"%@",[[TransBidListDict valueForKey:@"transporter_id"] objectAtIndex:[sender tag]]];
                             
                             
                             [APPDATA showLoader];
                             
                             void (^successed)(id responseObject) = ^(id responseObject)
                             {
                                 [APPDATA hideLoader];
                                 
                                 [self My_Shipment_Bids];
                                 
                             };
                             
                             void (^failure)(NSError * error) = ^(NSError *error)
                             {
                                 [APPDATA hideLoader];
                             };
                             
                             
                             
                             NSDictionary *dict1 = @{@"carrier_id":transporter_idStr,@"shipmentid":sid};
                             
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

-(IBAction)btnCalling_Action:(id)sender{
    
    NSString *phNo=[NSString stringWithFormat:@"%@",[[TransBidListDict valueForKey:@"mobile_number"] objectAtIndex:[sender tag]]];
    
    
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else
    {
        UIAlertView *calert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Call facility is not available!!!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [calert show];
    }
    
}
-(void)My_Transporter_Detail
{
    
    [APPDATA showLoader];
    void (^successed)(id responseObject) = ^(id responseObject)
    {
        [APPDATA hideLoader];
        
        charsToTrim = [NSCharacterSet characterSetWithCharactersInString:@"< > null()  \n\""];
        
        
         shipmentItemDataArr = [[responseObject objectForKey:@"data"] objectForKey:@"shipment_item_data"];
        
        TransDic=[responseObject objectForKey:@"data"];
        TransimageDict = [TransDic objectForKey:@"shipment_images"];
        TransArray=[TransDic objectForKey:@"shipment_item_data"];
        TransDictimageurl=[TransDic valueForKey:@"shipment_image_url"];
        
        
        DicShip=[TransDic objectForKey:@"shipment_data"];
        
        
        //--- display ---------
        
      
        
        strFromLat=[NSString stringWithFormat:@"%@", [DicShip valueForKey:@"movefrom_lat"]];
        strFromLat = [strFromLat stringByTrimmingCharactersInSet:charsToTrim];
       
        
        strFromLong=[NSString stringWithFormat:@"%@",[DicShip valueForKey:@"movefrom_lng"]] ;
        
        strFromLong = [strFromLong stringByTrimmingCharactersInSet:charsToTrim];
        
        strFromLatLong = [NSString stringWithFormat:@"%@,%@",strFromLat,strFromLong];
        
        
        
        strToLat=[NSString stringWithFormat:@"%@",[DicShip valueForKey:@"moveto_lat"]] ;
        
         strToLat = [strToLat stringByTrimmingCharactersInSet:charsToTrim];
        
        
        strToLong=[NSString stringWithFormat:@"%@",[DicShip valueForKey:@"moveto_lng"]];
        
         strToLong = [strToLong stringByTrimmingCharactersInSet:charsToTrim];
        
        strToLatLong =[NSString stringWithFormat:@"%@,%@",strToLat,strToLong];
        
        
        
        [self googleMap];
        
         NSString *strTile = [[NSString stringWithFormat:@"%@",[DicShip valueForKey:@"title"]] uppercaseString];
        
        strTile = [strTile stringByTrimmingCharactersInSet:charsToTrim];
        
        self.lbl_Title.text = strTile;
        
        
        
         NSString *strDic = [NSString stringWithFormat:@"%@",[DicShip valueForKey:@"description"]];
         strDic = [strDic stringByTrimmingCharactersInSet:charsToTrim];
        
        if ([strDic length]<1)
        {
            strDic=@"Description not available";
        }
        
        
        self.txt_Desc_View.text = strDic;
        
        
        NSString *to_citystr=[NSString stringWithFormat:@"%@",[DicShip valueForKey:@"to_city"]];
        
        to_citystr = [to_citystr stringByTrimmingCharactersInSet:charsToTrim];
        self.lbl_movingto.text = to_citystr;
        
        
        
        NSString *movingfromStr=[NSString stringWithFormat:@"%@",[DicShip valueForKey:@"from_city"]];
        movingfromStr = [movingfromStr stringByTrimmingCharactersInSet:charsToTrim];
        
        self.lbl_movingfrom.text = movingfromStr;
        
        
        NSString *Amountstr=[NSString stringWithFormat:@"%@",[DicShip valueForKey:@"price"]];
        Amountstr = [Amountstr stringByTrimmingCharactersInSet:charsToTrim];
        
        self.lbl_Amount.text = Amountstr;
        
        
        
        NSString *DateStrpick=[NSString stringWithFormat:@"%@",[DicShip valueForKey:@"pickup_date_time"]];
        DateStrpick = [DateStrpick stringByTrimmingCharactersInSet:charsToTrim];

        
        self.lbl_Date.text=DateStrpick;
        
        self.img_Title_View.layer.cornerRadius=self.img_Title_View.frame.size.width/2.0;
        self.img_Title_View.layer.masksToBounds=YES;
        self.img_Title_View.clipsToBounds=YES;
        
     /*
        NSString *checkstr=[NSString stringWithFormat:@"%@",TransimageDict];
        
        if ( [checkstr isEqualToString:@"0"] )
        {
            
            [_img_Title_View setImage:[UIImage imageNamed:@"NO_IMAGE"]];
            
        }else{
            NSString* img=[NSString stringWithFormat:@"%@%@",TransDictimageurl,[[[shipmentItemDataArr objectAtIndex:0] valueForKey:@"image"]objectAtIndex:0]];
            
            
            
             [_img_Title_View setImageWithURL:[NSURL URLWithString:img] placeholderImage:[UIImage imageNamed:@"NO_IMAGE"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        }
      
      */
        
        
        if ([TransArray  isEqual:@""])
        {
            
            self.TransporterCollectionView.hidden=YES;
            
            _lbl_noiteam.hidden=NO;
        }
        else
        {    TransitemDict = [TransDic objectForKey:@"shipment_item_data"];
             _lbl_noiteam.hidden=YES;
             self.TransporterCollectionView.hidden=NO;
             self.TransporterCollectionView.delegate=self;
             self.TransporterCollectionView.dataSource=self;
        }
       
        [self.TransporterCollectionView reloadData];
        [self.TransporterCollectionView layoutIfNeeded];
      
        
    };
    
    void (^failure)(NSError * error) = ^(NSError *error)
    {
        [APPDATA hideLoader];
        
    };
    
    NSString *userid=[NSString stringWithFormat:@"%@",[objappsharemanager.loginDic valueForKey:@"user_id"]];
    
    NSDictionary *dict = @{@"shipment_id":objappsharemanager.Shipment_id,@"user_id":userid};
    
    
    
    
    [ApiCall sendToService:API_SHIPMENT_DETAIL andDictionary:dict success:successed failure:failure];
    
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
     if ([shipmentItemDataArr  isEqual:@""]) {
        
        return 0;
    }else{
        return shipmentItemDataArr.count;
    }
    
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    TransporterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TransporterCollectionViewCell" forIndexPath:indexPath];
    
    
    cell.lbl_tit.text= [NSString stringWithFormat:@"%@",[[shipmentItemDataArr valueForKey:@"item_name"]objectAtIndex:indexPath.row]];
    
    cell.txtViewFieldDataOut.text = [NSString stringWithFormat:@"%@",[[shipmentItemDataArr valueForKey:@"fieldData"]objectAtIndex:indexPath.row]];
    
    
    
    cell.imgIteam.layer.cornerRadius=cell.imgIteam.frame.size.width/2.0;
    cell.imgIteam.layer.masksToBounds=YES;
    cell.imgIteam.clipsToBounds=YES;
    NSString *img;
    
    
    
    
    
    NSString *nsIm=[NSString stringWithFormat:@"%@",[shipmentItemDataArr valueForKey:@"image"]];
    
    nsIm = [nsIm stringByTrimmingCharactersInSet:charsToTrim];
    
    if ([nsIm length]>2)
    {
        NSString *imageData=[NSString stringWithFormat:@"%@",[[[shipmentItemDataArr objectAtIndex:indexPath.row] valueForKey:@"image"]objectAtIndex:0]];
        
        
        img=[NSString stringWithFormat:@"%@%@",TransDictimageurl,imageData];
        
        
        
        [cell.imgIteam setImageWithURL:[NSURL URLWithString:img] placeholderImage:[UIImage imageNamed:@"NO_IMAGE"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        
        
        
        
        NSString* imgM=[NSString stringWithFormat:@"%@%@",TransDictimageurl,[[[shipmentItemDataArr objectAtIndex:0] valueForKey:@"image"]objectAtIndex:0]];
        NSString *imgMURL=[NSString stringWithFormat:@"%@",imgM];
        
        
        [_img_Title_View setImageWithURL:[NSURL URLWithString:imgMURL] placeholderImage:[UIImage imageNamed:@"NO_IMAGE"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        
    }
    else
    {
        [cell.imgIteam setImage:[UIImage imageNamed:@"NO_IMAGE"]];
    }
    

    
    
    
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat cellWidth =  [[UIScreen mainScreen] bounds].size.width;
    CGFloat cellHeight =  _TransporterCollectionView.bounds.size.height;
    return CGSizeMake(cellWidth, cellHeight);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
  
    
    
    NSString *nsIm=[NSString stringWithFormat:@"%@",[shipmentItemDataArr valueForKey:@"image"]];
    
    nsIm = [nsIm stringByTrimmingCharactersInSet:charsToTrim];
    
    if ([nsIm length]>0)
    {
    NSArray *arr=[[shipmentItemDataArr objectAtIndex:indexPath.row]valueForKey:@"image"];
    
    
    
    IteamDetailsViewcontroller *objotherAdditemViewController= (IteamDetailsViewcontroller*)[mainStoryboard instantiateViewControllerWithIdentifier:@"IteamDetailsViewcontroller"];
    objotherAdditemViewController.itemImageArr=arr;
    objotherAdditemViewController.strUrl=TransDictimageurl;
    
    objotherAdditemViewController.strItemID=[NSString stringWithFormat:@"%@",[[shipmentItemDataArr objectAtIndex:indexPath.row] valueForKey:@"itemId"]];
    


        objotherAdditemViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    
    
    
    [self.view addSubview:objotherAdditemViewController.view];
    [self addChildViewController:objotherAdditemViewController];
    [objotherAdditemViewController didMoveToParentViewController:self];

    
    
        [UIView animateWithDuration:0.3/1.5 animations:^{
            objotherAdditemViewController.view.transform=CGAffineTransformScale(CGAffineTransformIdentity,1.1,1.1);
    
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/2 animations:^{
                objotherAdditemViewController.view.transform=CGAffineTransformScale(CGAffineTransformIdentity,0.9,0.9);
    
            }completion:^(BOOL finished) {
                [UIView animateWithDuration:0.3/2 animations:^{
                    objotherAdditemViewController.view.transform=CGAffineTransformIdentity;
    
    
                }];
            }];
        }];
        

    
  
        
        objotherAdditemViewController.itemTitle.text= [NSString stringWithFormat:@"%@",[[shipmentItemDataArr valueForKey:@"item_name"]objectAtIndex:indexPath.row]];
    
       objotherAdditemViewController.itemData.text= [NSString stringWithFormat:@"%@",[[shipmentItemDataArr valueForKey:@"fieldData"]objectAtIndex:indexPath.row]];
    
    
    }else{
        UIAlertView *alt=[[UIAlertView alloc]initWithTitle:@"" message:@"Image not found" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        
        [alt show];
        
        
    }

    
}


- (IBAction)btnCreateAction:(id)sender
{
    UIButton *button = (UIButton *)sender;
    
    
    Create_Bid_ViewController *controller =(Create_Bid_ViewController *) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"Create_Bid_ViewController"];
    
    if ([button tag] ==9999)
    {
        NSString *btnTitle=[NSString stringWithFormat:@"%@", _btnCreateBid.titleLabel.text];
        if ([btnTitle isEqualToString:@"UPDATE YOUR BID"])
        {
             controller.strEdit=@"1";
            
        }else{
        
        controller.strEdit=@"0";
        }
        
        
    }else{
        
       controller.strAmount= [NSString stringWithFormat:@"%@",[[TransBidListDict valueForKey:@"bid_amount"]objectAtIndex:[button tag]]];
        
        controller.strDecs= [NSString stringWithFormat:@"%@",[[TransBidListDict valueForKey:@"description"]objectAtIndex:[button tag]]];
        
        
         controller.strEdit=@"1";
    }
    
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

- (IBAction)btnBackAct:(id)sender
{
   // strid = NULL;
    [[self navigationController]popViewControllerAnimated:YES];
}

-(void)My_Shipment_Bids
{
    [APPDATA showLoader];
    
    
    void (^successed)(id responseObject) = ^(id responseObject)
    {
        
        [APPDATA hideLoader];
        
          charsToTrim = [NSCharacterSet characterSetWithCharactersInString:@"< > null()  \n\""];
        
        TransporterBidDict=[responseObject objectForKey:@"data"];
        
        
        TransBidListDict=[TransporterBidDict objectForKey:@"bid_list"];
        if ([TransBidListDict count]<1)
        {
            _View_No_Biddies_Found.hidden=NO;
        }
        
        

        bidAv=@"";
        
        NSString *userid=[NSString stringWithFormat:@"%@",[objappsharemanager.loginDic valueForKey:@"user_id"]];
        
        NSString *strin;
        
        for (int i=0; i<TransBidListDict.count; i++)
        {
            NSString *transporter_idStr=[NSString stringWithFormat:@"%@",[[TransBidListDict valueForKey:@"transporter_id"]objectAtIndex:i]];
            
            if ([userid isEqualToString:transporter_idStr])
            {
               strin=[NSString stringWithFormat:@"%@",[DicShip valueForKey:@"transporter_status"]] ;
                
                strin = [strin stringByTrimmingCharactersInSet:charsToTrim];
                 _btnCreateBid.hidden=NO;
                
                [_btnCreateBid setTitle:@"Update your bid ?" forState:UIControlStateNormal];
                
                int stint=[strin intValue];
                
                if (stint>=2)
                {
                    self.tbl_Transporter_Out.frame=CGRectMake(self.tbl_Transporter_Out.frame.origin.x, self.tbl_Transporter_Out.frame.origin.y-40, self.tbl_Transporter_Out.frame.size.width, self.tbl_Transporter_Out.frame.size.height);
                    
                    self.lblbidderlist.frame=CGRectMake(self.lblbidderlist.frame.origin.x, self.lblbidderlist.frame.origin.y-50, self.lblbidderlist.frame.size.width, self.lblbidderlist.frame.size.height);
                    
                    _btnCreateBid.hidden=YES;
                     bidAv=[NSString stringWithFormat:@"%d",i];
                }
                
                
            }
            
            
            
            NSString *bid_statusStr=[NSString stringWithFormat:@"%@",[[TransBidListDict valueForKey:@"bid_status"]objectAtIndex:i]];
            
            bid_statusStr = [bid_statusStr stringByTrimmingCharactersInSet:charsToTrim];
            
            int bidint=[bid_statusStr intValue];
            
            if (bidint>=2)
            {
                bid_Flag=@"1";
            }
            
            
        }
       
        
        self.tbl_Transporter_Out.delegate=self;
        self.tbl_Transporter_Out.dataSource=self;
        [tbl_Transporter_Out reloadData];
        
    };
    
    void (^failure)(NSError * error) = ^(NSError *error)
    {
        [APPDATA hideLoader];
        
    };
    
    
    NSString *useridStr=[NSString stringWithFormat:@"%@",[objappsharemanager.loginDic valueForKey:@"user_id"]];
    
    
    NSDictionary *dict = @{@"user_id":useridStr,@"shipmentid":objappsharemanager.Shipment_id,@"page":@"0",@"offset":@"0"};
    
    [ApiCall sendToService:API_SHIPMENT_BIDS andDictionary:dict success:successed failure:failure];
}



- (void)googleMap

{
    waypoints_ = [[NSMutableArray alloc]init];
    waypointStrings_ = [[NSMutableArray alloc]init];
    
    double Forlat,Forlong,Tolat,Tolong;
    Forlat =[strFromLat doubleValue];
    Forlong=[strFromLong doubleValue];
    Tolat=[strToLat doubleValue];
    Tolong=[strToLong doubleValue];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:Forlat
                                                            longitude:Forlong
                                                                 zoom:10];
    mapView_ = [GMSMapView mapWithFrame:self.Googlemap_View.frame camera:camera];
     mapView_.mapType = kGMSTypeHybrid;
  
    [self.scrllView addSubview:mapView_];
    
    //[[UIApplication sharedApplication].keyWindow addSubview:_btnSatelliteAction];
    
    [self.scrllView addSubview:_btnSatelliteAction];
    [self.scrllView addSubview:_btnMap];
    [_btnSatelliteAction setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    
    mapView_.delegate = self;
    
    
    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(
                                                                 Forlat,
                                                                 Forlong);
    
    
    GMSMarker *marker = [GMSMarker markerWithPosition:position];
    marker.map = mapView_;
    CLLocationCoordinate2D position1 = CLLocationCoordinate2DMake(
                                                                  Tolat,
                                                                  Tolong);
    GMSMarker *marker1 = [GMSMarker markerWithPosition:position1];
    marker1.map = mapView_;
    
    marker.title = @"From";
    marker1.title = @"To";
   // marker1.icon = [GMSMarker markerImageWithColor:[self colorWithHexString:@"#80ff80" alpha:1]];
    marker.icon=[UIImage imageNamed:@"img_locationFrom"];
    marker1.icon=[UIImage imageNamed:@"img_locationTo"];
    
    
    GMSCoordinateBounds *bounds =
    [[GMSCoordinateBounds alloc] initWithCoordinate:position coordinate:position1];
    camera = [mapView_ cameraForBounds:bounds insets:UIEdgeInsetsZero];
    mapView_.camera = camera;
    GMSCameraUpdate *zoomCamera = [GMSCameraUpdate zoomOut];
    [mapView_ animateWithCameraUpdate:zoomCamera];
    
    [mapView_ animateToViewingAngle:45];
    
    
    
    NSString *positionString = [[NSString alloc] initWithFormat:@"%f,%f",
                                Forlat,Forlong];
    NSString *positionString1 = [[NSString alloc] initWithFormat:@"%f,%f",
                                 Tolat,Tolong];
    
    [waypoints_ addObject:positionString];
    [waypoints_ addObject:positionString1];
    
    [waypointStrings_ addObject:positionString];
    [waypointStrings_ addObject:positionString1];
    
    if([waypointStrings_ count]>1){
        NSString *sensor = @"false";
        NSArray *parameters = [NSArray arrayWithObjects:sensor, waypointStrings_,
                               nil];
        NSArray *keys = [NSArray arrayWithObjects:@"sensor", @"waypoints", nil];
        NSDictionary *query = [NSDictionary dictionaryWithObjects:parameters
                                                          forKeys:keys];
        MDDirectionService *mds=[[MDDirectionService alloc] init];
        SEL selector = @selector(addDirections:);
        [mds setDirectionsQuery:query
                   withSelector:selector
                   withDelegate:self];
    }
}
- (UIColor *)colorWithHexString:(NSString *)str_HEX  alpha:(CGFloat)alpha_range{
    int red = 0;
    int green = 0;
    int blue = 0;
    sscanf([str_HEX UTF8String], "#%02X%02X%02X", &red, &green, &blue);
    return  [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha_range];
}
- (void)addDirections:(NSDictionary *)json {
    
    if ([[json objectForKey:@"routes"] count]>0) {
        
    
    
    NSDictionary *routes = [json objectForKey:@"routes"][0];
    
    NSDictionary *route = [routes objectForKey:@"overview_polyline"];
    NSString *overview_route = [route objectForKey:@"points"];
    GMSPath *path = [GMSPath pathFromEncodedPath:overview_route];
    GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
    polyline.strokeWidth = 3;
    polyline.map = mapView_;
    }
    else
    {
        
    }
}



-(void)LoadMapRoute
{
    MKCoordinateSpan span = MKCoordinateSpanMake(0.8, 0.8);
    MKCoordinateRegion region;
    region.span = span;
    double lat=[strFromLat doubleValue];
    double lng=[strFromLong doubleValue];
    region.center= CLLocationCoordinate2DMake(lat,lng);
    
    
    
    CLLocation *locA = [[CLLocation alloc] initWithLatitude:[strFromLat doubleValue] longitude:[strFromLong doubleValue]];
    
    
    
    CLLocation *locB = [[CLLocation alloc] initWithLatitude:[strToLat doubleValue] longitude:[strToLong doubleValue]];    CLLocationDistance distance = [locA distanceFromLocation:locB];
    
    NSLog(@"Distance :%.0f Meters",distance);
    
    
    NSString *baseUrl = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/directions/json?origin=%@&destination=%@&sensor=true", strFromLatLong,strToLatLong];
    
    
    NSURL *url = [NSURL URLWithString:[baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    alldata = [[NSData alloc] initWithContentsOfURL:url];
    
    NSError *err;
    data1 =[NSJSONSerialization JSONObjectWithData:alldata options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:&err];
    
    if (err)
    {
        NSLog(@" %@",[err localizedDescription]);
    }
    
    NSArray *routes = [data1 objectForKey:@"routes"];
    NSDictionary *firstRoute = [routes objectAtIndex:0];
    NSDictionary *leg =  [[firstRoute objectForKey:@"legs"] objectAtIndex:0];
    NSArray *steps = [leg objectForKey:@"steps"];
    
    int stepIndex = 0;
    CLLocationCoordinate2D stepCoordinates[[steps count]+1 ];
    
    for (NSDictionary *step in steps)
    {
        
        NSDictionary *start_location = [step objectForKey:@"start_location"];
        double latitude = [[start_location objectForKey:@"lat"] doubleValue];
        double longitude = [[start_location objectForKey:@"lng"] doubleValue];
        stepCoordinates[stepIndex] = CLLocationCoordinate2DMake(latitude, longitude);
        
        if (stepIndex==0)
        {
            MapRoute *point=[[MapRoute alloc] initWithLocation:stepCoordinates[stepIndex]];
            point.title =strFromLatLong;
            point.subtitle=[NSString stringWithFormat:@"Distance :%.0f Meters",distance];
            [self.MapView addAnnotation:point];
        }
        if (stepIndex==[steps count]-1)
        {
            stepIndex++;
            NSDictionary *end_location = [step objectForKey:@"end_location"];
            double latitude = [[end_location objectForKey:@"lat"] doubleValue];
            double longitude = [[end_location objectForKey:@"lng"] doubleValue];
            stepCoordinates[stepIndex] = CLLocationCoordinate2DMake(latitude, longitude);
            
            MapRoute *point=[[MapRoute alloc] initWithLocation:stepCoordinates[stepIndex]];
            point.title = strToLatLong;
            point.subtitle=[NSString stringWithFormat:@"Distance :%.0f Meters",distance];
            
            [self.MapView addAnnotation:point];
        }
        stepIndex++;
    }
    
    MKPolyline *polyLine = [MKPolyline polylineWithCoordinates:stepCoordinates count: stepIndex];
    [self.MapView  addOverlay:polyLine];
    [self.MapView setRegion:region animated:YES];
    
    
    
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay
{
    MKPolylineView *polylineView = [[MKPolylineView alloc] initWithPolyline:overlay];
    polylineView.strokeColor = [UIColor colorWithRed:204/255. green:45/255. blue:70/255. alpha:1.0];
    polylineView.lineWidth = 5;
    
    return polylineView;
}
- (IBAction)btnSatelliteAction:(id)sender {
    
    mapView_.mapType = kGMSTypeHybrid;
    [_btnMap setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btnSatelliteAction setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
}

- (IBAction)btnMapAction:(id)sender {
    mapView_.mapType = kGMSTypeNormal;
    [_btnMap setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
     [_btnSatelliteAction setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
}
@end
