//
//  base_carrier_vc.m
//  Carrier_page_vc
//
//  Created by bhavik on 5/23/16.
//  Copyright © 2016 bhavik@zaptech. All rights reserved.
//

#import "base_carrier_vc.h"
@interface base_carrier_vc ()<UIScrollViewDelegate>


@property (assign) BOOL pageControlUsed;
@property (assign) BOOL rotating;
@property (assign) NSUInteger page;


@end

@implementation base_carrier_vc

@synthesize scrl_view_out;
@synthesize page_control_out;
@synthesize pageControlUsed = _pageControlUsed;
@synthesize page = _page;
@synthesize rotating = _rotating;

#pragma  mark view controller delegate method-----------
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [self.scrl_view_out setPagingEnabled:YES];
    //[self.scrl_view_out setScrollEnabled:YES];
    [self.scrl_view_out setShowsHorizontalScrollIndicator:NO];
    [self.scrl_view_out setShowsVerticalScrollIndicator:NO];
    [self.scrl_view_out setDelegate:self];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(VehicalSetTxt)
                                                 name:@"VehicalSet" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(backPage)
                                                 name:@"backPage" object:nil];
    
    
    for (int i =0; i < [self.childViewControllers count]; i++) {
        [self loadScrollViewWithPage:i];
    }
    
    self.page_control_out.currentPage = 0;
    _page = 0;
    [self.page_control_out setNumberOfPages:[self.childViewControllers count]];
    
    UIViewController *viewController = [self.childViewControllers objectAtIndex:self.page_control_out.currentPage];
    if (viewController.view.superview != nil)
    {
        [viewController viewWillAppear:animated];
    }
    
    self.scrl_view_out.contentSize = CGSizeMake(self.scrl_view_out.frame.size.width * [self.childViewControllers count], scrl_view_out.frame.size.height);
}
-(void)VehicalSetTxt{
    
    //if (_page + 1 > self.page_control_out.numberOfPages) {
        
        CGRect frame = self.scrl_view_out.frame;
        frame.origin.x = frame.size.width * (_page + 1);
        frame.origin.y = 0;
        
        UIViewController *oldViewController = [self.childViewControllers objectAtIndex:_page];
        UIViewController *newViewController = [self.childViewControllers objectAtIndex:_page + 1];
        [oldViewController viewWillDisappear:YES];
        [newViewController viewWillAppear:YES];
        
        [self.scrl_view_out scrollRectToVisible:frame animated:YES];
        
        self.page_control_out.currentPage = _page + 1;
        _pageControlUsed = YES;
    //}

    
}

-(void)backPage
{
    CGRect frame = self.scrl_view_out.frame;
    frame.origin.x = frame.size.width * (_page - 1);
    frame.origin.y = 0;
    
    UIViewController *oldViewController = [self.childViewControllers objectAtIndex:_page];
    UIViewController *newViewController = [self.childViewControllers objectAtIndex:_page - 1];
    [oldViewController viewWillDisappear:YES];
    [newViewController viewWillAppear:YES];
    
    [self.scrl_view_out scrollRectToVisible:frame animated:YES];
    
    self.page_control_out.currentPage = _page - 1;
    _pageControlUsed = YES;
    
    
}

- (BOOL)automaticallyForwardAppearanceAndRotationMethodsToChildViewControllers {
    return NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    UIViewController *viewController = [self.childViewControllers objectAtIndex:self.page_control_out.currentPage];
    [viewController willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    _rotating = YES;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    UIViewController *viewController = [self.childViewControllers objectAtIndex:self.page_control_out.currentPage];
    [viewController willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    self.scrl_view_out.contentSize = CGSizeMake(self.scrl_view_out.frame.size.width * [self.childViewControllers count], scrl_view_out.frame.size.height);
    NSUInteger page = 0;
    for (viewController in self.childViewControllers) {
        CGRect frame = self.scrl_view_out.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        viewController.view.frame = frame;
        page++;
    }
    
    CGRect frame = self.scrl_view_out.frame;
    frame.origin.x = frame.size.width * _page;
    frame.origin.y = 0;
    [self.scrl_view_out scrollRectToVisible:frame animated:NO];
    
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    _rotating = NO;
    UIViewController *viewController = [self.childViewControllers objectAtIndex:self.page_control_out.currentPage];
    [viewController didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}


- (void)loadScrollViewWithPage:(int)page {
    if (page < 0)
        return;
    if (page >= [self.childViewControllers count])
        return;
    
    UIViewController *controller = [self.childViewControllers objectAtIndex:page];
    if (controller == nil) {
        return;
    }
    
    if (controller.view.superview == nil) {
        CGRect frame = self.scrl_view_out.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        controller.view.frame = frame;
        [self.scrl_view_out addSubview:controller.view];
    }
}

- (IBAction)page_control_act:(id)sender
{
    NSInteger page = ((UIPageControl *)sender).currentPage;
    
    // update the scroll view to the appropriate page
    CGRect frame = self.scrl_view_out.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    
    UIViewController *oldViewController = [self.childViewControllers objectAtIndex:_page];
    UIViewController *newViewController = [self.childViewControllers objectAtIndex:self.page_control_out.currentPage];
    [oldViewController viewWillDisappear:YES];
    [newViewController viewWillAppear:YES];
    
    [self.scrl_view_out scrollRectToVisible:frame animated:YES];
    
    _pageControlUsed = YES;

}

- (void)previousPage  {
    if (_page - 1 > 0) {
        
        CGRect frame = self.scrl_view_out.frame;
        frame.origin.x = frame.size.width * (_page - 1);
        frame.origin.y = 0;
        
        UIViewController *oldViewController = [self.childViewControllers objectAtIndex:_page];
        UIViewController *newViewController = [self.childViewControllers objectAtIndex:_page - 1];
        [oldViewController viewWillDisappear:YES];
        [newViewController viewWillAppear:YES];
        
        [self.scrl_view_out scrollRectToVisible:frame animated:YES];
        
        self.page_control_out.currentPage = _page - 1;
        _pageControlUsed = YES;
    }
}



- (void)nextPage:(id)sender
{
  
    
    if (_page + 1 > self.page_control_out.numberOfPages) {
        
        CGRect frame = self.scrl_view_out.frame;
        frame.origin.x = frame.size.width * (_page + 1);
        frame.origin.y = 0;
        
        UIViewController *oldViewController = [self.childViewControllers objectAtIndex:_page];
        UIViewController *newViewController = [self.childViewControllers objectAtIndex:_page + 1];
        [oldViewController viewWillDisappear:YES];
        [newViewController viewWillAppear:YES];
        
        [self.scrl_view_out scrollRectToVisible:frame animated:YES];
        
        self.page_control_out.currentPage = _page + 1;
        _pageControlUsed = YES;
    }
}



#pragma mark UIScrollViewDelegate methods
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    UIViewController *oldViewController = [self.childViewControllers objectAtIndex:_page];
    UIViewController *newViewController = [self.childViewControllers objectAtIndex:self.page_control_out.currentPage];
    [oldViewController viewDidDisappear:YES];
    [newViewController viewDidAppear:YES];
    
    _page = self.page_control_out.currentPage;
}
- (void)scrollViewDidScroll:(UIScrollView *)sender {
    if (_pageControlUsed || _rotating)
    {
        return;
    }
    
    CGFloat pageWidth = self.scrl_view_out.frame.size.width;
    int page = floor((self.scrl_view_out.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    if (self.page_control_out.currentPage != page) {
        UIViewController *oldViewController = [self.childViewControllers objectAtIndex:self.page_control_out.currentPage];
        [oldViewController viewWillDisappear:YES];
        self.page_control_out.currentPage = page;
        [oldViewController viewDidDisappear:YES];
        _page = page;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _pageControlUsed = NO;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _pageControlUsed = NO;
}



@end
