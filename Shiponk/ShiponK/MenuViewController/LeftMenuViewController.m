//
//  MenuViewController.m
//  SlideMenu
//
//  Created by Aryan Gh on 4/24/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//
#import "AboutUsVC.h"
#import "LeftMenuViewController.h"
#import "SlideNavigationContorllerAnimatorFade.h"
#import "SlideNavigationContorllerAnimatorSlide.h"
#import "SlideNavigationContorllerAnimatorScale.h"
#import "SlideNavigationContorllerAnimatorScaleAndFade.h"
#import "SlideNavigationContorllerAnimatorSlideAndFade.h"
#import "appShareManager.h"
#import "Constant.h"
#import "ApplicationData.h"
#import "ViewController.h"
#import "Message_ViewController.h"
#import "MyShipment_ViewController.h"
#import "NewshipmentViewController.h"
#import "ChnagepasswordViewController.h"
#import "RegistrationCustomerViewController.h"
#import "JoinCarrerViewController.h"
#import "Profile_ViewController.h"
#import "Message_ViewController.h"
#import "DashbordViewController.h"
#import "Setting_carrier_ViewController.h"
#import "Setting_customer_ViewController.h"
#import "TransporterDetailViewController.h"
#import "PayMentViewController.h"
#import "MyBideViewController.h"
#import "Shipment_Category_ViewController.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "ReferAFriendViewController.h"
#import "ViewRatingAndReviewVC.h"
#import "PaymentHistoryVC.h"


@implementation LeftMenuViewController
{
    BOOL Clock;
    NSInteger sec;
}
#pragma mark - UIViewController Methods -

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self.slideOutAnimationEnabled = YES;
	
	return [super initWithCoder:aDecoder];
}


- (void)viewDidLoad
{
	[super viewDidLoad];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(clock)
                                   userInfo:nil
                                    repeats:YES];
	
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(userLoginType)
                                                 name:@"SlideNavigationControllerDidOpen" object:nil];
    
    objappShareManager = [appShareManager sharedManager];
    acFlage=YES;
    
    _imgNotification.layer.cornerRadius=_imgNotification.frame.size.width/2;
    _imgNotification2.layer.cornerRadius=_imgNotification.frame.size.width/2;
    _imgNotification.layer.masksToBounds = YES;
    _imgNotification2.layer.masksToBounds = YES;
    
    
    if ([objappShareManager.loginUserFlage isEqualToString:@"2"])
    {
        _view_carrier.hidden=NO;
        _scrollView_carrier.hidden=NO;
        _viewPayNow.hidden=NO;
        
        
        _scrollView_carrier.contentSize=CGSizeMake(_scrollView_carrier.frame.size.width, 650);
        [NSTimer scheduledTimerWithTimeInterval:1.0
                                         target:self
                                       selector:@selector(timeintre)
                                       userInfo:nil
                                        repeats:YES];
       
       
        
        
    }else{
        _view_carrier.hidden=YES;
        _viewPayNow.hidden=YES;
        _scrollView_carrier.hidden=YES;

    }
    
    
    
}
-(void)clock
{
    
    if (Clock==NO) {
        [UIView animateWithDuration:1 animations:^{
            
            self.imgClock.transform=CGAffineTransformScale(CGAffineTransformIdentity,1.5,1.5);
            self.imgNotification.transform=CGAffineTransformScale(CGAffineTransformIdentity,1.3,1.3);
            self.imgNotification2.transform=CGAffineTransformScale(CGAffineTransformIdentity,1.3,1.3);
            
        }];
        Clock=YES;
        
    }
    else
    {
        Clock=NO;
        [UIView animateWithDuration:1 animations:^{
            
            self.imgClock.transform=CGAffineTransformIdentity;
            self.imgNotification.transform=CGAffineTransformIdentity;
            self.imgNotification2.transform=CGAffineTransformIdentity;

            
        }];
    }
    
    
}

-(void)timeintre
{

    self.lblDueAmtOut.text =[NSString stringWithFormat:@"%@",[objappShareManager.loginDic valueForKey:@"due_amount"]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dateFromString = [[NSDate alloc] init];
    dateFromString = [dateFormatter dateFromString:[objappShareManager.loginDic valueForKey:@"time_remaining"]];
    //   dateFromString=[dateFromString dateByAddingTimeInterval:19800];
    
    NSDate *now = [NSDate date];
    
    
    NSDateComponents *components;
    NSInteger days;
    NSInteger hour;
    NSInteger minutes;
    
    NSString *durationStringd;
    NSString *durationStringh;
    NSString *durationStringm;
    //NSString *durationStrings;
    
    components = [[NSCalendar currentCalendar] components: NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute
                                                 fromDate: now toDate: dateFromString options: 0];
    days = [components day];
    hour=[components hour];
    minutes=[components minute];
    
    
    if(days>0){
        
        if(days>1){
            durationStringd=[NSString stringWithFormat:@"%ld",(long)days];
        }
        else{
            durationStringd=[NSString stringWithFormat:@"%ld",(long)days];
            
        }
        //return durationString;
    }
    
    if(hour>0){
        
        if(hour>1){
            durationStringh=[NSString stringWithFormat:@"%ld",(long)hour];
        }
        else{
            durationStringh=[NSString stringWithFormat:@"%ld",(long)hour];
            
        }
        //return durationString;
    }
    
    if(minutes>0){
        
        if(minutes>1){
            durationStringm=[NSString stringWithFormat:@"%ld",(long)minutes];
        }
        else{
            durationStringm=[NSString stringWithFormat:@"%ld",(long)minutes];
            
        }
        // return durationString;
    }
    //    if(sec>0){
    //
    //        if(sec>1){
    //            durationStrings=[NSString stringWithFormat:@"%d",sec];
    //        }
    //        else{
    //            durationStrings=[NSString stringWithFormat:@"%d",sec];
    //
    //        }
    //        // return durationString;
    //    }
    
    if (sec==0) {
        sec=59;
    }
    else
    {
        sec--;
    }
    
    if (!durationStringh && !durationStringm && !durationStringd) {
        
        sec=00;
    }
    if (!durationStringd) {
        durationStringd=@"00";
    }
    if (!durationStringh) {
        durationStringh=@"00";
    }
    if (!durationStringm) {
        durationStringm=@"00";
    }
    
    
    self.lblRemainingTimeOut.text = [NSString stringWithFormat:@"%@d:%@h:%@m:%lds",durationStringd,durationStringh,durationStringm,(long)sec];
    
    
    
    
//    //bhavik's code for timer------------------
//    self.lblDueAmtOut.text =[NSString stringWithFormat:@"%@",[objappShareManager.loginDic valueForKey:@"due_amount"]];
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-mm-dd HH:mm:ss"];
//    NSDate *dateFromString = [[NSDate alloc] init];
//    dateFromString = [dateFormatter dateFromString:[objappShareManager.loginDic valueForKey:@"time_remaining"]];
//    NSDate *now = [NSDate date];
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    NSDateComponents *componentsHours = [calendar components:NSHourCalendarUnit fromDate:now];
//    NSDateComponents *componentMint = [calendar components:NSMinuteCalendarUnit fromDate:now];
//    NSDateComponents *componentSec = [calendar components:NSSecondCalendarUnit fromDate:now];
//    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    NSDateComponents *componentsDaysDiff = [gregorianCalendar components:NSDayCalendarUnit
//                                                                fromDate:now
//                                                                  toDate:dateFromString
//                                                                 options:0];
//    double dou = componentsDaysDiff.day;
//    NSString * str = [NSString stringWithFormat:@"%.0f",dou];
//    NSString  *strDay=[str stringByReplacingOccurrencesOfString:@"-" withString:@""];
//    NSString * strHou=[NSString stringWithFormat:@"%.0ld",(24-componentsHours.hour)];
//    NSString * strMin=[NSString stringWithFormat:@"%.0ld",(60-componentMint.minute)];
//    NSString * strSec=[NSString stringWithFormat:@"%02ld",(60-componentSec.second)];
//    self.lblRemainingTimeOut.text = [NSString stringWithFormat:@"%@d:%@h:%@m:%@s",strDay,strHou,strMin,strSec];
}


- (void)viewWillAppear:(BOOL)animated{
   

}



-(void)userLoginType{
    
    
    objappShareManager = [appShareManager sharedManager];
    acFlage=YES;
    
    if ([objappShareManager.loginUserFlage isEqualToString:@"2"])
    {
        _view_carrier.hidden=NO;
        _viewPayNow.hidden=NO;
        _scrollView_carrier.hidden=NO;
        
         _scrollView_carrier.contentSize=CGSizeMake(_scrollView_carrier.frame.size.width, 650);
        
    }else{
        _view_carrier.hidden=YES;
        _viewPayNow.hidden=YES;
        _scrollView_carrier.hidden=YES;

    }
    
    
    
    
    _lbl_useName.text=[NSString stringWithFormat:@"%@",objappShareManager.L_FNameStr];
    
    
    
    NSCharacterSet *charsToTrim = [NSCharacterSet characterSetWithCharactersInString:@"< > null()  \n\""];
    NSString *strNot=[NSString stringWithFormat:@"%@",[objappShareManager.loginDic valueForKey:@"badge_count"]];
      strNot = [strNot stringByTrimmingCharactersInSet:charsToTrim];
        
    if ([strNot length]<1){
        strNot=@"0";
    }
    
    _lbl_notification.text=strNot;
    _lbl_notification2.text=strNot;
    _lbl_notCust.text=strNot;
    
    
    
   
    
    _img_profile.layer.cornerRadius=_img_profile.frame.size.width/2.0;
    _img_profile.layer.masksToBounds=YES;
    _img_profile.clipsToBounds=YES;
    
    if ([objappShareManager.L_P_FStr length]<1)
    {
        [_img_profile setImage:[UIImage imageNamed:@"CollCellStaticImg"]];
        
    }else{
        [_img_profile setImageWithURL:[NSURL URLWithString:objappShareManager.L_P_FStr] placeholderImage:[UIImage imageNamed:@"myImage.jpg"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }

    
    
    
    if ([[objappShareManager.loginDic valueForKey:@"payment_pending"]isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        _viewPayNow.hidden=NO;
        
        
    }else{
        _viewPayNow.hidden=YES;
    }
    
}


- (IBAction)btn_Cust_MyShipmentAction:(id)sender

{
    
    
    MyShipment_ViewController *objviewController =(MyShipment_ViewController *) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"MyShipment_ViewController"];
    
    
    [APPDATA pushNewViewController:objviewController];
    


}

- (IBAction)btn_Cust_ChnagePassAction:(id)sender {
   ChnagepasswordViewController  *objviewController =(ChnagepasswordViewController *) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"ChnagepasswordViewController"];
    
    
    [APPDATA pushNewViewController:objviewController];
    
    
}

- (IBAction)btn_Cust_ProfileAction:(id)sender {

    if([objappShareManager.CarrierProfileViewShowID isEqualToString:@"1"])
    {
        
        Profile_ViewController  *objviewController =(Profile_ViewController *) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"Profile_ViewController"];
        
        
        [APPDATA pushNewViewController:objviewController];
    }
    else
    {
        
        RegistrationCustomerViewController  *objviewController =(RegistrationCustomerViewController *) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"RegistrationCustomerViewController"];
        
        
        [APPDATA pushNewViewController:objviewController];
        
    }
   
    
    
}

- (IBAction)btn_Cust_homeAction:(id)sender
{
    Shipment_Category_ViewController *objviewController =(Shipment_Category_ViewController *) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"Shipment_Category_ViewController"];
    
    
    [APPDATA pushNewViewController:objviewController];

}

- (IBAction)btn_Cust_messageAction:(id)sender {
    
    Message_ViewController *objviewController =(Message_ViewController *) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"Message_ViewController"];
    [APPDATA pushNewViewController:objviewController];
}



- (IBAction)btn_Cust_SignOutAction:(id)sender {
    
    
    [self clearData];
    [self ws_logout];
    
    ViewController *objviewController =(ViewController *) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"ViewController"];


    [APPDATA pushNewViewController:objviewController];
    
    

}

-(void)ws_logout{
    
    [APPDATA showLoader];
    
    void (^successed)(id responseObject) = ^(id responseObject)
    {
        
        
        [APPDATA hideLoader];

        
    };
    
    void (^failure)(NSError * error) = ^(NSError *error)
    {
        [APPDATA hideLoader];
    };
    
    
    
    NSString *user_id=[NSString stringWithFormat:@"%@",[objappShareManager.loginDic valueForKey:@"user_id"]];
    
    NSDictionary *dict = @{@"user_id":user_id};
    
    [ApiCall sendToService:API_LOGOUT andDictionary:dict success:successed failure:failure];
    
    

}





- (IBAction)btn_Carr_NewShipmentAction:(id)sender {
    
    TransporterDetailViewController  *objviewController =(TransporterDetailViewController *) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"TransporterDetailViewController"];
    
    
    [APPDATA pushNewViewController:objviewController];
    
    
    
   
}

- (IBAction)btn_Carr_account:(id)sender {
    
    Profile_ViewController  *objviewController =(Profile_ViewController *) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"Profile_ViewController"];
    
    
    [APPDATA pushNewViewController:objviewController];
    objappShareManager.CarrierProfileViewShowID=[[NSString alloc]init];
    objappShareManager.CarrierProfileViewShowID=[NSString stringWithFormat:@"1"];}

- (IBAction)btn_Carr_NotificationAction:(id)sender {
    
    Message_ViewController  *objviewController =(Message_ViewController *) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"Message_ViewController"];
    
    
    [APPDATA pushNewViewController:objviewController];
    
}

- (IBAction)btn_Carr_AboutusAction:(id)sender
{
    AboutUsVC *objAboutUs =(AboutUsVC *) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"AboutUsVC"];
    
    [APPDATA pushNewViewController:objAboutUs];

}


#pragma mark Carrier signout.......
- (IBAction)btn_Carr_signOutAction:(id)sender


{    [self ws_logout];
     [self clearData];
    ViewController *objviewController =(ViewController *) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"ViewController"];
    [APPDATA pushNewViewController:objviewController];
    
}

- (IBAction)btn_Ref_friendAction:(id)sender {
    
    ReferAFriendViewController *objviewController =(ReferAFriendViewController *) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"ReferAFriendViewController"];
    [APPDATA pushNewViewController:objviewController];
}

- (IBAction)btn_Carr_MyreviewAction:(id)sender {
    
    ViewRatingAndReviewVC *objviewController =(ViewRatingAndReviewVC *) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"ViewRatingAndReviewVC"];
    [APPDATA pushNewViewController:objviewController];
    
    
}

- (IBAction)btn_CarrPaymentHistoryAction:(id)sender {
    
    
    PaymentHistoryVC *objviewController =(PaymentHistoryVC *) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"PaymentHistoryVC"];
    
    
    [APPDATA pushNewViewController:objviewController];

    
}

- (IBAction)btnHelpAction:(id)sender {
    
    
    NewshipmentViewController *objviewController =(NewshipmentViewController *) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"NewshipmentViewController"];
    [APPDATA pushNewViewController:objviewController];
}


-(void)clearData{
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    
    objappShareManager.loginDic=nil;
    
    [prefs setObject:@"" forKey:@"s_first_name"];
    
    
    [prefs setObject:@"" forKey:@"s_last_name"];
    
    [prefs setObject :@"" forKey:@"s_email"];
    
    
    [prefs setObject:@"" forKey:@"s_social_id"];
    
    
    [prefs setObject:@"" forKey:@"s_id"];
    
    [prefs setObject:@"" forKey:@"SocialorRegular"];
    
    
    [prefs setObject:@"" forKey:@"email"];
    [prefs setObject:@""forKey:@"password"];
    [prefs setObject:@"" forKey:@"userType"];
    
    [prefs setObject:@"" forKey:@"SocialorRegular"];
    [prefs setObject:@"" forKey:@"rememberme"];
    
}

- (IBAction)btnPayNowAction:(id)sender {
    
    
    PayMentViewController *controller =(PayMentViewController *) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"PayMentViewController"];
    
    
    [controller.view  setFrame:CGRectMake(controller.view.frame.origin.x, controller.view.frame.origin.y, self.viewPayNow.frame.size.width*.97, controller.view.frame.size.height)];
    
    controller.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    
    [self.view addSubview:controller.view];
    [self addChildViewController:controller];
    [controller didMoveToParentViewController:self];
    
    [controller.viewPayment  setFrame:CGRectMake(controller.viewPayment.frame.origin.x, controller.viewPayment.frame.origin.y, controller.viewPayment.frame.size.width, controller.viewPayment.frame.size.height*.8)];

    [controller.btnCancel  setFrame:CGRectMake(controller.btnCancel.frame.origin.x, controller.btnCancel.frame.origin.y, controller.btnCancel.frame.size.width, controller.btnCancel.frame.size.height*.8)];
    
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

- (IBAction)btn_CarrMyBide:(id)sender
{
    MyBideViewController *objMyBideViewController =(MyBideViewController *) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"MyBideViewController"];
    
    
    [APPDATA pushNewViewController:objMyBideViewController];
}
@end
