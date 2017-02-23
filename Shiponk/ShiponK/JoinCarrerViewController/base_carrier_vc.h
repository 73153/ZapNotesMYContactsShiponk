//
//  base_carrier_vc.h
//  Carrier_page_vc
//
//  Created by bhavik on 5/23/16.
//  Copyright © 2016 bhavik@zaptech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface base_carrier_vc : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrl_view_out;
@property (weak, nonatomic) IBOutlet UIPageControl *page_control_out;
- (IBAction)page_control_act:(id)sender;

- (void)previousPage;

- (void)loadScrollViewWithPage:(int)page;

- (void)nextPage:(id)sender;

@end
