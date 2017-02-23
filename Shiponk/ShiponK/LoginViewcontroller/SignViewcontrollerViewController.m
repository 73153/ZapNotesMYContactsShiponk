//
//  SignViewcontrollerViewController.m
//  ShiponK
//
//  Created by Bhushan on 5/13/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import "SignViewcontrollerViewController.h"
#import "ApiCall.h"
#import "MBProgressHUD.h"
#import "Constant.h"
#import "appShareManager.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <TwitterKit/TwitterKit.h>
#import <TwitterCore/TwitterCore.h>
#import <Twitter/Twitter.h>
#import "DashbordViewController.h"
#import "ComMehod.h"
#import "ForgotPasswordViewController.h"
#import "NewshipmentViewController.h"
#import "TransporterDetailViewController.h"
#import "Shipment_Category_ViewController.h"
#import "AFDropdownNotification.h"
#import <Social/Social.h>


@interface SignViewcontrollerViewController ()<AFDropdownNotificationDelegate>
{
    appShareManager *objappShareManager;
    ComMehod* objComMehod;
    NSUserDefaults *prefs;
    AFDropdownNotification *AFnotification;
    TWTRAPIClient *client ;
}
@end

@implementation SignViewcontrollerViewController
@synthesize userTypestr;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.txt_emailaddress setValue:[UIColor lightGrayColor]
                         forKeyPath:@"_placeholderLabel.textColor"];
    [self.txt_password setValue:[UIColor lightGrayColor]
                     forKeyPath:@"_placeholderLabel.textColor"];
    

   
    AFnotification = [[AFDropdownNotification alloc] init];
    AFnotification.notificationDelegate = self;
    
    
    objappShareManager = [appShareManager sharedManager];
    objComMehod=[[ComMehod alloc]init];
    prefs = [NSUserDefaults standardUserDefaults];
    
    if ([objappShareManager.loginUserFlage isEqualToString:@"2"])
    {
        _view_Fbview.hidden=YES;
        
        _view_LoginView.frame=CGRectMake(_view_LoginView.frame.origin.x, _view_LoginView.frame.origin.y-100, _view_LoginView.frame.size.width, _view_LoginView.frame.size.height);
        
        
    }else
    {
        _view_Fbview.hidden=NO;

    }
    
    
    
    
    
    NSString *savedUsername = [prefs stringForKey:@"rememberme"];
    
    
    if ([savedUsername isEqualToString:@"1"])
    {
        [prefs setObject:@"1" forKey:@"rememberme"];
        
        UIImage *selectImage = [UIImage imageNamed:@"check.png"];
        [_btn_rememverme setImage:selectImage forState:UIControlStateNormal];
        
        
    }else
    {
        [prefs setObject:@"0" forKey:@"rememberme"];
        UIImage *unselectImage = [UIImage imageNamed:@"uncheck.png"];
        [_btn_rememverme setImage:unselectImage forState:UIControlStateNormal];
    }
    
    
    
    [SlideNavigationController sharedInstance].enableSwipeGesture = YES;
    
   //Google Login
    [GIDSignIn sharedInstance].uiDelegate = self;
    
   
}




-(void)dropdownNotificationTopButtonTapped {
    
    NSLog(@"Top button tapped");
}

-(void)dropdownNotificationBottomButtonTapped {
    
    NSLog(@"Bottom button tapped");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
    
}



- (IBAction)btn_BackAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btn_fbloginAction:(id)sender {
    
    appDelegate.isFlagFB = true;
    
    NSString *rechability = [objComMehod checkNetworkRechability];
    if ([rechability isEqualToString:@"YES"])
    {
    
        FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
        [login
         logInWithReadPermissions: @[@"public_profile",@"email"]
         fromViewController:self
         handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
             if (error)
             {
                 NSLog(@"Process error");
                 
                 
             } else if (result.isCancelled) {
                 NSLog(@"Cancelled");
             } else {
                 NSLog(@"Logged in");
                 if ([FBSDKAccessToken currentAccessToken]) {
                     [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{ @"fields" : @"id,first_name,last_name,email,name"}]startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                         if (!error) {
                             
                    
                             
                             
                             [prefs setObject:[result valueForKey:@"first_name"] forKey:@"s_first_name"];
                             
                             
                             [prefs setObject:[result valueForKey:@"last_name"] forKey:@"s_last_name"];
                             
                             [prefs setObject:[result valueForKey:@"email"] forKey:@"s_email"];
                             [prefs setObject:@"Facebook" forKey:@"s_type"];
                             
                            // [prefs setObject:[result valueForKey:@"social_id"] forKey:@"s_social_id"];
                             
                             
                             [prefs setObject:[result valueForKey:@"id"] forKey:@"s_id"];
                             
                             [prefs setObject:@"Social" forKey:@"SocialorRegular"];
                             
                             
                             
                             [prefs synchronize];
                             
                             [appDelegate socialLogin:result andSocialType:@"Facebook"];
                         }
                     }];
                 }
             }
         }];

        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Disconnected"
                                                        message:@"Internet Connection Failed"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Ok",nil];
        [alert show];
        
    }

}

- (IBAction)btn_signinAction:(id)sender {
    
    
    NSString *eSpastr=[objComMehod spacecheck:_txt_emailaddress.text];
   
    
    
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,10}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    
    if ([emailTest evaluateWithObject:_txt_emailaddress.text] == NO) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please Enter Valid Email Address." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        
        return;
    }else if ([_txt_password.text length]<5)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please Enter password maximum 6 character." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else if([eSpastr isEqualToString:@"0"]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please Enter Email Address." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    }
    else
    {
        NSString *rechability = [objComMehod checkNetworkRechability];
        if ([rechability isEqualToString:@"YES"])
        {
            
            [self LoginMainMethod];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Disconnected"
                                                            message:@"Internet Connection Failed"
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Ok",nil];
            [alert show];
            
        }
        

    }
    
    
    
}


-(void)LoginMainMethod
{
    
    [APPDATA showLoader];
    
    void (^successed)(id responseObject) = ^(id responseObject)
    {
        
        [APPDATA hideLoader];
        
        NSString *codeStr=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"code"]];
        NSString *meg=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"message"]];
       
        NSString *strRemainingAmt = [NSString stringWithFormat:@"%@",[[responseObject valueForKey:@"data"] valueForKey:@"due_amount"]];
        [objappShareManager.loginDic setValue:strRemainingAmt forKey:@"DueAmount"];
        NSString *strTimeRemaining = [NSString stringWithFormat:@"%@",[[responseObject valueForKey:@"data"] valueForKey:@"time_remaining"]];
        [objappShareManager.loginDic setValue:strTimeRemaining forKey:@"TimeRemaining"];
        
        
        if ([codeStr isEqualToString:@"1"])
        {
            
            objappShareManager.loginDic=nil;
            
            objappShareManager.loginDic=[responseObject objectForKey:@"data"];
            
            NSDictionary *Dict=[responseObject objectForKey:@"data"];
            
            NSString *strFlage=[NSString stringWithFormat:@"%@",[Dict objectForKey:@"user_type"]];
            
            
            objappShareManager.loginUserFlage=[NSString stringWithFormat:@"%@",strFlage];
            
            
             objappShareManager.L_FNameStr=[[NSString stringWithFormat:@"%@ %@",[objappShareManager.loginDic valueForKey:@"first_name"],[objappShareManager.loginDic valueForKey:@"last_name"]] uppercaseString];
             objappShareManager.L_P_FStr=[NSString stringWithFormat:@"%@",[objappShareManager.loginDic valueForKey:@"profile_picture"]];
            
            
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"SlideNavigationControllerDidOpen"
             object:nil];
            
            NSString *savedUsername = [prefs stringForKey:@"rememberme"];
            
            
            if ([savedUsername isEqualToString:@"1"])
            {
                
               
                [prefs setObject:_txt_emailaddress.text forKey:@"email"];
                 [prefs setObject:_txt_password.text forKey:@"password"];
                [prefs setObject:strFlage forKey:@"userType"];
                
                [prefs setObject:@"regular" forKey:@"SocialorRegular"];
                
               

                
            }

             [prefs setObject:_txt_password.text forKey:@"password"];
             [prefs synchronize];
                        
            if([strFlage isEqualToString:@"2"])
            {
                
                [APPDATA hideLoader];
                
                TransporterDetailViewController *objTransporterDetailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TransporterDetailViewController"];
                [APPDATA pushNewViewController:objTransporterDetailViewController];
                
                
                
            }else{
                [APPDATA hideLoader];
                
                
                Shipment_Category_ViewController *objDashbordViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Shipment_Category_ViewController"];
                [APPDATA pushNewViewController:objDashbordViewController];
            }

        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:meg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }

        
        
        
        
        
        
    };
    
    void (^failure)(NSError * error) = ^(NSError *error)
    {
        [APPDATA hideLoader];
    };
    
     
    if ([objappShareManager.device_tokenApp length]<1)
    {
        objappShareManager.device_tokenApp=@"12345678";
    }
    
    
    NSDictionary *dict = @{@"email":_txt_emailaddress.text,@"password":_txt_password.text,@"device_token":objappShareManager.device_tokenApp,@"device_type":@"1"};
     
    [ApiCall sendToService:API_LOG_IN andDictionary:dict success:successed failure:failure];
    
    
    
     
}

- (IBAction)btn_remembermeAction:(id)sender
{
    NSString *savedUsername = [prefs stringForKey:@"rememberme"];
    
    
    if ([savedUsername isEqualToString:@"0"] || (savedUsername.length<=0))
    {
         [prefs setObject:@"1" forKey:@"rememberme"];
        
        UIImage *selectImage = [UIImage imageNamed:@"check.png"];
        [_btn_rememverme setImage:selectImage forState:UIControlStateNormal];
        
        
        
    }else
    {
          [prefs setObject:@"0" forKey:@"rememberme"];
          UIImage *unselectImage = [UIImage imageNamed:@"uncheck.png"];
          [_btn_rememverme setImage:unselectImage forState:UIControlStateNormal];
    }
    
   
    
    
    [prefs synchronize];
    
}

- (IBAction)btn_forgotPasswordMethod:(id)sender {
    
    ForgotPasswordViewController *controller =(ForgotPasswordViewController *) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"ForgotPasswordViewController"];
    
    
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
  //  [controller.view setFrame:CGRectMake(0,0,controller.view.frame.size.width,self.view.frame.size.height)];
}

- (IBAction)btn_TwitterLoginAction:(id)sender {

    TWTRLogInButton* logInButton = [TWTRLogInButton buttonWithLogInCompletion:^(TWTRSession* session, NSError* error) {
    
    }];
    logInButton.loginMethods = TWTRLoginMethodWebBased;
    
    // If using the log in methods on the Twitter instance
    [[Twitter sharedInstance] logInWithMethods:TWTRLoginMethodWebBased completion:^(TWTRSession *session, NSError *error) {
        
        if (session) {
        NSString *message = [NSString stringWithFormat:@"@%@ logged in! (%@)",
                             [session userName], [session userID]];
        TWTRAPIClient *client1 = [TWTRAPIClient clientWithCurrentUser];

        
        NSString *statusesShowEndpoint = @"https://api.twitter.com/1.1/users/show.json";
        NSDictionary *params = @{@"user_id": [session userID]};
        
        NSURLRequest *request = [client1 URLRequestWithMethod:@"GET"
                                                         URL:statusesShowEndpoint
                                                  parameters:params
                                                       error:nil];
            
            NSError *clientError;

        if (request) {
            [client1
             sendTwitterRequest:request
             completion:^(NSURLResponse *response,
                          NSData *data,
                          NSError *connectionError) {
                 if (data) {
                     // handle the response data e.g.
                     NSError *jsonError;
                     NSDictionary *json = [NSJSONSerialization
                                           JSONObjectWithData:data
                                           options:0
                                           error:&jsonError];
                     NSLog(@"%@",[json description]);
                 
                     NSString * str = [NSString stringWithFormat:@"%@",[json valueForKey:@"name"]];
                     NSArray * arr = [str componentsSeparatedByString:@" "];
                     NSLog(@"Array values are : %@",arr);
                     
                     
            
                     
                     [prefs setObject:[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]] forKey:@"s_first_name"];
                     
                     
                     [prefs setObject:[NSString stringWithFormat:@"%@",[arr objectAtIndex:1]] forKey:@"s_last_name"];
                     
                     [prefs setObject:@"" forKey:@"s_email"];
                     
                      [prefs setObject:@"Twitter" forKey:@"s_type"];
                     
                     [prefs setObject:[json valueForKey:@"id"] forKey:@"s_id"];
                     
                     [prefs setObject:@"Social" forKey:@"SocialorRegular"];
                     
                     
                     
                     [prefs synchronize];

                    NSDictionary  *dic = @{@"first_name":[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]],@"last_name":[NSString stringWithFormat:@"%@",[arr objectAtIndex:1]],@"email":@"",@"id":[NSString stringWithFormat:@"%@",[json valueForKey:@"id"]]};
                     
                     [appDelegate socialLogin:dic andSocialType:@"Twitter"];

                 
                 }
                 else {
                     NSLog(@"Error code: %ld | Error description: %@", (long)[connectionError code], [connectionError localizedDescription]);
                 }
             }];
        }
        else {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                                          message:(NSString *)clientError
                                                                                         delegate:nil
                                                                                cancelButtonTitle:@"OK"
                                                                                otherButtonTitles:nil];
                                          [alert show];
//            NSLog(@"Error: %@", clientError);
        }


//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Logged in!"
//                                                        message:message
//                                                       delegate:nil
//                                              cancelButtonTitle:@"OK"
//                                              otherButtonTitles:nil];
//        [alert show];
        }
    }];
    


    }

- (IBAction)btnGooglePressed:(id)sender {
    appDelegate.isFlagFB = false;
      [[GIDSignIn sharedInstance] signIn];
}
@end
