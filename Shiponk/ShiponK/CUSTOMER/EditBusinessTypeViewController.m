//
//  EditBusinessTypeViewController.m
//  ShiponK
//
//  Created by datt on 19/07/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import "EditBusinessTypeViewController.h"
#import "EditBusinessTypeTableViewCell.h"
#import "appShareManager.h"


@interface EditBusinessTypeViewController ()
{
    appShareManager *objappShareManager;
    NSString *btypeStr,*business_type;

}


@end

@implementation EditBusinessTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    objappShareManager = [appShareManager sharedManager];
     btypeStr=@"";
    
    
    NSString *str=[NSString stringWithFormat:@"%@",[objappShareManager.carrierSignupDict valueForKey:@"btype"]];
    
    if ([str isEqualToString:@"(null)"]) {
         business_type=[[[objappShareManager.carrierProfileDataDict valueForKey:@"profile"]objectAtIndex:0]valueForKey:@"business_type"];
        [objappShareManager.carrierSignupDict setObject:business_type forKey:@"btype"];
        
    }
    else
    {
        business_type= [objappShareManager.carrierSignupDict valueForKey:@"btype"];
    }
   

   
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex {
    
    
    return objappShareManager.AppbusnessArray.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"EditBusinessTypeTableViewCell";
    
    EditBusinessTypeTableViewCell  *cell = (EditBusinessTypeTableViewCell *)[self.tblBusiness dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSString *strtype = [NSString stringWithFormat:@"%@",[[objappShareManager.AppbusnessArray objectAtIndex:indexPath.row] valueForKey:@"name"]] ;
    
    NSString *bcheck;
    
    
    
    
    if ([business_type isEqualToString:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1]] ) {
        
        [cell.imgCheck setImage:[UIImage imageNamed:@"check.png"]];
    }
    else{
        
        bcheck = [NSString stringWithFormat:@"%@",[[objappShareManager.AppbusnessArray objectAtIndex:indexPath.row] valueForKey:@"id"]] ;
        if ([btypeStr isEqualToString:bcheck])
        {
            [cell.imgCheck setImage:[UIImage imageNamed:@"check.png"]];
        }else{
            [cell.imgCheck setImage:[UIImage imageNamed:@"uncheck.png"]];
        }
        
    }
    
    
    
    cell.lblBusinessType.text=strtype;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   business_type=nil;
    
    btypeStr=[NSString stringWithFormat:@"%@",[[objappShareManager.AppbusnessArray objectAtIndex:indexPath.row] valueForKey:@"id"]];
    
     [objappShareManager.carrierSignupDict setObject:btypeStr forKey:@"btype"];
    [_tblBusiness reloadData];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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

- (IBAction)btnDoneAction:(id)sender {
    
    
[[NSNotificationCenter defaultCenter] postNotificationName:@"BusinessType" object:nil userInfo:@{ @"BusinessType" : btypeStr }];
    
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
