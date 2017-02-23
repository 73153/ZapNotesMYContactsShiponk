//
//  ForgotPasswordViewController.m
//  ShiponK
//
//  Created by Bhushan on 5/18/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import "ApiCall.h"
#import "ComMehod.h"

@interface ForgotPasswordViewController ()

{
    ComMehod *objComMehod;
}
@end

@implementation ForgotPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    objComMehod = [[ComMehod alloc]init];
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

- (IBAction)btn_sendAction:(id)sender {
    
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,10}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    
    if ([emailTest evaluateWithObject:_txt_emailaddress.text] == NO) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please Enter Valid Email Address." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        
        return;
    }else{
        NSString *rechability = [objComMehod checkNetworkRechability];
        if ([rechability isEqualToString:@"YES"])
        {
            
            [self forgotPassworMethod];
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

-(void)forgotPassworMethod{
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    void (^successed)(id responseObject) = ^(id responseObject)
    {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        NSString *str=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"code"]];
          NSString *msg=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"message"]];
        if ([str isEqualToString:@"1"])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            self.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, .3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                
                [self.view removeFromSuperview];
                
                [self removeFromParentViewController];
                
                [self didMoveToParentViewController:nil];
                
                
            });
            
            
            [UIView animateWithDuration:0.3/1.5 animations:^{
                self.view.transform=CGAffineTransformScale(CGAffineTransformIdentity,.9,0.9);
                
            }completion:^(BOOL finished) {
                [UIView animateWithDuration:0.3/2 animations:^{
                    self.view.transform=CGAffineTransformScale(CGAffineTransformIdentity,0.001,0.001);
                    
                }completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.3/2 animations:^{
                        self.view.transform=CGAffineTransformIdentity;
                        
                        
                    }];
                }];
            }];

            
        }else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        
        
        
    };
    
    void (^failure)(NSError * error) = ^(NSError *error)
    {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    };
    
    
    
    
    NSDictionary *dict = @{@"email":_txt_emailaddress.text,};
    
    [ApiCall sendToService:API_FORGOTPASSWORD andDictionary:dict success:successed failure:failure];
    
    
    
    
}

- (IBAction)btn_cancelAction:(id)sender {
    self.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, .3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        
        [self.view removeFromSuperview];
        
        [self removeFromParentViewController];
        
        [self didMoveToParentViewController:nil];
        
        
    });
    
    
    [UIView animateWithDuration:0.3/1.5 animations:^{
        self.view.transform=CGAffineTransformScale(CGAffineTransformIdentity,.9,0.9);
        
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3/2 animations:^{
            self.view.transform=CGAffineTransformScale(CGAffineTransformIdentity,0.001,0.001);
            
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/2 animations:^{
                self.view.transform=CGAffineTransformIdentity;
                
                
            }];
        }];
    }];
}
@end
