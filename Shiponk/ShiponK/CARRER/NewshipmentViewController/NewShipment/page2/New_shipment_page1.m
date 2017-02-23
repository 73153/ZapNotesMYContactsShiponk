//
//  New_shipment_page1.m
//  ShiponK
//
//  Created by bhavik on 5/25/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import "New_shipment_page1.h"
#import "Insurance_ViewController.h"
#define BASE_KEY @"AIzaSyBG2lM5lHV6a0N2_Gk3fUV3Vz8DnI8z_OU"
#import "appShareManager.h"
#import "ComMehod.h"
#import "Base_New_Shipment.h"
#import "ResidentialViewController.h"
#import "ApplicationData.h"
#import "SlideNavigationController.h"
#import "New_shipment_page2.h"
#import "MyShipment_ViewController.h"
#import "Shipment_Category_ViewController.h"
#import "PackagingTypeViewController.h"

#import "IQUIView+Hierarchy.h"
#import "IQUIView+IQKeyboardToolbar.h"

@interface New_shipment_page1 ()
{
    
    BOOL hide_date_view,promoCodeApply;
    bool check_txt_fld;
    BOOL check_urgent_del;
    BOOL check_service_pickup;
    NSString *strresidencebtnTag;
    
    NSString *clean_datetetimetxtfld;
    
    UITextField *selected_txt_fld;
    
    appShareManager *objappShareManager;
    ComMehod *objComMehod;
    NSMutableDictionary *parameter;
    
    int urgent_deliv;
    int pickup_service;
    
    
    
    
    //City Search
    BOOL check_Insurance;
    NSArray *feed_dataDic;
    NSMutableArray *aryCity,*aryTypes,*arypcode,*arydata,*aryPostalCode;
    NSDictionary *dataDic,*dataDic1,*dataDic2,*dataDic3;
    NSString *strpostalcode,*strplaceid;
    NSString *cityStr,*urlString;
    BOOL txtteg;
    NSString *strPickupErliestDate,*strPickupLatestDate,*strDelivErliestDate,*strDelivLatestDate,*strPickupTimePlus;
    
    NSInteger iBtn;
    NSString *strPackaging;
}
@end

@implementation New_shipment_page1
@synthesize strDeliveryResidence,strpickupResidence;
@synthesize strcity,tbl_City;
- (void)viewDidLoad
{
    [super viewDidLoad];
    hide_date_view =YES;
    check_service_pickup = NO;
    check_urgent_del = NO;
    strcity=[[NSString alloc]init];
    
    objComMehod = [[ComMehod alloc]init];
    urgent_deliv =0;
    pickup_service = 0;
    
    objappShareManager = [appShareManager sharedManager];
    
    
    [self.txt_city_moving_from_out addDoneOnKeyboardWithTarget:self action:@selector(doneAction:)];
    [self.txt_city_moving_to_out addDoneOnKeyboardWithTarget:self action:@selector(doneAction:)];
    
    parameter=[[NSMutableDictionary alloc]init];
    
    check_Insurance= YES;
    self.tbl_City.delegate=self;
    self.tbl_City.dataSource=self;
    [tbl_City reloadData];
    cityStr=[[NSString alloc]init];
    _City_tbl_view.hidden=YES;
    
   // [_mainScrollView setContentSize:CGSizeMake(0, 600)];
    clean_datetetimetxtfld = @"1";
    
}
-(void)doneAction:(UIBarButtonItem*)barButton
{
    
    [_txt_city_moving_to_out resignFirstResponder];
     [_txt_city_moving_from_out resignFirstResponder];
    _City_tbl_view.hidden=YES;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(picksetbtnText)
//                                                 name:@"picksetbtnText" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(picksetbtnText1)
                                                 name:@"btnPickupText" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(delsetbtnText)
                                                 name:@"delisetbtnText" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(cleanTextfield)
                                                 name:@"cleanTextfield1" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(PackagingType:)
                                                 name:@"PackagingType" object:nil];
    
    
    
}
-(void)PackagingType:(NSNotification *)n
{//n.userInfo[@"nextPage"]
    
    strPackaging=[NSString stringWithFormat:@"%@",[n.userInfo valueForKey:@"PackagingType"]];
    [self.btnPackagingType setTitle:strPackaging forState:UIControlStateNormal];
    [self.btnPackagingType setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

-(void)picksetbtnText1
{
    
    [self.btnPickupResidential setTitle:objappShareManager.pickResname forState:UIControlStateNormal];
    [self.btnPickupResidential setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
}

-(void)delsetbtnText
{
    
    [self.btnDeliverResidential setTitle:objappShareManager.DeliResname forState:UIControlStateNormal];
     [self.btnDeliverResidential setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

-(void)cleanTextfield
{
    
    
    self.txt_city_moving_from_out.text = NULL;
    self.txt_city_moving_to_out.text = NULL;
    self.txt_moving_date.text = NULL;
    self.txt_pickup_time.text = NULL;
    self.txt_DeliverLatest_Date.text = NULL;
    self.txt_DeliveryEariest_Date.text = NULL;
    [self.btnDeliverResidential setTitle:@" Residential" forState:UIControlStateNormal];
    [self.btnDeliverResidential setTitle:@" Residential" forState:UIControlStateNormal];

    
    UIImage *btnImage1 = [UIImage imageNamed:@"Square_Checkbox_Unchecked"];
    [_btn_out_urgent_deliv setImage:btnImage1 forState:UIControlStateNormal];
    check_urgent_del = NO;
    urgent_deliv =0;
    
    
    
    UIImage *btnImage2 = [UIImage imageNamed:@"Square_Checkbox_Unchecked"];
    [_btn_out_pickup_service setImage:btnImage2 forState:UIControlStateNormal];
    check_service_pickup = NO;
    pickup_service =0;
    
}

#pragma mark validation with navigation--------


- (IBAction)btn_continue_act:(id)sender
{
    if([[objComMehod spacecheck:_txt_city_moving_from_out.text]isEqualToString:@"0"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter city name" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if([[objComMehod spacecheck:_txt_moving_date.text]isEqualToString:@"0"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please select moving date." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if([[objComMehod spacecheck:_txt_moving_date.text]isEqualToString:@"0"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please select moving date." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if([[objComMehod spacecheck:_txt_moving_date.text]isEqualToString:@"0"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please select moving date." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if([[objComMehod spacecheck:objappShareManager.DeliResid]isEqualToString:@"0"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please select delivery Residence." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if([[objComMehod spacecheck:objappShareManager.pickResid]isEqualToString:@"0"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please select pickup residence." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    
    else
    {
        
        [objappShareManager.New_shipment_dic setValue:[NSString stringWithFormat:@"%@", _txt_city_moving_from_out.text] forKey:@"from_city"];
        
        [objappShareManager.New_shipment_dic setValue:[NSString stringWithFormat:@"%@", _txt_city_moving_to_out.text] forKey:@"to_city"];
        
        [objappShareManager.New_shipment_dic setValue:[NSString stringWithFormat:@"%d",pickup_service] forKey:@"need_packaged"];
        
        [objappShareManager.New_shipment_dic setValue:[NSString stringWithFormat:@"%d", urgent_deliv] forKey:@"is_urgent"];
        
        
        [objappShareManager.New_shipment_dic setValue:[NSString stringWithFormat:@"%@", strDelivLatestDate] forKey:@"delievery_latest_date"];
        
        [objappShareManager.New_shipment_dic setValue:[NSString stringWithFormat:@"%@",strDelivErliestDate ] forKey:@"delievery_earliest_date"];
        
        [objappShareManager.New_shipment_dic setValue:[NSString stringWithFormat:@"%@",strPickupLatestDate] forKey:@"pickup_latest_date"];
        
        [objappShareManager.New_shipment_dic setValue:[NSString stringWithFormat:@"%@", strPickupErliestDate] forKey:@"pickup_earliest_date"];
        
        
        
        
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"VehicalSet"
         object:nil];
        
    }
    
}

- (void)dateChanged
{
    
    if (iBtn == 1)
    {
        
        self.date_picker_out.datePickerMode = UIDatePickerModeDateAndTime;
        NSDate *myDate = self.date_picker_out.date;
        NSDate *minDate = [NSDate new];
        [self.date_picker_out setMinimumDate:minDate];
        [self.date_picker_out setMinuteInterval:30];
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd-MM-yyyy"];
        _txt_pickup_time.text = [dateFormat stringFromDate:myDate];
                strPickupErliestDate = _txt_pickup_time.text;
        
        
        NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc] init];
        [dateFormat1 setDateFormat:@"hh:mm a"];
       
            NSDate *datePlus = [myDate dateByAddingTimeInterval:7200];
        _txt_pickupLatest_Date.text = [NSString stringWithFormat:@"%@ - %@",[dateFormat1 stringFromDate:myDate],[dateFormat1 stringFromDate:datePlus]];
        
        strPickupTimePlus=[NSString stringWithFormat:@"%@ - %@",[dateFormat1 stringFromDate:myDate],[dateFormat1 stringFromDate:datePlus]];

       
        
    }
    else if (iBtn == 2)
    {
        self.date_picker_out.datePickerMode = UIDatePickerModeDateAndTime;
        NSDate *myDate = self.date_picker_out.date;
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"hh:mm a"];
        _txt_pickupLatest_Date.text = [dateFormat stringFromDate:myDate];
        strPickupLatestDate = _txt_pickupLatest_Date.text;
        NSDate *datePlus = [myDate dateByAddingTimeInterval:7200];
        
        _txtPickupPlusTime.text = [dateFormat stringFromDate:datePlus];
        
        strPickupTimePlus=[NSString stringWithFormat:@"%@", _txtPickupPlusTime.text];
       
    }else if (iBtn == 3)
    {
        self.date_picker_out.datePickerMode = UIDatePickerModeDate;
        NSDate *myDate = self.date_picker_out.date;
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd/MM/yyyy"];
        _txt_DeliveryEariest_Date.text = [dateFormat stringFromDate:myDate];
        strDelivErliestDate = _txt_DeliveryEariest_Date.text;
        
        
    }else if (iBtn == 4)
    {
        self.date_picker_out.datePickerMode = UIDatePickerModeDate;
        NSDate *myDate = self.date_picker_out.date;
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd/MM/yyyy"];
        _txt_DeliverLatest_Date.text = [dateFormat stringFromDate:myDate];
        strDelivLatestDate = _txt_DeliverLatest_Date.text;
      
    }
    
}

- (IBAction)btn_pick_up_time_act:(id)sender

{
    
    iBtn = [sender tag];
    
    clean_datetetimetxtfld = @"1";
    [self dismissKeyboard];
    [_txt_moving_date resignFirstResponder];
    [_txt_pickup_time resignFirstResponder];
    
    
    if (iBtn == 1)
    {
        
        self.date_picker_out.datePickerMode = UIDatePickerModeDateAndTime;
        [self.date_picker_out setMinuteInterval:60];
    }
    else if (iBtn == 2)
    {
      self.date_picker_out.datePickerMode = UIDatePickerModeDateAndTime;
    }
    check_txt_fld = NO;
    if (hide_date_view == YES)
    {
        hide_date_view = NO;
        [UIView animateWithDuration:.45 animations:^{
            _view_date_picker_out.frame = CGRectOffset(self.view_date_picker_out.frame, 0, -self.view_date_picker_out.frame.size.height);
        }];
    }
    [self.date_picker_out addTarget:self action:@selector(dateChanged) forControlEvents:UIControlEventValueChanged];
    
}

- (IBAction)btn_moving_date_act:(id)sender
{
    clean_datetetimetxtfld = @"2";
    [self dismissKeyboard];
    
    [_txt_moving_date resignFirstResponder];
    [_txt_pickup_time resignFirstResponder];
    self.date_picker_out.datePickerMode = UIDatePickerModeDate;
    check_txt_fld = YES;
    if (hide_date_view == YES)
    {
        hide_date_view = NO;
        [UIView animateWithDuration:.45 animations:^{
            _view_date_picker_out.frame = CGRectOffset(self.view_date_picker_out.frame, 0, -self.view_date_picker_out.frame.size.height);
        }];
        
        
    }
    [self.date_picker_out addTarget:self action:@selector(dateChanged) forControlEvents:UIControlEventValueChanged];
    
}

- (IBAction)btn_date_picker_down:(id)sender
{
    
    [UIView animateWithDuration:.65 animations:^{
        _view_date_picker_out.frame = CGRectOffset(_view_date_picker_out.frame, 0, self.view_date_picker_out.frame.size.height);
    }];
    
    hide_date_view = YES;
}

#pragma mark - For City Search  -
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGPoint scrollPoint = CGPointMake(0,textField.frame.origin.y-5);
    [_mainScrollView setContentOffset:scrollPoint animated:YES];
//    if(textField.tag==0)
//    {
//        _txt_city_moving_from_out.text=NULL;
//        
//        
//    }else if(textField.tag==1)
//    {
//        
//        _txt_city_moving_to_out.text=NULL;
//        
//    }
//    
    
    if (hide_date_view == NO)
    {
        [UIView animateWithDuration:.65 animations:^{
            _view_date_picker_out.frame = CGRectOffset(_view_date_picker_out.frame, 0, self.view_date_picker_out.frame.size.height);
        }];
        hide_date_view = YES;
    }
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    [_mainScrollView setContentOffset:CGPointZero animated:YES];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    txtteg=textField.tag;
    if (textField.tag==100) {
        
    }
    else
    {
        
    NSCharacterSet *charsToTrim = [NSCharacterSet characterSetWithCharactersInString:@"()   ;    ^^ ?? ? // [{]}+=_-* / ,' \\  \" ^#`<>| ^  % : @ @@"];
    
    
    NSString *str1 = [self.txt_city_moving_from_out.text stringByTrimmingCharactersInSet:charsToTrim];
    NSString *strSearch1 = [str1 stringByReplacingOccurrencesOfString:@" " withString:@""];//stringByReplacingOccurrencesOfString:@"/" withString:@""]stringByReplacingOccurrencesOfString:@"^" withString:@""]stringByReplacingOccurrencesOfString:@"?" withString:@""];
    

    
    NSString *str2 = [self.txt_city_moving_to_out.text stringByTrimmingCharactersInSet:charsToTrim];
    NSString *strSearch2 = [str2 stringByReplacingOccurrencesOfString:@" " withString:@""];//stringByReplacingOccurrencesOfString:@"/" withString:@""]stringByReplacingOccurrencesOfString:@"^" withString:@""]stringByReplacingOccurrencesOfString:@"?" withString:@""];

    if(textField.tag==0)
    {
        urlString = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/autocomplete/json?key=%@&input=%@",BASE_KEY,strSearch1];
        if (_txt_city_moving_from_out.text.length>0) {
            _City_tbl_view.hidden=NO;
        }
        
        
    }else if(textField.tag==1)
    {
        urlString = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/autocomplete/json?key=%@&input=%@",BASE_KEY,strSearch2];
        
        if (_txt_city_moving_to_out.text.length>0) {
            _City_tbl_view.hidden=NO;
        }
        
    }
    
    
        
    NSURL *url=[NSURL URLWithString:urlString];
    
    //  dispatch_async(kBgQueue, ^{
    NSData* data = [NSData dataWithContentsOfURL: url];
    // [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
    //  })
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:data
                          
                          options:kNilOptions
                          error:&error];
    NSLog(@"Data:%@",json);
    //The results from Google will be an array obtained from the NSDictionary object with the key "results".
    dataDic = [json objectForKey:@"predictions"];
    feed_dataDic=(NSArray *)dataDic;
    aryCity = [feed_dataDic valueForKey:@"description"];
    aryPostalCode=[feed_dataDic valueForKey:@"place_id"];
    
    //Write out the data to the console.
    NSLog(@"Google Data: %@", aryCity);
    
    NSLog(@"PlaceID=%@",aryPostalCode);
    
    
    if(string.length == 0 && textField.text.length==1)
    {
        aryCity=nil;
        _City_tbl_view.hidden=YES;
        [self.tbl_City reloadData];
    }
    
    [self.tbl_City reloadData];
    }
    return YES;
}
-(void)json{
    
    NSString *urlString1 = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/details/json?key=%@&placeid=%@",BASE_KEY,strplaceid];
    NSURL *url=[NSURL URLWithString:urlString1];
    
    //  dispatch_async(kBgQueue, ^{
    NSData* data = [NSData dataWithContentsOfURL: url];
    // [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
    //  })
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:data
                          
                          options:kNilOptions
                          error:&error];
    
    dataDic1 = [json objectForKey:@"result"];
    dataDic2 = [dataDic1 objectForKey:@"address_components"];
    // arydata=(NSMutableArray *)dataDic2;
    strpostalcode=[[NSString alloc]init];
    for(int i=0;i<[dataDic2 count];i++)
    {
        if ([[[[dataDic2 valueForKey:@"types"]objectAtIndex:i]objectAtIndex:0] isEqualToString:@"postal_code"]) {
            aryTypes=[dataDic2 valueForKey:@"long_name"];
            
            strpostalcode=[aryTypes objectAtIndex:i];
        }
        
    }
    
    NSLog(@"Data:%@",strpostalcode);
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return aryCity.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tbl_City dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [aryCity objectAtIndex:indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    strplaceid=[aryPostalCode objectAtIndex:indexPath.row];
    [self json];
    UITableViewCell *selectedcell=(UITableViewCell *)[self.tbl_City cellForRowAtIndexPath:indexPath];
    cityStr=selectedcell.textLabel.text;
    
    if(txtteg==0)
    {
        
        self.txt_city_moving_from_out.text=[NSString stringWithFormat:@"%@,%@",cityStr,strpostalcode];
        [self dismissKeyboard];
        
    } if(txtteg==1)
    {
        _txt_city_moving_to_out.text=[NSString stringWithFormat:@"%@,%@",cityStr,strpostalcode];
        [self dismissKeyboard];
    }
    
    
    
    _City_tbl_view.hidden=YES;
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dismissKeyboard];
}

-(void)dismissKeyboard{
    
    [_txt_city_moving_from_out resignFirstResponder];
    [_txt_city_moving_to_out resignFirstResponder];
    [_txt_moving_date resignFirstResponder];
    [_txt_pickup_time resignFirstResponder];
    [_txtPromoCode resignFirstResponder];
    if (hide_date_view == NO)
    {
        [UIView animateWithDuration:.45 animations:^{
            _view_date_picker_out.frame = CGRectOffset(_view_date_picker_out.frame, 0, self.view_date_picker_out.frame.size.height);
        }];
        hide_date_view = YES;
    }
    
}




#pragma mark - For Insurance Checkbox  -

- (IBAction)btn_Insurance_Checkbox:(id)sender {
    
    if (check_Insurance == YES)
    {
        UIImage *btnImage1 = [UIImage imageNamed:@"Square_Checkbox_Unchecked"];
        [_btn_Insurance_Checked_UnChecked setImage:btnImage1 forState:UIControlStateNormal];
        check_Insurance = NO;
        
    }
    else if (check_Insurance == NO)
    {
        UIImage *btnImage = [UIImage imageNamed:@"Square_Checkbox_Checked"];
        [_btn_Insurance_Checked_UnChecked setImage:btnImage forState:UIControlStateNormal];
        check_Insurance = YES;
        Insurance_ViewController *controller =(Insurance_ViewController *) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"Insurance_ViewController"];
        
        
        
        [self.parentViewController addChildViewController:controller];
        
        [self.parentViewController.view addSubview:controller.view];
        
        [controller didMoveToParentViewController:self];
        
        [controller.view setFrame:CGRectMake(0,0,controller.view.frame.size.width,self.view.frame.size.height)];
    }
    
    
    
    
}



- (IBAction)btn_act_urgent_deliv:(id)sender
{
    if (check_urgent_del == YES)
    {
        UIImage *btnImage1 = [UIImage imageNamed:@"Square_Checkbox_Unchecked"];
        [_btn_out_urgent_deliv setImage:btnImage1 forState:UIControlStateNormal];
        check_urgent_del = NO;
        urgent_deliv =0;
        
    }
    else if (check_urgent_del == NO)
    {
        UIImage *btnImage = [UIImage imageNamed:@"Square_Checkbox_Checked"];
        [_btn_out_urgent_deliv setImage:btnImage forState:UIControlStateNormal];
        check_urgent_del = YES;
        urgent_deliv = 1;
        
    }
    
    
}
- (IBAction)btn_act_pickup_service:(id)sender
{
    if (check_service_pickup == YES)
    {
        UIImage *btnImage1 = [UIImage imageNamed:@"Square_Checkbox_Unchecked"];
        [_btn_out_pickup_service setImage:btnImage1 forState:UIControlStateNormal];
        check_service_pickup = NO;
        pickup_service =0;
        [UIView animateWithDuration:.35 animations:^{
              [_viewSubmitBtn setFrame:CGRectOffset(_viewSubmitBtn.frame, 0,- _txtPromoCode.frame.size.height*1.2)];
        }];
      
        
    }
    else if (check_service_pickup == NO)
    {
        UIImage *btnImage = [UIImage imageNamed:@"Square_Checkbox_Checked"];
        [_btn_out_pickup_service setImage:btnImage forState:UIControlStateNormal];
        check_service_pickup = YES;
        pickup_service = 1;
        strPackaging=nil;
        [self.btnPackagingType setTitle:@"PACKAGING TYPE" forState:UIControlStateNormal];
        [self.btnPackagingType setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
        [UIView animateWithDuration:.35 animations:^{
            [_viewSubmitBtn setFrame:CGRectOffset(_viewSubmitBtn.frame, 0,_txtPromoCode.frame.size.height*1.2)];
        }];
        
    }
}

- (IBAction)btnCancleDatePickerAct:(id)sender
{
    
    if ([clean_datetetimetxtfld isEqualToString:@"1"])
    {
        self.txt_pickup_time.text = NULL;
        self.txt_pickupLatest_Date.text=NULL;
    }
    else if([clean_datetetimetxtfld isEqualToString:@"2"])
    {
        self.txt_moving_date.text = NULL;
    }
    
    
    [UIView animateWithDuration:.65 animations:^{
        _view_date_picker_out.frame = CGRectOffset(_view_date_picker_out.frame, 0, self.view_date_picker_out.frame.size.height);
    }];
    
    hide_date_view = YES;
    
}
- (IBAction)btnPickupResidentail_Action:(id)sender
{
    
    
    ResidentialViewController *objResidentialViewController= (ResidentialViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"ResidentialViewController"];
    
    
    objResidentialViewController.strResidenceBtnTag = [NSString stringWithFormat:@"1"];
    
    objResidentialViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    
    
    [self.view addSubview:objResidentialViewController.view];
    [self addChildViewController:objResidentialViewController];
    [objResidentialViewController didMoveToParentViewController:self];
    
    
    [UIView animateWithDuration:0.3/1.5 animations:^{
        objResidentialViewController.view.transform=CGAffineTransformScale(CGAffineTransformIdentity,1.1,1.1);
        
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3/2 animations:^{
            objResidentialViewController.view.transform=CGAffineTransformScale(CGAffineTransformIdentity,0.9,0.9);
            
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/2 animations:^{
                objResidentialViewController.view.transform=CGAffineTransformIdentity;
                
                
            }];
        }];
    }];
    
    
    
    
}
- (IBAction)btnDelverResidentialAction:(id)sender
{
    
    ResidentialViewController *objResidentialViewController= (ResidentialViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"ResidentialViewController"];
    objResidentialViewController.strResidenceBtnTag = [NSString stringWithFormat:@"2"];
    
    objResidentialViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    
    
    [self.view addSubview:objResidentialViewController.view];
    [self addChildViewController:objResidentialViewController];
    [objResidentialViewController didMoveToParentViewController:self];
    
    
    [UIView animateWithDuration:0.3/1.5 animations:^{
        objResidentialViewController.view.transform=CGAffineTransformScale(CGAffineTransformIdentity,1.1,1.1);
        
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3/2 animations:^{
            objResidentialViewController.view.transform=CGAffineTransformScale(CGAffineTransformIdentity,0.9,0.9);
            
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/2 animations:^{
                objResidentialViewController.view.transform=CGAffineTransformIdentity;
                
                
            }];
        }];
    }];
    
    
}


- (IBAction)btnSubmitAction:(id)sender {
    
    
    
    
    
    if([[objComMehod spacecheck:_txt_city_moving_from_out.text]isEqualToString:@"0"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter city name" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if([[objComMehod spacecheck:_txt_city_moving_to_out.text]isEqualToString:@"0"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter city name." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if([[objComMehod spacecheck:_txt_pickupLatest_Date.text]isEqualToString:@"0"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please select date." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
//    else if([[objComMehod spacecheck:_txtPickupPlusTime.text]isEqualToString:@"0"])
//    {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please select Time." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//    }
    else if([[objComMehod spacecheck:objappShareManager.DeliResid]isEqualToString:@"0"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please select delivery Residence." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if([[objComMehod spacecheck:objappShareManager.pickResid]isEqualToString:@"0"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please select pickup residence." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if(strPackaging==nil && check_service_pickup == YES)
    {
        
        
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please select Packaging Type." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        
    }
    
    else
    {
        
        
   
     
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
            
            [APPDATA showLoader];
            
        }];
        
    NSString *strcategoryId =  [objappShareManager.New_shipment_dic valueForKey:@"category_id"];
         NSString *strDescription = [objappShareManager.New_shipment_dic valueForKey:@"description"];
    NSString *strsubcategoryId = [objappShareManager.New_shipment_dic valueForKey:@"sub_category_id"];
   // NSString *strTitle = [objappShareManager.New_shipment_dic valueForKey:@"title"];
    NSString *strfromCity = [NSString stringWithFormat:@"%@", _txt_city_moving_from_out.text];
    NSString *strtoCity = [NSString stringWithFormat:@"%@", _txt_city_moving_to_out.text];
    NSString *strneedPackage = [NSString stringWithFormat:@"%d",pickup_service];
    NSString *strisUrgent = [NSString stringWithFormat:@"%d", urgent_deliv];
    NSString *strPickupTime=[NSString stringWithFormat:@"%@",strPickupTimePlus];
   // NSString *strPickupTimePluss=[NSString stringWithFormat:@"%@",strPickupTimePlus];
    NSString *strPickupDate=[NSString stringWithFormat:@"%@", strPickupErliestDate];
    NSString *strpickuplocation = [NSString stringWithFormat:@"%@",objappShareManager.pickResid];
    NSString * strdelivlocation = [NSString stringWithFormat:@"%@",objappShareManager.DeliResid];

        
        
        
        NSData* jsonData = [NSJSONSerialization dataWithJSONObject:objappShareManager.addAnItemArray2  options:0 error:nil];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSString *strAddAnItem=[NSString stringWithFormat:@"%@",jsonString];
        
//        
//        NSCharacterSet *charsToTrim = [NSCharacterSet characterSetWithCharactersInString:@"< > null ()  \n \"  \\"];
//        NSString *str = [strAddAnItem stringByTrimmingCharactersInSet:charsToTrim];

//
//        NSCharacterSet *charsToTrim2 = [NSCharacterSet characterSetWithCharactersInString:@"()"];
//        str = [str stringByTrimmingCharactersInSet:charsToTrim2];
//        
//        str = [[str componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]]componentsJoinedByString:@""];
//        
//        NSString  *str=[[str stringByReplacingOccurrencesOfString:@")" withString:@""] stringByReplacingOccurrencesOfString:@"(" withString:@""];
//
         NSString  *str =[strAddAnItem stringByReplacingOccurrencesOfString:@"\\" withString:@""];
//        
//        str=[[str stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
//
 
        
        NSString *str_uid =[NSString stringWithFormat:@"%@",[objappShareManager.loginDic valueForKey:@"user_id"]];
    
        [parameter setValue:str_uid forKey:@"user_id"];
        //[parameter setValue:strTitle forKey:@"title"];
        [parameter setValue:strcategoryId forKey:@"category_id"];
        [parameter setValue:strsubcategoryId forKey:@"sub_category_id"];
        [parameter setValue:strfromCity forKey:@"from_city"];
        [parameter setValue:strtoCity forKey:@"to_city"];
        [parameter setValue:strpickuplocation forKey:@"pickup_location"];
        [parameter setValue:strdelivlocation forKey:@"delievery_location"];
        [parameter setValue:strDescription forKey:@"description"];
        [parameter setValue:strisUrgent forKey:@"is_urgent"];
        [parameter setValue:strneedPackage forKey:@"need_packaged"];
        [parameter setValue:str forKey:@"items"];
        [parameter setValue:strPickupTime forKey:@"pickup_time"];
       // [parameter setValue:strPickupTimePluss forKey:@"pickup_end_time"];
        
        [parameter setValue:strPickupDate forKey:@"pickup_date"];
        
        
        if (check_service_pickup == YES)
        {
            
        [parameter setValue:strPackaging forKey:@"packaging_service"];
        
        }
        if (promoCodeApply==YES) {
            
        [parameter setValue:[NSString stringWithFormat:@"%@",_txtPromoCode.text] forKey:@"promo_code"];
            
        }
      //  [parameter setValue:str1 forKey:@"shipment_image"];
        
//        [parameter setValue:strpickup_earliest_date forKey:@"pickup_earliest_date"];
//        [parameter setValue:strpickup_latest_date forKey:@"pickup_latest_date"];
//        [parameter setValue:strdelievery_earliest_date forKey:@"delievery_earliest_date"];
//        [parameter setValue:strdelievery_latest_date forKey:@"delievery_latest_date"];
        

        void (^successed)(id responseObject) = ^(id responseObject)
        {
            NSLog(@"%@",responseObject);
            
            
            objappShareManager.New_shipment_dic=[[NSMutableDictionary alloc]init];
            objappShareManager.addAnItemArray2=[[NSMutableArray alloc]init];
            objappShareManager.pickResid=[[NSString alloc]init];
            objappShareManager.DeliResid=[[NSString alloc]init];
            
            
            _txt_city_moving_from_out.text=NULL;
            _txt_city_moving_to_out.text=NULL;
            _txt_pickupLatest_Date.text=NULL;
            _txtPickupPlusTime.text=NULL;
            _txt_pickup_time.text=NULL;
            
            
            
            [self.btnPickupResidential setTitle:@"SELECT TYPE" forState:UIControlStateNormal];
             [self.btnPickupResidential setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            
            [self.btnDeliverResidential setTitle:@"SELECT TYPE" forState:UIControlStateNormal];
             [self.btnDeliverResidential setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

            
            
            [_btn_out_pickup_service setImage:[UIImage imageNamed:@"Square_Checkbox_Unchecked"] forState:UIControlStateNormal];
            check_service_pickup = NO;
            pickup_service =0;

            
            
            
            [_btn_out_urgent_deliv setImage:[UIImage imageNamed:@"Square_Checkbox_Unchecked"] forState:UIControlStateNormal];
            check_urgent_del = NO;
            urgent_deliv =0;
            
            
            
            //  [[NSNotificationCenter defaultCenter] postNotificationName:@"firstPage" object:nil ];
            
//            [[NSNotificationCenter defaultCenter]
//             postNotificationName:@"cleanTextfield1"
//             object:nil];
//            [[NSNotificationCenter defaultCenter]
//             postNotificationName:@"cleanTextfield2"
//             object:nil];
            
             MyShipment_ViewController *objviewController =(MyShipment_ViewController *) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"MyShipment_ViewController"];
            
            _imgDone.hidden=NO;
            self.view.userInteractionEnabled=NO;
            
            [[_imgDone layer] setShadowOpacity:0.55f];
            [[_imgDone layer] setShadowRadius:15.0f];
            [[_imgDone layer] setCornerRadius:8.0f];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [APPDATA pushNewViewController:objviewController];

            });
            
            
            [APPDATA hideLoader];
            
//            
//            
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
//                                                            message:[responseObject valueForKey:@"message"]
//                                                           delegate:self
//                                                  cancelButtonTitle:@"OK"
//                                                  otherButtonTitles:nil];
//            
//            UIImage* imgMyImage = [[UIImage imageNamed:@"img_Done"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//            UIImageView* ivMyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 40, 40)];
//            [ivMyImageView setImage:imgMyImage];
//            
//            
//            if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
//                [alert setValue:ivMyImageView forKey:@"accessoryView"];
//            }else{
//                [alert addSubview:ivMyImageView];
//            }
//            [alert show];
//            [self performSelector:@selector(dismissAlert:) withObject:alert afterDelay:3.0f];
//            
            
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sucess"
//                                                            message:[responseObject valueForKey:@"message"]
//                                                           delegate:self
//                                                  cancelButtonTitle:@"OK"
//                                                  otherButtonTitles:nil];
//            
//            [alert show];
            
            
         
            
        };
        
        void (^failure)(NSError * error) = ^(NSError *error)
        {
            [APPDATA hideLoader];
            NSLog(@"%@",error);
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"WS error"              delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            
                      [alert show];
        };
        
        
        
        
        
        [ApiCall sendToService:API_CREATE_SHIPMENT andDictionary:parameter success:successed failure:failure];
        

        
    
    }
    
    
    
}
-(void)dismissAlert:(UIAlertView *) alertView
{
    [alertView dismissWithClickedButtonIndex:nil animated:YES];
   
}
- (IBAction)btnBackAction:(id)sender {
    
    New_shipment_page2 *objviewController =(New_shipment_page2 *) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"New_shipment_page2"];
    
    
    [APPDATA pushNewViewController:objviewController];
    
//    [[NSNotificationCenter defaultCenter]
//     postNotificationName:@"backPage"
//     object:nil];

    
}

- (IBAction)btnHomeAction:(id)sender {
    
    Shipment_Category_ViewController *objviewController =(Shipment_Category_ViewController *) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"Shipment_Category_ViewController"];
    
    
    [APPDATA pushNewViewController:objviewController];
}

- (IBAction)btnPackagingTypeAction:(id)sender {
    
    PackagingTypeViewController *objPackagingTypeViewController= (PackagingTypeViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"PackagingTypeViewController"];
    
    objPackagingTypeViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    
    
    [self.view addSubview:objPackagingTypeViewController.view];
    [self addChildViewController:objPackagingTypeViewController];
    [objPackagingTypeViewController didMoveToParentViewController:self];
    
    
    [UIView animateWithDuration:0.3/1.5 animations:^{
        objPackagingTypeViewController.view.transform=CGAffineTransformScale(CGAffineTransformIdentity,1.1,1.1);
        
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3/2 animations:^{
            objPackagingTypeViewController.view.transform=CGAffineTransformScale(CGAffineTransformIdentity,0.9,0.9);
            
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/2 animations:^{
                objPackagingTypeViewController.view.transform=CGAffineTransformIdentity;
                
                
            }];
        }];
    }];

    
    
}
- (void)addDoneOnKeyboardWithTarget:(id)target action:(SEL)action titleText:(NSString*)titleText
{
    
}
- (IBAction)btnPromoCodeApplyAction:(id)sender {
    
    [self dismissKeyboard];
    
    if([[objComMehod spacecheck:_txtPromoCode.text]isEqualToString:@"0"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter Promo Code" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        
    void (^successed)(id responseObject) = ^(id responseObject)
    {
        NSLog(@"%@",responseObject);
        [APPDATA hideLoader];
        
        if ([[responseObject valueForKey:@"status"] isEqualToString:@"Error"]) {
            
            _txtPromoCode.text=NULL;
            
        }
        if ([[responseObject valueForKey:@"status"] isEqualToString:@"Success"]) {
            
            _txtPromoCode.userInteractionEnabled=NO;
            _btnPromoCodeApply.hidden=YES;
            promoCodeApply=YES;
            
        }

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:[responseObject valueForKey:@"message"]
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        
        [alert show];
        
        
        
        
    };
    
    void (^failure)(NSError * error) = ^(NSError *error)
    {
        [APPDATA hideLoader];
        NSLog(@"%@",error);
    };
     NSString *str_uid =[NSString stringWithFormat:@"%@",[objappShareManager.loginDic valueForKey:@"user_id"]];
    
    NSDictionary *dict = @{@"promo_code":_txtPromoCode.text,@"user_id":str_uid};
    
    
    
    [ApiCall sendToService:API_APPLY_PROMO_CODE andDictionary:dict success:successed failure:failure];
    
    }
}
@end
