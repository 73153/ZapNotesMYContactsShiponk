

#import "Shipment_Description_ViewController.h"
#import "Shipment_Bidder_TableViewCell.h"
#import "Bidding_Detail_vc.h"
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
//#import "Feedback_And_Review_ViewController.h"
#import "ViewRatingAndReviewVC.h"
@interface Shipment_Description_ViewController ()<GMSMapViewDelegate> {
    GMSMapView *mapView_;
    NSMutableArray *waypoints_;
    NSMutableArray *waypointStrings_;
    
    appShareManager *objappsharemanager;
    
    
    Shipment_Bidder_TableViewCell *objtblcell ;
    NSMutableArray *arrayBidder;
    NSDictionary *shipDict,*shipDictimageurl;//*shipitemDict;
    NSMutableArray *shipDictArray1,*shipimageDict;

    NSArray *shipmentItemDataArr;
    NSData *alldata;
    NSMutableDictionary *data1;
    
    NSMutableArray *RouteLocation;
    NSMutableArray *RouteName;
    
    NSString *strFromLat,*strFromLong,*strToLat,*strToLong,*strFromLatLong,*strToLatLong,*datestr,*timestr;
    
    NSString *dateString,*stringDate1,*stringDate,*stringImage;
    NSDateFormatter *dateFormatter,*dateFormatter1,*dateFormatter2;
    NSDate *dateFromString;
    
   
    NSMutableArray *bidAmountArray,*bidderNameArray;
    NSDictionary *bidShipDict;
    NSArray * ShipmentBidListArr;
    NSString *bacceptStr;

    
    BOOL selectCompleted;
    
}
@end

@implementation Shipment_Description_ViewController

@synthesize ShipmentidStr,statusTob,tbl_shipment_description_out,shipmentDic,shipMoveFromLat,shipMoveFromLong,shipMovetoLat,shipMovetoLong,shipmentImageArray,lbl_amount,lbl_movingfrom,lbl_movingto,lblDate,lblTime,lblTitle,txt_Desc_View,img_Title_View,MapView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self.scrllView setContentSize:(CGSizeMake(self.scrllView.frame.size.width, self.scrllView.frame.size.height*1.6))];
    
    _view_NoBiddiesFound.hidden = YES;

     objappsharemanager=[appShareManager sharedManager];
    [self My_Shipment_Bids];
     [tbl_shipment_description_out reloadData];
  
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
    
    selectCompleted=YES;
    [APPDATA showLoader];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
         [self My_Shipment_Detail];
    });
    
    
}
-(void)My_Shipment_Detail
{
    
    [APPDATA showLoader];
    void (^successed)(id responseObject) = ^(id responseObject)
    {
        [APPDATA hideLoader];
        
        
        
        shipmentDic=[responseObject objectForKey:@"data"];
        
        shipimageDict = [shipmentDic objectForKey:@"shipment_images"];
        
        shipmentItemDataArr = [shipmentDic objectForKey:@"shipment_item_data"];
        
        shipDict=[shipmentDic objectForKey:@"shipment_data"];
        
        
        shipDictimageurl=[shipmentDic objectForKey:@"shipment_image_url"];
        
        
        
        shipMoveFromLat = [shipDict valueForKey:@"movefrom_lat"];
        
        strFromLat=[NSString stringWithFormat:@"%@",[shipMoveFromLat objectAtIndex:0]];
        
        shipMoveFromLong = [shipDict valueForKey:@"movefrom_lng"];
        strFromLong=[NSString stringWithFormat:@"%@",[shipMoveFromLong objectAtIndex:0]];
        strFromLatLong = [NSString stringWithFormat:@"%@,%@",strFromLat,strFromLong];
        
        shipMovetoLat = [shipDict valueForKey:@"moveto_lat"];
        strToLat=[NSString stringWithFormat:@"%@",[shipMovetoLat objectAtIndex:0]];
        
        shipMovetoLong = [shipDict valueForKey:@"moveto_lng"];
        strToLong=[NSString stringWithFormat:@"%@",[shipMovetoLong objectAtIndex:0]];
        strToLatLong=[NSString stringWithFormat:@"%@,%@",strToLat,strToLong];
        
        
       
        

        shipmentImageArray=[shipDict valueForKey:@"photo"];
        
        
        stringImage=[NSString stringWithFormat:@"%@",shipmentImageArray];
        
              
        
        lbl_movingfrom.text = [NSString stringWithFormat:@"%@",[[shipDict valueForKey:@"from_city"] objectAtIndex:0]];
        
        
        lbl_movingto.text = [NSString stringWithFormat:@"%@",[[shipDict valueForKey:@"to_city"] objectAtIndex:0]];
        
       
         
        lbl_amount.text = [NSString stringWithFormat:@"%@",[[shipDict valueForKey:@"shipment_budget"] objectAtIndex:0]];
        
        
        lblTitle.text = [[NSString stringWithFormat:@"%@",[[shipDict valueForKey:@"title"] objectAtIndex:0]] uppercaseString];
        
       NSCharacterSet *charsToTrim = [NSCharacterSet characterSetWithCharactersInString:@"< > null()  \n\""];
        
        NSString *strDic = [NSString stringWithFormat:@"%@",[shipDict valueForKey:@"description"]];
        strDic = [strDic stringByTrimmingCharactersInSet:charsToTrim];
        
        
        if ([strDic length]<1)
        {
            strDic=@"Description not available";
        }
        
        
        txt_Desc_View.text=strDic;
        
     
       
        
       
         lblDate.text=[NSString stringWithFormat:@"%@",[[shipDict valueForKey:@"pickup_date_time"] objectAtIndex:0]];
        
      

            img_Title_View.layer.cornerRadius=img_Title_View.frame.size.width/2.0;
            img_Title_View.layer.masksToBounds=YES;
            img_Title_View.clipsToBounds=YES;
        NSString *img;
        //NSString *imgData;

     
        img=[NSString stringWithFormat:@"%@",[[shipmentItemDataArr objectAtIndex:0] valueForKey:@"image"]];
        
        
         img = [img stringByTrimmingCharactersInSet:charsToTrim];
        
        if ([img length]>0)
        {
             img=[NSString stringWithFormat:@"%@%@",shipDictimageurl,[[[shipmentItemDataArr objectAtIndex:0] valueForKey:@"image"]objectAtIndex:0]];
            
            [img_Title_View setImageWithURL:[NSURL URLWithString:img] placeholderImage:[UIImage imageNamed:@"NO_IMAGE"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        }else{
            [img_Title_View setImage:[UIImage imageNamed:@"NO_IMAGE"]];
        }
        
        

        self.shipmentCollectionView.delegate=self;
        self.shipmentCollectionView.dataSource=self;
        
       
       [tbl_shipment_description_out reloadData];
        
       // [self LoadMapRoute];
        
        [self googleMap];
    };
    
    void (^failure)(NSError * error) = ^(NSError *error)
    {
        [APPDATA hideLoader];
        
    };
    
    
    NSString *useridStr=[NSString stringWithFormat:@"%@",[objappsharemanager.loginDic valueForKey:@"user_id"]];
    

    NSDictionary *dict = @{@"user_id":useridStr,@"shipment_id":ShipmentidStr};
    
    [ApiCall sendToService:API_SHIPMENT_DETAIL andDictionary:dict success:successed failure:failure];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if ([bacceptStr length]<1)
    {
        return _shipmentBidListDict.count;
        
    }else
    
         return 1;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([bacceptStr length]>0)
    {
        int inr=[bacceptStr intValue];
        
        indexPath = [NSIndexPath indexPathForRow:inr inSection: 0];
    }
    
    static NSString *CellIdentifier = @"Shipment_Bidder_TableViewCell";
    
    Shipment_Bidder_TableViewCell *cell = [tbl_shipment_description_out dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil) {
        cell = [[Shipment_Bidder_TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
   
    cell.btn_Accept_out.hidden=YES;
    cell.btn_cancel.hidden=YES;
    cell.btn_call.hidden=YES;
    
    if ([statusTob isEqualToString:@"YES"])
    {
        NSString *b_st=[NSString stringWithFormat:@"%@",[[_shipmentBidListDict valueForKey:@"bid_status"]objectAtIndex:indexPath.row]];
        
        int bint=[b_st intValue];
        
        
        if ([b_st isEqualToString:@"2"])
        {
            
            [cell.btn_Accept_out setTitle:@"ACCEPT" forState:UIControlStateNormal];
            [cell.btn_Accept_out setBackgroundColor:[UIColor yellowColor]];
            cell.btn_Accept_out.hidden=YES;
            cell.btn_cancel.hidden=NO;
            cell.btn_call.hidden=NO;
            
            
        }else if ([b_st isEqualToString:@"3"])
        {
            
            [cell.btn_Accept_out setTitle:@"ACCEPT" forState:UIControlStateNormal];
            [cell.btn_Accept_out setBackgroundColor:[UIColor yellowColor]];
            
            cell.btn_Accept_out.hidden=YES;
            cell.btn_call.hidden=NO;

            
            cell.btn_cancel.hidden=YES;
        }else if (bint >=4)
        {
            
            
            [cell.btn_Accept_out setTitle:@"Completed" forState:UIControlStateNormal];
            [cell.btn_Accept_out setBackgroundColor:[UIColor clearColor]];
            cell.btn_Accept_out.userInteractionEnabled=NO;
            
            cell.btn_call.hidden=NO;

                       
            
        }else{
            cell.btn_Accept_out.hidden=YES;
        }
        
        
        
    }else{
        cell.btn_Accept_out.hidden=NO;
    }
    
    
    cell.btn_cancel.tag=indexPath.row;
    
    [cell.btn_cancel addTarget:self
                          action:@selector(CancelBtnMethod:)
                forControlEvents:UIControlEventTouchUpInside];
    
    
    cell.btn_call.tag=indexPath.row;
    
    [cell.btn_call addTarget:self
                        action:@selector(callBtnMethod:)
              forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
     cell.lbl_bid_amt_out.text = [NSString stringWithFormat:@"%@",[[_shipmentBidListDict valueForKey:@"bid_amount"]objectAtIndex:indexPath.row]];
    
     cell.lbl_amout.text= [NSString stringWithFormat:@"%@",[[_shipmentBidListDict valueForKey:@"bid_amount"]objectAtIndex:indexPath.row]];
    
    
     cell.lbl_Bidder.text=[NSString stringWithFormat:@"%@",[[_shipmentBidListDict valueForKey:@"first_name"]objectAtIndex:indexPath.row]];
    
        
   
     cell.btn_Accept_out.tag=indexPath.row;
    
    [cell.btn_Accept_out addTarget:self
               action:@selector(btn_Accept_Action:)
     forControlEvents:UIControlEventTouchUpInside];
    
    
  
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    NSString *strtransporterId =  [[ShipmentBidListArr objectAtIndex:indexPath.row] valueForKey:@"transporter_id"];
    
    objappsharemanager.Shipment_id=[NSString stringWithFormat:@"%@",ShipmentidStr];
    
    objappsharemanager.carrieridStr=[NSString stringWithFormat:@"%@",strtransporterId];
    
    ViewRatingAndReviewVC *objViewRatingAndReviewVC = (ViewRatingAndReviewVC *)[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"ViewRatingAndReviewVC"];
    objViewRatingAndReviewVC.StrTransporterId = strtransporterId;
    
    [[self navigationController]pushViewController:objViewRatingAndReviewVC animated:YES];


}

-(IBAction)CancelBtnMethod:(id)sender{
    
    
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@""
                                  message:@"You are sure cancel this bid?"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             
                             NSString *sid=[NSString stringWithFormat:@"%@",[[_shipmentBidListDict valueForKey:@"shipment_id"] objectAtIndex:[sender tag]]];
                        
                             
                             NSString *transporter_idStr=[NSString stringWithFormat:@"%@",[[_shipmentBidListDict valueForKey:@"transporter_id"] objectAtIndex:[sender tag]]];
                             
                             
                             [APPDATA showLoader];
                             
                             void (^successed)(id responseObject) = ^(id responseObject)
                             {
                                 [APPDATA hideLoader];
                                 statusTob=@"NO";
                                 [self My_Shipment_Bids];
                                 
                             };
                             
                             void (^failure)(NSError * error) = ^(NSError *error)
                             {
                                 [APPDATA hideLoader];
                             };
                             
                             NSString *userid=[NSString stringWithFormat:@"%@",[objappsharemanager.loginDic valueForKey:@"user_id"]];
                             
                             NSDictionary *dict1 = @{@"carrier_id":transporter_idStr,@"shipmentid":sid,@"customer_id":userid};
                             
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


-(IBAction)callBtnMethod:(id)sender{
    
   NSString *phNo=[NSString stringWithFormat:@"%@",[[_shipmentBidListDict valueForKey:@"mobile_number"] objectAtIndex:[sender tag]]];
    
   
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else
    {
        UIAlertView *calert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Call facility is not available!!!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [calert show];
    }
    
}

- (IBAction)btn_back_act:(id)sender
{
    [[self navigationController]popViewControllerAnimated:YES];

}

- (IBAction)btn_Accept_Action:(id)sender
{
    
   UIButton *button = (UIButton *)sender;
    
    
    
    NSString *strid=[NSString stringWithFormat:@"%@",[[_shipmentBidListDict valueForKey:@"id"]objectAtIndex:button.tag]];
    objappsharemanager.carrieridStr=[NSString stringWithFormat:@"%@",strid];
    
    
    NSString *bidid=[NSString stringWithFormat:@"%@",[[_shipmentBidListDict valueForKey:@"bidid"]objectAtIndex:button.tag]];
    
    
    //
    
     NSString *strS=[NSString stringWithFormat:@"%@",[[_shipmentBidListDict valueForKey:@"bid_status"]objectAtIndex:button.tag]];
    
    
    
    
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@""
                                  message:@"Are you sure,you want to accept this bid ?"
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


-(void)rateViewMthod
{
    if (selectCompleted==YES)
    {
        selectCompleted=NO;
        
        
        Feedback_And_Review_ViewController *controller2 =(Feedback_And_Review_ViewController *) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"Feedback_And_Review_ViewController"];
        
        
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
}


-(void)accptBidMethod:(NSString *)str second:(NSString *)mname
{
    
    [APPDATA showLoader];
    
    void (^successed)(id responseObject) = ^(id responseObject)
    {
        
        if ([mname intValue]>=4)
        {
            [self rateViewMthod];
        }
        
        
       [APPDATA hideLoader];
        [self My_Shipment_Bids];
        
        
    };
    
    void (^failure)(NSError * error) = ^(NSError *error)
    {
        [APPDATA hideLoader];
    };
    
    if ([mname intValue]<4) {
        
    
   // int intb=[mname intValue]+1;
    
     NSDictionary *dict = @{@"shipmentid":ShipmentidStr,@"carrierid":objappsharemanager.carrieridStr,@"bidid":str,@"status":@"2"};
    
    
     [ApiCall sendToService:API_ACCEPT_BIDS andDictionary:dict success:successed failure:failure];
    
    }
}

-(void)My_Shipment_Bids
{
    [APPDATA showLoader];
    
    
    void (^successed)(id responseObject) = ^(id responseObject)
    {
        
        [APPDATA hideLoader];
        
        statusTob=@"NO";
        
        _shipmentBidDict=[responseObject objectForKey:@"data"];
        
        _shipmentBidListDict=[_shipmentBidDict objectForKey:@"bid_list"];
        ShipmentBidListArr = [self.shipmentBidDict valueForKey:@"bid_list"];

       
        if (_shipmentBidListDict.count<1)
        {
            tbl_shipment_description_out.hidden=YES;
            _view_NoBiddiesFound.hidden = NO;
        }
       
        bacceptStr=@"";
        
        for (int i=0;  i<_shipmentBidListDict.count; i++)
        {
            NSString *b_st=[[_shipmentBidListDict valueForKey:@"bid_status"]objectAtIndex:i];
            
            if ([b_st isEqualToString:@"2"]|| [b_st isEqualToString:@"3"]||[b_st isEqualToString:@"4"])
            {
                statusTob=@"YES";
                
               bacceptStr=[NSString stringWithFormat:@"%d",i];
            }
            
           
            
        }
        
                
        
        self.tbl_shipment_description_out.delegate=self;
        self.tbl_shipment_description_out.dataSource=self;
       [tbl_shipment_description_out reloadData];
        
    };
    
    void (^failure)(NSError * error) = ^(NSError *error)
    {
        [APPDATA hideLoader];
       
    };
    
    
    NSString *useridStr=[NSString stringWithFormat:@"%@",[objappsharemanager.loginDic valueForKey:@"user_id"]];
    
    
    NSDictionary *dict = @{@"user_id":useridStr,@"shipmentid":ShipmentidStr,@"page":@"0",@"offset":@"0"};
    
    [ApiCall sendToService:API_SHIPMENT_BIDS andDictionary:dict success:successed failure:failure];
}

-(void)destroyImageView {
    @autoreleasepool {
        for (UIView *subview in self.view.subviews) {
            if ([subview isKindOfClass:[UIImageView class]]) {
                [subview removeFromSuperview];
            }
        }
    }
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
                                                                 zoom:10 ];
    
    
    mapView_ = [GMSMapView mapWithFrame:self.GooglemapView.frame camera:camera];
    mapView_.mapType = kGMSTypeHybrid;
    [self.scrllView addSubview:mapView_];
     mapView_.userInteractionEnabled=NO;
     mapView_.delegate = self;
    

    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(
                                                                 Forlat,
                                                                 Forlong);
    GMSMarker *marker = [GMSMarker markerWithPosition:position];
    
    marker.map = mapView_;
    marker.title = @"From";
    
    
    CLLocationCoordinate2D position1 = CLLocationCoordinate2DMake(
                                                                  Tolat,
                                                                  Tolong);
    
    GMSCoordinateBounds *bounds =
    [[GMSCoordinateBounds alloc] initWithCoordinate:position coordinate:position1];
    camera = [mapView_ cameraForBounds:bounds insets:UIEdgeInsetsZero];
    mapView_.camera = camera;
    GMSCameraUpdate *zoomCamera = [GMSCameraUpdate zoomOut];
    [mapView_ animateWithCameraUpdate:zoomCamera];
    
     [mapView_ animateToViewingAngle:45];
    
    GMSMarker *marker1 = [GMSMarker markerWithPosition:position1];
    marker1.title = @"To";
 /*   UIImage *house = [UIImage imageNamed:@"search.png"];
    house = [house imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImageView *londonView = [[UIImageView alloc] initWithImage:house];
    londonView.tintColor = [UIColor redColor];
    marker1.iconView = londonView;
    marker1.tracksViewChanges = YES;*/
    //marker1.icon = [GMSMarker markerImageWithColor:[self colorWithHexString:@"#80ff80" alpha:1]];
    marker.icon=[UIImage imageNamed:@"img_locationFrom"];
    marker1.icon=[UIImage imageNamed:@"img_locationTo"];
    marker1.map = mapView_;
    
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
    [MapView addOverlay:polyLine];
    [MapView setRegion:region animated:YES];
    
    
    
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay
{
    MKPolylineView *polylineView = [[MKPolylineView alloc] initWithPolyline:overlay];
    polylineView.strokeColor = [UIColor colorWithRed:204/255. green:45/255. blue:70/255. alpha:1.0];
    polylineView.lineWidth = 5;
    
    return polylineView;
}
#pragma marks  collection view delegate--------
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([shipmentItemDataArr isEqual:@""])
    {
        _noiteam.hidden=NO;
        return 0;
        
        
        
    }else{
        
        _noiteam.hidden=YES;
        
        return shipmentItemDataArr.count;
    }
    
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    newCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    

     cell.lbl_titlename.text= [[shipmentItemDataArr objectAtIndex:indexPath.row]valueForKey:@"item_name"];
    cell.txtViewFieldDataOut.text = [NSString stringWithFormat:@"%@",[[shipmentItemDataArr objectAtIndex:indexPath.row]valueForKey:@"fieldData"]];
    
   
  
    
    cell.imgview_inscllView.layer.cornerRadius=cell.imgview_inscllView.frame.size.width/2.0;
     cell.imgview_inscllView.layer.masksToBounds=YES;
     cell.imgview_inscllView.clipsToBounds=YES;
    NSString *img;
   
    
   
    
    NSString *imageData=[NSString stringWithFormat:@"%@",[[shipmentItemDataArr objectAtIndex:indexPath.row] valueForKey:@"image"]];
    
    
    if ([imageData length]>2) {
        
        img=[NSString stringWithFormat:@"%@%@",shipDictimageurl,[[[shipmentItemDataArr objectAtIndex:0] valueForKey:@"image"]objectAtIndex:indexPath.row]];
        
        [cell.imgview_inscllView setImageWithURL:[NSURL URLWithString:img] placeholderImage:[UIImage imageNamed:@"myImage.jpg"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    else
    {
        [cell.imgview_inscllView setImage:[UIImage imageNamed:@"myImage.jpg"]];
    }
    
 return cell;
}



-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat cellWidth =  [[UIScreen mainScreen] bounds].size.width;
    CGFloat cellHeight =  _shipmentCollectionView.bounds.size.height;
    return CGSizeMake(cellWidth, cellHeight);
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
       NSArray *arr=[[shipmentItemDataArr objectAtIndex:indexPath.row]valueForKey:@"image"];
    
    IteamDetailsViewcontroller *objotherAdditemViewController= (IteamDetailsViewcontroller*)[mainStoryboard instantiateViewControllerWithIdentifier:@"IteamDetailsViewcontroller"];
    objotherAdditemViewController.itemImageArr=arr;
    objotherAdditemViewController.strUrl=[NSString stringWithFormat:@"%@",shipDictimageurl];
    

    
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
    
    NSString *img;
    
    
    NSString *imageData=[NSString stringWithFormat:@"%@",[[shipmentItemDataArr objectAtIndex:indexPath.row]valueForKey:@"image"]];
    
    if ([imageData length]>2) {
        img=[NSString stringWithFormat:@"%@%@",shipDictimageurl,imageData];
        
        [objotherAdditemViewController.itemImg setImageWithURL:[NSURL URLWithString:img] placeholderImage:[UIImage imageNamed:@"myImage.jpg"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    else
    {
        [objotherAdditemViewController.itemImg setImage:[UIImage imageNamed:@"myImage.jpg"]];
    }
    
    
    
    
    
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

@end
