//
//  ChnagepasswordViewController.m
//  ShiponK
//
//  Created by Bhushan on 5/31/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import "ChnagepasswordViewController.h"
#import "SlideNavigationController.h"
#import "appShareManager.h"
#import "ApplicationData.h"
@interface ChnagepasswordViewController ()
{
    appShareManager *objappShareManager;
    NSDictionary *parameters;
    NSUserDefaults *prefs;
  
}
@end

@implementation ChnagepasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    objappShareManager = [appShareManager sharedManager];
    
       [_menu_Action addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleLeftMenu) forControlEvents:UIControlEventTouchUpInside];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btn_SubmitAction:(id)sender {

    if([_txt_NewPassword.text length] <7){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please Enter password maximum 8 character." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }else if(![_txt_NewPassword.text isEqualToString:_txt_ConfirmPassword.text]){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Password do not match" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
         NSString *struserID=[NSString stringWithFormat:@"%@",[objappShareManager.loginDic valueForKey:@"user_id"]];
        parameters = @{@"user_id":struserID,@"password":_txt_NewPassword.text,@"confirm_password":_txt_ConfirmPassword.text};
        

        
        @try
        {
            [APPDATA showLoader];
            
            
            
            void (^successed)(id responseObject) = ^(id responseObject)
            {
                
                NSLog(@"%@",responseObject );
                
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:[responseObject valueForKey:@"status"] message:[responseObject valueForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
                
                [alert show];
                
                prefs = [NSUserDefaults standardUserDefaults];
                
                [prefs setObject:_txt_ConfirmPassword.text forKey:@"password"];
                
                [prefs synchronize];
                
                [APPDATA hideLoader];
                
            };
            
            void (^failure)(NSError * error) = ^(NSError *error)
            {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"error" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
                
                [alert show];
               
                    
        
                
                
            };
            
            
            [ApiCall sendToService:API_CHANGE_PASSWORD andDictionary:parameters success:successed failure:failure];
            
        }
        @catch (NSException *exception) {
            [APPDATA hideLoader];
            
        }
        @finally {
            [APPDATA hideLoader];
            
        }

        
    }
}
@end
