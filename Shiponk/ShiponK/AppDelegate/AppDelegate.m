//
//  AppDelegate.m
//  ShiponK
//
//  Created by Bhushan on 5/9/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "MBProgressHUD.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "appShareManager.h"
#import "ApiCall.h"
#import "DashbordViewController.h"
#import "Constant.h"
#import "LeftMenuViewController.h"
#import "ViewController.h"
#import "ComMehod.h"
#import "ApplicationData.h"
#import "Shipment_Category_ViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "TransporterDetailViewController.h"
#import "AFDropdownNotification.h"
#import "MPNotificationView.h"
#import <Fabric/Fabric.h>
#import <TwitterKit/TwitterKit.h>


@interface AppDelegate ()<AFDropdownNotificationDelegate>
{
    MBProgressHUD *hud;
    appShareManager *objappShareManager;
     NSUserDefaults *prefs;
    UINavigationController *navigationController;
    ComMehod *objComMehod;
    AFDropdownNotification *AFnotification;
}
@end

@implementation AppDelegate
@synthesize deviceTokenStr;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    sleep(3.0);
    
    
    
    
    [GMSServices provideAPIKey:@"AIzaSyAOaS2P05i9MAgfS7qe6IfAa9ydHyGuHwg"];
    
    
    objComMehod=[[ComMehod alloc]init];
    NSString* rechability = [objComMehod checkNetworkRechability];

    objappShareManager = [appShareManager sharedManager];
    prefs = [NSUserDefaults standardUserDefaults];
    
    NSString *SocialorRegularStr = [prefs stringForKey:@"SocialorRegular"];
    
    if ([SocialorRegularStr isEqualToString:@"Social"])
    {
        
        NSString *first_nameStr=[prefs stringForKey:@"s_first_name"];
        NSString *last_nameStr=[prefs stringForKey:@"s_last_name"];
        NSString *emailStr=[prefs stringForKey:@"s_email"];

     
         NSString *idStr=[prefs stringForKey:@"s_id"];
        

        
        NSDictionary *Dict=@{@"first_name":first_nameStr,@"last_name":last_nameStr,@"email":emailStr,@"id":idStr};
        

        if ([rechability isEqualToString:@"YES"])
        {
            
            [self socialLogin:Dict andSocialType:[prefs stringForKey:@"s_type"]];
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
        
        
    }else if([SocialorRegularStr isEqualToString:@"regular"])
    {
        
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

        
    }else
    {
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                            bundle: nil];
    
        
    
    LeftMenuViewController *leftMenu = (LeftMenuViewController*)[mainStoryboard
                                                                    instantiateViewControllerWithIdentifier: @"LeftMenuViewController"];
    
    
    
    ViewController *load= (ViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"ViewController"];
        
      self.window.rootViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"ViewController"];
        
        
    SlideNavigationController *nav=[[SlideNavigationController alloc] initWithRootViewController:load];
    
    [nav setNavigationBarHidden:YES];
    

    [SlideNavigationController sharedInstance].portraitSlideOffset=90;

    
    [SlideNavigationController sharedInstance].leftMenu = leftMenu;
    
    [SlideNavigationController sharedInstance].menuRevealAnimationDuration = .18;
    
    // Creating a custom bar button for lift menu
    UIButton *button  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    
    [button setImage:[UIImage imageNamed:@"gear"] forState:UIControlStateNormal];
    
    [button addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleLeftMenu) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [SlideNavigationController sharedInstance].leftBarButtonItem = rightBarButtonItem;
    
    
    self.window.rootViewController = nav;

        
    }
    
    
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    
    [FBSDKLoginButton class];
    
    
    
    [objComMehod getVehicleTypeMethod];
    [objComMehod getBusineTypeMethod];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
        // use registerUserNotificationSettings
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [application registerForRemoteNotifications];
    } else {
        // use registerForRemoteNotifications
        [application registerForRemoteNotificationTypes:
         (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    }
#else
    // use registerForRemoteNotifications
    [application registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    
#endif
   
    [application setApplicationIconBadgeNumber:0];
    
     //Twitter Login
    [Fabric with:@[[Twitter class]]];

    
    //Google Login
    NSError* configureError;
    [[GGLContext sharedInstance] configureWithError: &configureError];
    NSAssert(!configureError, @"Error configuring Google services: %@", configureError);
    
    [GIDSignIn sharedInstance].delegate = self;

    
    
//    NSDictionary *notification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}



- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [FBSDKAppEvents activateApp];
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    if (_isFlagFB == true) {
        BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
                                                                      openURL:url
                                                            sourceApplication:sourceApplication
                                                                   annotation:annotation
                        ];
        // Add any custom logic here.
        return handled;
    }
    else{
        return [[GIDSignIn sharedInstance] handleURL:url
                                   sourceApplication:sourceApplication
                                          annotation:annotation];
    }
    
   
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    
    [application registerForRemoteNotifications];
}

//----------------------------- -------------------------------------------

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
 objappShareManager.device_tokenApp = [[[[deviceToken description]
                                  stringByReplacingOccurrencesOfString: @"<" withString: @""]
                                 stringByReplacingOccurrencesOfString: @">" withString: @""]
                                 stringByReplacingOccurrencesOfString: @" " withString: @""];
    
    
   
    
    
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)notification fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler
{
    NSDictionary *dict=[notification valueForKey:@"aps"];
    
    NSString *Msg=[NSString stringWithFormat:@"%@",[dict valueForKey:@"alert"]];
    
    [MPNotificationView notifyWithText:@"ShiponK"
                                detail:Msg
                                 image:[UIImage imageNamed:@"Icon-Spotlight.png"]
                           andDuration:5.0];

    
    UIApplicationState state = [[UIApplication sharedApplication] applicationState];
    if (state == UIApplicationStateActive) {
        // do stuff when app is active
        
    }else{
        // do stuff when app is in background
        [UIApplication sharedApplication].applicationIconBadgeNumber =
        [UIApplication sharedApplication].applicationIconBadgeNumber+1;
        /* to increment icon badge number */
    }
}


-(void)LoginMainMethod{
    
    NSString *emaiStr = [prefs stringForKey:@"email"];
    NSString *password =[prefs stringForKey:@"password"];
    
    UIWindow *windowForHud = [[UIApplication sharedApplication] delegate].window;
    
    [MBProgressHUD showHUDAddedTo:windowForHud animated:YES];
    
    
    void (^successed)(id responseObject) = ^(id responseObject)
    {
        
        [APPDATA hideLoader];
        
        
        NSString *codeStr=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"code"]];
        NSString *meg=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"message"]];
        
        
        if ([codeStr isEqualToString:@"1"])
        {
            
            
             [MBProgressHUD hideHUDForView:windowForHud animated:YES];
            objappShareManager.loginDic=nil;
            
            objappShareManager.loginDic=[responseObject objectForKey:@"data"];
            
            
            objappShareManager.L_FNameStr=[[NSString stringWithFormat:@"%@ %@",[objappShareManager.loginDic valueForKey:@"first_name"],[objappShareManager.loginDic valueForKey:@"last_name"]] uppercaseString];
            objappShareManager.L_P_FStr=[NSString stringWithFormat:@"%@",[objappShareManager.loginDic valueForKey:@"profile_picture"]];
            
            
            NSDictionary *Dict=[responseObject objectForKey:@"data"];
            
            
            NSString *strFlage=[NSString stringWithFormat:@"%@",[Dict objectForKey:@"user_type"]];
            
            NSString *struserid = [NSString stringWithFormat:@"%@",[[objappShareManager.loginDic valueForKey:@"data"]valueForKey:@"user_id"]];
            
            objappShareManager.user_id = [NSString stringWithFormat:@"%@", struserid];
            
            objappShareManager.loginUserFlage=[NSString stringWithFormat:@"%@",strFlage];
            
            
            
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"SlideNavigationControllerDidOpen"
             object:nil];
            
            
                
                 prefs = [NSUserDefaults standardUserDefaults];
                [prefs setObject:emaiStr forKey:@"email"];
                [prefs setObject:password forKey:@"password"];
                [prefs setObject:strFlage forKey:@"userType"];
                
                [prefs setObject:@"regular" forKey:@"SocialorRegular"];
                
                [prefs synchronize];
                
                
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                                     bundle: nil];
     
            
            
            if([strFlage isEqualToString:@"2"])
            {
                
                [APPDATA hideLoader];
                
                TransporterDetailViewController *objTransporterDetailViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"TransporterDetailViewController"];
                

             self.window.rootViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"TransporterDetailViewController"];
                
                
                LeftMenuViewController *leftMenu = (LeftMenuViewController*)[mainStoryboard
                                                                             instantiateViewControllerWithIdentifier: @"LeftMenuViewController"];
                
                

                
                SlideNavigationController *nav=[[SlideNavigationController alloc] initWithRootViewController:objTransporterDetailViewController];
                
                [nav setNavigationBarHidden:YES];
                
                
                [SlideNavigationController sharedInstance].portraitSlideOffset=90;
                
                
                [SlideNavigationController sharedInstance].leftMenu = leftMenu;
                
                [SlideNavigationController sharedInstance].menuRevealAnimationDuration = .18;
                
                // Creating a custom bar button for lift menu
                UIButton *button  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
                
                [button setImage:[UIImage imageNamed:@"gear"] forState:UIControlStateNormal];
                
                [button addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleLeftMenu) forControlEvents:UIControlEventTouchUpInside];
                
                UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
                [SlideNavigationController sharedInstance].leftBarButtonItem = rightBarButtonItem;
                
                
                self.window.rootViewController = nav;

                
                
                
                
            }else{
                [MBProgressHUD hideHUDForView:windowForHud animated:YES];
                
                
                Shipment_Category_ViewController *objDashbordViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"Shipment_Category_ViewController"];
                
                
                
                             self.window.rootViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"Shipment_Category_ViewController"];
                
                
                
                LeftMenuViewController *leftMenu = (LeftMenuViewController*)[mainStoryboard
                                                                             instantiateViewControllerWithIdentifier: @"LeftMenuViewController"];
                
                
                
                
                SlideNavigationController *nav=[[SlideNavigationController alloc] initWithRootViewController:objDashbordViewController];
                
                [nav setNavigationBarHidden:YES];
                
                
                [SlideNavigationController sharedInstance].portraitSlideOffset=90;
                
                
                [SlideNavigationController sharedInstance].leftMenu = leftMenu;
                
                [SlideNavigationController sharedInstance].menuRevealAnimationDuration = .18;
                
                // Creating a custom bar button for lift menu
                UIButton *button  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
                
                [button setImage:[UIImage imageNamed:@"gear"] forState:UIControlStateNormal];
                
                [button addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleLeftMenu) forControlEvents:UIControlEventTouchUpInside];
                
                UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
                [SlideNavigationController sharedInstance].leftBarButtonItem = rightBarButtonItem;
                
                
                self.window.rootViewController = nav;            }
            
        }
        else
        {
             [MBProgressHUD hideHUDForView:windowForHud animated:YES];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:meg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        
        
        
        
        
        
        
    };
    
    void (^failure)(NSError * error) = ^(NSError *error)
    {
         [MBProgressHUD hideHUDForView:windowForHud animated:YES];
        
        [self LoginMainMethod];
        
    };
    
    
    
    if ([objappShareManager.device_tokenApp length]<1)
    {
       objappShareManager.device_tokenApp=@"12345678";
    }
    
    NSDictionary *dict = @{@"email":emaiStr,@"password":password,@"device_token":objappShareManager.device_tokenApp,@"device_type":@"1"};
    
    [ApiCall sendToService:API_LOG_IN andDictionary:dict success:successed failure:failure];
    
}


-(void)socialLogin:(NSDictionary *)dict andSocialType:(NSString *)STstr{
    
    
     UIWindow *windowForHud = [[UIApplication sharedApplication] delegate].window;
    
     [MBProgressHUD showHUDAddedTo:windowForHud animated:YES];
    
    if ([objappShareManager.device_tokenApp length]<1)
    {
        objappShareManager.device_tokenApp=@"123456";
    }
    
    NSDictionary *dic;
    
    if ([[NSString stringWithFormat:@"Facebook"] isEqualToString:STstr]) {
        dic = @{@"first_name":[dict valueForKey:@"first_name"],@"last_name":[dict valueForKey:@"last_name"],@"email":[dict valueForKey:@"email"],@"social_id":[dict valueForKey:@"id"],@"social_type":@"Facebook",@"device_token":objappShareManager.device_tokenApp};
    }
    else if([[NSString stringWithFormat:@"Twitter"] isEqualToString:STstr])
    {
        
        
        dic = @{@"first_name":[dict valueForKey:@"first_name"],@"last_name":[dict valueForKey:@"last_name"],@"email":@"",@"social_id":[dict valueForKey:@"id"],@"social_type":@"Twitter",@"device_token":objappShareManager.device_tokenApp};
    }
    else if ([[NSString stringWithFormat:@"GPlus"] isEqualToString:STstr])
    {
        dic = @{@"first_name":[dict valueForKey:@"first_name"],@"last_name":[dict valueForKey:@"last_name"],@"email":[dict valueForKey:@"email"],@"social_id":[dict valueForKey:@"id"],@"social_type":@"GPlus",@"device_token":objappShareManager.device_tokenApp};
    }
//    else
//    {
//         dic = @{@"first_name":[dict valueForKey:@"first_name"],@"last_name":[dict valueForKey:@"last_name"],@"email":[dict valueForKey:@"email"],@"social_id":[dict valueForKey:@"id"],@"social_type":@"Facebook",@"device_token":objappShareManager.device_tokenApp};
//    }
    

    
    void (^successed)(id responseObject) = ^(id responseObject)
    {
        
         [MBProgressHUD hideHUDForView:windowForHud animated:YES];
        
        
         objappShareManager = [appShareManager sharedManager];
        
         NSString *codeStr=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"code"]];
         NSString *meg=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"message"]];
        
        
        

        
        
        if ([codeStr isEqualToString:@"1"])
        {
            
            
            objappShareManager.loginDic=nil;
            
            objappShareManager.loginDic=[responseObject objectForKey:@"data"];
            
            
            objappShareManager.L_FNameStr=[[NSString stringWithFormat:@"%@ %@",[objappShareManager.loginDic valueForKey:@"first_name"],[objappShareManager.loginDic valueForKey:@"last_name"]] uppercaseString];
            objappShareManager.L_P_FStr=[NSString stringWithFormat:@"%@",[objappShareManager.loginDic valueForKey:@"profile_picture"]];
            NSDictionary *Dict=[responseObject objectForKey:@"data"];
            
            
            NSString *strFlage=[NSString stringWithFormat:@"%@",[Dict objectForKey:@"user_type"]];
            
            objappShareManager.loginUserFlage=[NSString stringWithFormat:@"%@",strFlage];
            
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                                     bundle: nil];
            
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"SlideNavigationControllerDidOpen"
             object:nil];

            
          
            [APPDATA hideLoader];
            
            
            
            NSString *SocialorRegularStr = [prefs stringForKey:@"SocialorRegular"];

            
            Shipment_Category_ViewController *objDashbordViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"Shipment_Category_ViewController"];
            
            if ([SocialorRegularStr length]<1)
            {
                [APPDATA pushNewViewController:objDashbordViewController];
            }else
            {
                UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                                         bundle: nil];
                
                
                LeftMenuViewController *leftMenu = (LeftMenuViewController*)[mainStoryboard
                                                                             instantiateViewControllerWithIdentifier: @"LeftMenuViewController"];
                
                SlideNavigationController *nav=[[SlideNavigationController alloc] initWithRootViewController:objDashbordViewController];
                
                [nav setNavigationBarHidden:YES];
                
                
                [SlideNavigationController sharedInstance].portraitSlideOffset=90;
                
                
                [SlideNavigationController sharedInstance].leftMenu = leftMenu;
                
                [SlideNavigationController sharedInstance].menuRevealAnimationDuration = .18;
                
                // Creating a custom bar button for lift menu
                UIButton *button  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
                
                [button setImage:[UIImage imageNamed:@"gear"] forState:UIControlStateNormal];
                
                [button addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleLeftMenu) forControlEvents:UIControlEventTouchUpInside];
                
                UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
                [SlideNavigationController sharedInstance].leftBarButtonItem = rightBarButtonItem;
                
                
                self.window.rootViewController = nav;

            }
                
            
            
        }
        else
        {
            
             [MBProgressHUD hideHUDForView:windowForHud animated:YES];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:meg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        

        
        
        
    };
    
    void (^failure)(NSError * error) = ^(NSError *error)
    {
          [MBProgressHUD hideHUDForView:windowForHud animated:YES];
        
   
        [ApiCall sendToService:API_SOCIAL_LOGIN andDictionary:dic success:successed failure:failure];

    };
    
    
    
    
    [ApiCall sendToService:API_SOCIAL_LOGIN andDictionary:dic success:successed failure:failure];
    
}

#pragma mark - Google API
//- (BOOL)application:(UIApplication *)app
//            openURL:(NSURL *)url
//            options:(NSDictionary *)options {
//    return [[GIDSignIn sharedInstance] handleURL:url
//                               sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
//                                      annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
//}
//- (BOOL)application:(UIApplication *)application
//            openURL:(NSURL *)url
//  sourceApplication:(NSString *)sourceApplication
//         annotation:(id)annotation {
//    return [[GIDSignIn sharedInstance] handleURL:url
//                               sourceApplication:sourceApplication
//                                      annotation:annotation];
//}

- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    // Perform any operations on signed in user here.
    NSString *userId = user.userID;                  // For client-side use only!
    NSString *idToken = user.authentication.idToken; // Safe to send to the server
    NSString *fullName = user.profile.name;
    NSString *givenName = user.profile.givenName;
    NSString *familyName = user.profile.familyName;
    NSString *email = user.profile.email;
    
    if (user) {
    NSMutableDictionary *dictGoogleLoginDetails = [[NSMutableDictionary alloc]initWithObjects:@[userId,givenName,familyName,email] forKeys:@[@"id",@"first_name",@"last_name",@"email"]];
        
        
        [prefs setObject:givenName forKey:@"s_first_name"];
        
        
        [prefs setObject:familyName forKey:@"s_last_name"];
        
        [prefs setObject:email forKey:@"s_email"];

        [prefs setObject:userId forKey:@"s_id"];
        
        [prefs setObject:@"GPlus" forKey:@"s_type"];
        
        [prefs setObject:@"Social" forKey:@"SocialorRegular"];
        
        
        
        [prefs synchronize];
    
    
    NSLog(@"Data:%@",dictGoogleLoginDetails);
    [self socialLogin:dictGoogleLoginDetails andSocialType:@"GPlus"];
    }
}

@end
