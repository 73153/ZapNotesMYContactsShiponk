//
//  order_history_ViewController.m
//  ShiponK
//
//  Created by dharmesh on 5/27/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import "order_history_ViewController.h"
#import "Order_history_TableViewCell.h"
#import "SlideNavigationController.h"
#import "Shipment_Description_ViewController.h"

@interface order_history_ViewController ()

@end

@implementation order_history_ViewController
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
    
    nameArr=[[NSMutableArray alloc]init];
    
    [nameArr addObject:@"Shipment Title1"];
    [nameArr addObject:@"Shipment Title2"];
    [nameArr addObject:@"Shipment Title3"];
    [nameArr addObject:@"Shipment Title4"];
    [nameArr addObject:@"Shipment Title5"];
    self.tbl_order_history.delegate=self;
    self.tbl_order_history.dataSource=self;
//    
//    [_menuButton addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleLeftMenu) forControlEvents:UIControlEventTouchUpInside];
//
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return nameArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"Cell";
    
        Order_history_TableViewCell *cell = (Order_history_TableViewCell *)[_tbl_order_history dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil)
        {
            cell = [[Order_history_TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        }
        cell.lbl_ship_title.text=[nameArr objectAtIndex:indexPath.row];
        return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    Shipment_Description_ViewController *objviewController =(Shipment_Description_ViewController *) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"Shipment_Description_ViewController"];
    
    [[self navigationController]pushViewController:objviewController animated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - SlideNavigationController Methods -

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

- (IBAction)btn_back_act:(id)sender
{
    [[self navigationController]popViewControllerAnimated:YES];
}
@end
