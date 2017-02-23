//
//  DashbordViewController.m
//  ShiponK
//
//  Created by Bhushan on 5/17/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import "DashbordViewController.h"
#import "ReviewAndRatingTableViewCell.h"
#import "ApplicationData.h"
#import "appShareManager.h"
@interface DashbordViewController ()
{
    appShareManager *objappShareManager;
}
@end

@implementation DashbordViewController
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
    
    self.imgRate.layer.cornerRadius=self.imgRate.frame.size.width/2;
    self.imgRate.clipsToBounds=YES;
    
    nameArry=[[NSMutableArray alloc]init];
    
    [nameArry addObject:@"User Name 1"];
    [nameArry addObject:@"User Name 2"];
    [nameArry addObject:@"User Name 3"];
    [nameArry addObject:@"User Name 4"];
    [nameArry addObject:@"User Name 5"];
    
    
     [menuButton addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleLeftMenu) forControlEvents:UIControlEventTouchUpInside];
    
    
    objappShareManager=[appShareManager sharedManager];
 
    
    // Do any additional setup aft[er loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return nameArry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"Cell";
    
    ReviewAndRatingTableViewCell *cell = (ReviewAndRatingTableViewCell *)[_tbl_Review_And_Rating dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
         cell = [[ReviewAndRatingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.lblUsername.text=[nameArry objectAtIndex:indexPath.row];
    return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}


#pragma mark - SlideNavigationController Methods -

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}
@end
