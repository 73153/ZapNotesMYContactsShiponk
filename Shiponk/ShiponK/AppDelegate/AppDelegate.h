//
//  AppDelegate.h
//  ShiponK
//
//  Created by Bhushan on 5/9/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Google/SignIn.h>   

@interface AppDelegate : UIResponder <UIApplicationDelegate, GIDSignInDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic)NSString *deviceTokenStr;
@property BOOL isFlagFB;

-(void)socialLogin:(NSDictionary *)dict andSocialType:(NSString *)STstr;
-(void)LoginMainMethod;
@end

