//
//  Setting_carrier_ViewController.m
//  CustomTableView
//
//  Created by dharmesh on 6/9/16.
//  Copyright © 2016 shivani. All rights reserved.
//

#import "Setting_carrier_ViewController.h"
#import "SlideNavigationController.h"


@interface Setting_carrier_ViewController ()<SlideNavigationControllerDelegate>
{
    NSArray *array1,*array2,*array3,*array4;
}
@end

@implementation Setting_carrier_ViewController
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
    
    _tblView.delegate=self;
    _tblView.dataSource=self;
    array1=[[NSArray alloc]initWithObjects:@"Notification Settings",@"Location",@"Currency",@"Facebook", nil];
    array2=[[NSArray alloc]initWithObjects:@"User Agreement",@"Privacy Policy", nil];
    array3=[[NSArray alloc]initWithObjects:@"Help Center",@"Email", nil];
    array4=[[NSArray alloc]initWithObjects:@"SignOut", nil];
    
    
    
    [_menuButton addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleLeftMenu) forControlEvents:UIControlEventTouchUpInside];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return array1.count;
    }
    else if(section == 1)
    {
        return array2.count;
    }
    else if (section == 2)
    {
        return array3.count;
    }
    else
    {
        return array4.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"cellID";
    
    
    
    UITableViewCell *cell = [_tblView dequeueReusableCellWithIdentifier:
                             cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:
                UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSString *stringForCell;
    
    
    if (indexPath.section == 0)
    {
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        stringForCell= [array1 objectAtIndex:indexPath.row];
        
        
        
        
        if (indexPath.row == 2) {
            
            CGRect frame = CGRectMake(260, 14, 100, 20);
            UILabel *currency = [[UILabel alloc]initWithFrame:frame];
            currency.textColor = [UIColor grayColor];
            currency.text = @"Indian Rupee";
            currency.font = [UIFont fontWithName:@"Helvetica" size:9];
            [cell.contentView addSubview:currency];
            
            [currency setAutoresizingMask:UIViewAutoresizingFlexibleRightMargin |
             UIViewAutoresizingFlexibleLeftMargin |
             UIViewAutoresizingFlexibleBottomMargin];
            
            
            [currency sizeToFit];
            
        }
        else if(indexPath.row == 3)
        {
            CGRect frame = CGRectMake(260, 14, 100, 20);
            UILabel *currency = [[UILabel alloc]initWithFrame:frame];
            currency.textColor = [UIColor grayColor];
            currency.text = @"Not Connected";
            currency.font = [UIFont fontWithName:@"Helvetica" size:9];
            [cell.contentView addSubview:currency];
            [currency sizeToFit];
            
            [currency setAutoresizingMask:UIViewAutoresizingFlexibleRightMargin |
             UIViewAutoresizingFlexibleLeftMargin |
             UIViewAutoresizingFlexibleBottomMargin];
        }
        
        
    }
    else if (indexPath.section == 1)
    {
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        stringForCell= [array2 objectAtIndex:indexPath.row];
        
        
    }
    else if (indexPath.section == 2)
    {
        
        stringForCell= [array3 objectAtIndex:indexPath.row];
        cell.textLabel.textColor = [UIColor colorWithRed:51/255.f green:153/255.f blue:255/255.f alpha:1.0];
        
        
        
    }
    else
    {
        
        stringForCell= [array4 objectAtIndex:indexPath.row];
        
        
    }
    
    [cell.textLabel setText:stringForCell];
    cell.layer.cornerRadius = 5.0;
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:12 ];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 15;
    }
    else if(section == 1)
    {
        return 15;
    }
    else if (section == 2)
    {
        return 15;
    }
    else
    {
        return 15;
    }
    
}



@end
