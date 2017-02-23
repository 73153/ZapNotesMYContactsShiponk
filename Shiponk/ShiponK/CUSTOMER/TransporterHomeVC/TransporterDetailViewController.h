//
//  TransporterDetailViewController.h
//  ShiponK
//
//  Created by datt on 17/03/1938 SAKA.
//  Copyright © 1938 SAKA com.zaptechsolution. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "SectionView.h"
@interface TransporterDetailViewController : UIViewController//<SectionView>
@property (weak, nonatomic) IBOutlet UITableView *tblTransporterDetail;
- (IBAction)btnSearchAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *viewSearch;
@property (weak, nonatomic) IBOutlet UIButton *btnMenuOut;
@property (strong, nonatomic) IBOutlet UIView *viewCategorySearch;

- (UIImage *) changeColorForImage:(UIImage *)image toColor:(UIColor*)color;
- (IBAction)btnCategoryClearAction:(id)sender;
- (IBAction)btnCategorySubmitAction:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *tblCategorySelect;

-(void)getTransporterDetail;

@end
