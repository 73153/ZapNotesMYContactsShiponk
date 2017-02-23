//
//  AboutUsVC.m
//  ShiponK
//
//  Created by bhavik on 6/7/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import "AboutUsVC.h"
#import "SlideNavigationController.h"

@interface AboutUsVC()<SlideNavigationControllerDelegate>
@end

@implementation AboutUsVC
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
   [super viewDidLoad];
    NSString *fullURL = @"http://216.55.169.45/~shiponk/master/about";
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [_WebViewOut loadRequest:requestObj];
    
    _WebViewOut.scrollView.bounces = NO;
    
       [_btnMenuOut addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleLeftMenu) forControlEvents:UIControlEventTouchUpInside];
    
}
@end
