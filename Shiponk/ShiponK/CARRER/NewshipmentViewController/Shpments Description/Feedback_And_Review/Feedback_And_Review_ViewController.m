//
//  Feedback_And_Review_ViewController.m
//  ShiponK
//
//  Created by krutagn on 13/06/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import "Feedback_And_Review_ViewController.h"
#import "Constant.h"
#import "ComMehod.h"
#import "ApiCall.h"
#import "ApplicationData.h"
#import "appShareManager.h"
#import "Shipment_Description_ViewController.h"

#import "UIImageView+UIActivityIndicatorForSDWebImage.h"


@interface Feedback_And_Review_ViewController ()<UITextViewDelegate>
{
    appShareManager *objappsharemanager;
    NSDictionary *reviewDict,*reviewDictData;

}

@end

@implementation Feedback_And_Review_ViewController
@synthesize star_rating_view,ShipmentidStr1,raDict;

- (void)viewDidLoad {
    [super viewDidLoad];
   
    objappsharemanager = [appShareManager sharedManager];
    
    star_rating_view.canEdit = YES;
    star_rating_view.maxRating = 5;
    star_rating_view.rating = 0;
    
    [_txt_feedBack setValue:[UIColor whiteColor]
                    forKeyPath:@"_placeholderLabel.textColor"];
    _main_view.layer.cornerRadius = 5;
    _main_view.layer.masksToBounds = YES;
    
    
    _lbl_km.text=[NSString stringWithFormat:@"%@ Km",[raDict valueForKey:@"kilometers"]];
    
    _lbl_to.text=[NSString stringWithFormat:@"%@",[raDict valueForKey:@"to_city"]];
    
    _lbl_from.text=[NSString stringWithFormat:@"%@",[raDict valueForKey:@"from_city"]];
    
    _lbl_Rp.text=[NSString stringWithFormat:@"Rp %@",[raDict valueForKey:@"price"]];
    
    [self disPalyData];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(SetStare)
                                                 name:@"SetStare"
                                               object:nil];
    
    
}

-(void)SetStare{
    
   if ( [objappsharemanager.ratingStr isEqualToString:@"2.000000"])
    {
        _lbl_exp.text=@"Average ";
        
    }else if ( [objappsharemanager.ratingStr isEqualToString:@"3.000000"]){
        
         _lbl_exp.text=@"Good ";
        
    }else if ( [objappsharemanager.ratingStr isEqualToString:@"4.000000"]){
        
         _lbl_exp.text=@"Very Good ";
    } else if ( [objappsharemanager.ratingStr isEqualToString:@"5.000000"])
    {
        _lbl_exp.text=@"Excellent ";
        
    }else{
         _lbl_exp.text=@"Poor ";
    }
    
    
}

-(void)disPalyData{
    
    @try
    {
        [APPDATA showLoader];
        
        NSDictionary *dicttt = @{@"user_id":[NSString stringWithFormat:@"%@",[raDict valueForKey:@"accepted_transporter"]]};
        
        void (^successed)(id responseObject) = ^(id responseObject)
        {
            
             [APPDATA hideLoader];
            
            NSString *proUrl=[NSString stringWithFormat:@"%@",[responseObject valueForKey:@"profile_pic_url"]];
            
            NSDictionary *dict=[responseObject valueForKey:@"data"];
            
            
                  NSCharacterSet *charsToTrim = [NSCharacterSet characterSetWithCharactersInString:@"< > null()  \n\""];
            
            NSString *FName=[NSString stringWithFormat:@"%@",[dict valueForKey:@"first_name"]];
             FName = [FName stringByTrimmingCharactersInSet:charsToTrim];
            
            NSString *lName=[NSString stringWithFormat:@"%@",[dict valueForKey:@"last_name"]];
              lName = [lName stringByTrimmingCharactersInSet:charsToTrim];
            
            _lbl_Name.text=[NSString stringWithFormat:@"%@ %@",FName,lName];
            
            NSString *imgstr=[NSString stringWithFormat:@"%@",[dict valueForKey:@"profile_picture"]];
            
             imgstr = [imgstr stringByTrimmingCharactersInSet:charsToTrim];
            
            if ([imgstr length]<1)
            {
                [_image_view setImage:[UIImage imageNamed:@"CollCellStaticImg"]];
                
            }else{
                NSString *img=[NSString stringWithFormat:@"%@%@",proUrl,imgstr];
            
                
                _image_view.layer.cornerRadius=_image_view.frame.size.width/2.0;
                _image_view.layer.masksToBounds=YES;
                _image_view.clipsToBounds=YES;
                
                [_image_view setImageWithURL:[NSURL URLWithString:img] placeholderImage:[UIImage imageNamed:@"myImage.jpg"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            }
            
        };
        
        void (^failure)(NSError * error) = ^(NSError *error)
        {
            [self disPalyData];
             [APPDATA hideLoader];
        };
        
        
        [ApiCall sendToService:API_USER_PROFILE andDictionary:dicttt success:successed failure:failure];
    }
    @catch (NSException *exception) {
        [APPDATA hideLoader];
        
    }
    @finally {
        [APPDATA hideLoader];
        
    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


- (IBAction)btn_submit:(id)sender {
    
    
     if(star_rating_view.rating == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please give a star." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        
        if ([_txt_feedBack.text isEqualToString:@""])
        {
            
            _txt_feedBack.text=_lbl_exp.text;
        }
        
        [self Feedback_And_Review];
    }

}

- (IBAction)btn_skip:(id)sender {
    
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

-(void)Feedback_And_Review
{
    [APPDATA showLoader];
    void (^successed)(id responseObject) = ^(id responseObject)
    {
        [APPDATA hideLoader];
     
        reviewDict = [responseObject valueForKey:@"data"];


        _imgLike.hidden=NO;
        _lblThanks.hidden=NO;
        _imgLike.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1,0.1);
        [UIView animateWithDuration:0.5 animations:^{
            
            _imgLike.transform = CGAffineTransformIdentity;
            
        }];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            
            
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
        });
        
        
    };
    
    void (^failure)(NSError * error) = ^(NSError *error)
    {
        [APPDATA hideLoader];
        
    };
    
    
    NSString *useridStr=[NSString stringWithFormat:@"%@",[objappsharemanager.loginDic valueForKey:@"user_id"]];
    
    
    
    NSDictionary *dict = @{@"votes":objappsharemanager.ratingStr,@"customer_id":useridStr,@"shipmentid":[raDict valueForKey:@"shipment_id"],@"description":_txt_feedBack.text,@"carrier_id":objappsharemanager.carrieridStr};
    
    [ApiCall sendToService:API_ADD_RATING andDictionary:dict success:successed failure:failure];
    
    self.txt_feedBack.text=nil;
    objappsharemanager.ratingStr=nil;
   
}

//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    self.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, .3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//        
//        [self.view removeFromSuperview];
//        
//        [self removeFromParentViewController];
//        
//        [self didMoveToParentViewController:nil];
//        
//        
//    });
//    
//    
//    [UIView animateWithDuration:0.3/1.5 animations:^{
//        self.view.transform=CGAffineTransformScale(CGAffineTransformIdentity,.9,0.9);
//        
//    }completion:^(BOOL finished) {
//        [UIView animateWithDuration:0.3/2 animations:^{
//            self.view.transform=CGAffineTransformScale(CGAffineTransformIdentity,0.001,0.001);
//            
//        }completion:^(BOOL finished) {
//            [UIView animateWithDuration:0.3/2 animations:^{
//                self.view.transform=CGAffineTransformIdentity;
//                
//                
//            }];
//        }];
//    }];
//    
//}

@end
