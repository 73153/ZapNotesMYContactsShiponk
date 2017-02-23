//
//  ViewBranchViewController.m
//  ShiponK
//
//  Created by Bhushan on 6/29/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import "ViewBranchViewController.h"
#import "ViewBranchTableViewCell.h"
#import "appShareManager.h"

@interface ViewBranchViewController ()
{
    appShareManager *objGlobal;
}
@end

@implementation ViewBranchViewController
@synthesize tblViewBranch;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    objGlobal = [appShareManager sharedManager];
    if ([objGlobal.CarrierProfileViewShowID isEqualToString:@"1"]) {
        
    }
    else
    {
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [tblViewBranch reloadData];
}

#pragma mark - UItableView Delegate Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [objGlobal.arrAddBranch count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

{
    @try
    {
        
        static NSString *CellIdentifier = @"ViewBranchTableViewCell";
        
        ViewBranchTableViewCell *cell = [self.tblViewBranch dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        if (cell == nil)
        {
            cell = [[ViewBranchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            
        }
        
       
        cell.lblTotalAmount.text = [[objGlobal.arrAddBranch objectAtIndex:indexPath.row] valueForKey:@"address"];
        cell.lblCity.text = [[objGlobal.arrAddBranch objectAtIndex:indexPath.row] valueForKey:@"city"];
      //  cell.lblMobileNo.text = [[objGlobal.arrAddBranch objectAtIndex:indexPath.row] valueForKey:@"MobileNo"];
        cell.lblZipcode.text = [[objGlobal.arrAddBranch objectAtIndex:indexPath.row] valueForKey:@"zipcode"];
        
        
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        return cell;
        
    } @catch (NSException *exception) {
        NSLog(@"Exception At: %s %d %s %s %@", __FILE__, __LINE__, __PRETTY_FUNCTION__, __FUNCTION__,exception);
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //remove the deleted object from your data source.
        //If your data source is an NSMutableArray, do this
        [objGlobal.arrAddBranch removeObjectAtIndex:indexPath.row];
        [tblViewBranch reloadData]; // tell table to refresh now
    }
}
- (IBAction)btnCloseAction:(id)sender {
    
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
