//
//  ViewController.m
//  ShiponK
//
//  Created by Bhushan on 5/9/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import "ViewController.h"
#import <AVKit/AVKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "RegistrationCustomerViewController.h"
#import "JoinCarrerViewController.h"
#import "SignViewcontrollerViewController.h"
#import "appShareManager.h"
#import "ComMehod.h"
#import "carrier_page1_vc.h"

@interface ViewController ()
{
    BOOL downviewFlageJ;
    BOOL downviewFlageS;
    BOOL downOpenClose;
    NSString *JSFlag;
    appShareManager *objappShareManager;
    UIButton *btnmenu;
    
//   ComMehod *com;
}
@property (nonatomic, retain) MPMoviePlayerController *moviePlayer;
@end

@implementation ViewController
@synthesize lbl_getshiping;
- (void)viewDidLoad
{

    
    
    
       [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    
       [SlideNavigationController sharedInstance].enableSwipeGesture = YES;
    
    
       [btnmenu addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
    
       lbl_getshiping.adjustsFontSizeToFitWidth = YES;
    
       downviewFlageJ=YES;
       downviewFlageS=YES;
       downOpenClose=NO;
    
    
        objappShareManager = [appShareManager sharedManager];
    
//        com=[[ComMehod alloc]init];
//       [com getTransporterCategory];

        [super viewDidLoad];
    
}

- (void) viewDidAppear:(BOOL)animated
{
    
    [self loadVideosToPlayer];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - OLCVideoPlayer Init

- (void) loadVideosToPlayer
{
    
    NSString*thePath=[[NSBundle mainBundle] pathForResource:@"videoMerge" ofType:@"mov"];
    
    NSURL*theurl=[NSURL fileURLWithPath:thePath];
    
    self.moviePlayer=[[MPMoviePlayerController alloc] initWithContentURL:theurl];
    
    [self.moviePlayer.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y,self.view.frame.size.width, self.view.frame.size.height)];
    
    [self.moviePlayer prepareToPlay];
    [self.moviePlayer setShouldAutoplay:YES]; // And other options you can look through the documentation.
    self.moviePlayer.repeatMode = MPMovieRepeatModeOne;
    _moviePlayer.scalingMode = MPMovieScalingModeFill;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:nil];
    
    [self.moviePlayer setControlStyle:MPMovieControlStyleNone];
    
    [self.moviePlayer setFullscreen:YES];
    //[_moviePlayer.view setFrame: self.view.bounds];
    [self.View_bg addSubview:self.moviePlayer.view];

}

- (IBAction)btn_customeMainAction:(id)sender {
    
    if ([JSFlag isEqualToString:@"Join"]) {
        
        [_btn_join setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        
        RegistrationCustomerViewController *objLoginCustomerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RegistrationCustomerViewController"];
        [self.navigationController pushViewController:objLoginCustomerViewController animated:YES];
        
    }else{
        objappShareManager.loginUserFlage=@"1";
        
        
        SignViewcontrollerViewController *objSignViewcontrollerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SignViewcontrollerViewController"];
        [self.navigationController pushViewController:objSignViewcontrollerViewController animated:YES];
        
        [_btn_singin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
   [self PageViewAnimationDown];
    
    downviewFlageJ=YES;
    downviewFlageS=YES;
    
}

- (IBAction)brn_carrierMainAction:(id)sender {
    
    if ([JSFlag isEqualToString:@"Join"]) {
        
        [_btn_join setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        
        
        carrier_page1_vc *objJoinCarrerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"carrier_page1_vc"];
        [self.navigationController pushViewController:objJoinCarrerViewController animated:YES];
        
    }else{
        
        objappShareManager.loginUserFlage=@"2";
        
        
        SignViewcontrollerViewController *objSignViewcontrollerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SignViewcontrollerViewController"];
        [self.navigationController pushViewController:objSignViewcontrollerViewController animated:YES];
        
        [_btn_singin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
    [self PageViewAnimationDown];
    
      downviewFlageJ=YES;
      downviewFlageS=YES;
    
    
    
    
    
}

- (IBAction)btn_joinAction:(id)sender
{
     JSFlag=@"Join";

    objappShareManager.ProfileViewShowID=[[NSString alloc]init];
    
    objappShareManager.ProfileViewShowID=[NSString stringWithFormat:@"0"];

    objappShareManager.CarrierProfileViewShowID=[[NSString alloc]init];
    objappShareManager.CarrierProfileViewShowID=[NSString stringWithFormat:@"0"];
    
     [_btn_singin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    if (downviewFlageJ==YES)
        
    {
         downviewFlageJ=NO;
        
        [self PageViewAnimationUp];
        
        
        [_btn_join setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        
        
    }else{
        
        [_btn_join setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
         downviewFlageJ=YES;
        
         [self PageViewAnimationDown];
    }
    
     downviewFlageS=YES;
    
}
#pragma mark singinBtn action................
- (IBAction)btn_singinAction:(id)sender
{
     JSFlag=@"Signin";
    
    objappShareManager.ProfileViewShowID=[[NSString alloc]init];
    
    objappShareManager.ProfileViewShowID=[NSString stringWithFormat:@"1"];
    objappShareManager.CarrierProfileViewShowID=[[NSString alloc]init];
    objappShareManager.CarrierProfileViewShowID=[NSString stringWithFormat:@"1"];

    
    
    [_btn_join setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    if (downviewFlageS==YES)
    {
        
         downviewFlageS=NO;
        
        [self PageViewAnimationUp];
        
        [_btn_singin setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
      
        
    }else{
        
        [_btn_singin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
         downviewFlageS=YES;
        
         [self PageViewAnimationDown];
    }
   
    
    downviewFlageJ=YES;
    

    
}



#pragma mark status bar change color..........
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
     [_btn_join setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
     downviewFlageJ=YES;
     downviewFlageS=YES;
     [self PageViewAnimationDown];

    
    [_btn_singin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    
}
-(void)PageViewAnimationUp
{
    
    if (downOpenClose==NO)
    {
         downOpenClose=YES;
        _view_down.hidden=NO;
        
   
        
        [UIView animateWithDuration:0.50
                              delay:0.0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             
                             
                             [_view_down setFrame:CGRectMake(_view_down.frame.origin.x, _view_down.frame.origin.y-111,  _view_down.frame.size.width, _view_down.frame.size.height+111)];
                             
                             
                         }
         
                         completion:^(BOOL END){
                             
                         }];
    }
    

    
}


-(void)PageViewAnimationDown
{
    
    if (downOpenClose==YES)
    {
        downOpenClose=NO;

    
    
    [UIView animateWithDuration:0.50
                          delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         
                         
                          [_view_down setFrame:CGRectMake(_view_down.frame.origin.x, _view_down.frame.origin.y+111,  _view_down.frame.size.width, _view_down.frame.size.height-111)];
                         
                         
                     }
     
                     completion:^(BOOL END){
                         _view_down.hidden=YES;
                     }];
    
    
}
}


@end
