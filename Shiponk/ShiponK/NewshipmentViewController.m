//
//  NewshipmentViewController.m
//  ShiponK
//
//  Created by Bhushan on 5/19/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import "NewshipmentViewController.h"
#import "Constant.h"
#import "SlideNavigationController.h"
#import "appShareManager.h"
@interface NewshipmentViewController ()<SlideNavigationControllerDelegate>{
        appShareManager *objappShareManager;
}

@end

@implementation NewshipmentViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"HelpPage1ViewController"]];
    [self addChildViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"HelpPage2ViewController"]];
    [self addChildViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"HelpPage3ViewController"]];
   // [self addChildViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"New_shipment_page4"]];
    // Do any additional setup after loading the view.
    
     [_menuButton addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleLeftMenu) forControlEvents:UIControlEventTouchUpInside];
//    
//    objappShareManager = [appShareManager sharedManager];
//    
//    objappShareManager.ProfileViewShowID=[[NSString alloc]init];
//    
//    objappShareManager.ProfileViewShowID=[NSString stringWithFormat:@"1"];
//
//    objappShareManager.CarrierProfileViewShowID=[NSString stringWithFormat:@"0"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
