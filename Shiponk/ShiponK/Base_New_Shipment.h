//
//  New_Shipment_vc.h
//  ShiponK_new_shipment
//
//  Created by bhavik on 5/19/16.
//  Copyright © 2016 bhavik@zaptech. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Base_New_Shipment : UIViewController<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrl_view_out;
@property (weak, nonatomic) IBOutlet UIPageControl *page_control_out;

- (IBAction)changePage:(id)sender;
- (void)previousPage;
- (void)nextPage;

@end
