//
//  EditVehicleTypeViewController.m
//  ShiponK
//
//  Created by datt on 19/07/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import "EditVehicleTypeViewController.h"
#import "EditVehicleTypeTableViewCell.h"
#import "appShareManager.h"
#import "ComMehod.h"
#import "ApiCall.h"
#import "ApplicationData.h"

@interface EditVehicleTypeViewController ()<UITableViewDelegate, UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    appShareManager *objappShareManager;
    ComMehod *objComMehod;
    NSString *Dic;
    int vid;
    BOOL rowSelected;
 
}


@end

@implementation EditVehicleTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    objappShareManager = [appShareManager sharedManager];
    objComMehod=[[ComMehod alloc]init];
    
    
//    for (int i=0; i<objappShareManager.sFlageArray.count; i++) {
//        
//        for (int j=0; j<[[objappShareManager.carrierProfileDataDict valueForKey:@"vehicle"] count]; j++) {
//            
//            
//            vid = [[[[objappShareManager.carrierProfileDataDict valueForKey:@"vehicle"]objectAtIndex:j]valueForKey:@"vehicle_id"] intValue];;
//            
//            
//            
//            if (i==(vid-1)) {
//                
//                [objappShareManager.sFlageArray replaceObjectAtIndex:i withObject:@"1"];
//                
//            }
//            
//            
//        }
//        
//    }
    

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex {
    
    
    return [objappShareManager.VehicleTypeArray count];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"EditVehicleTypeTableViewCell";
    
    EditVehicleTypeTableViewCell  *cell = (EditVehicleTypeTableViewCell *)[self.tblVehicleType dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    cell.lblVehicalType.text=[NSString stringWithFormat:@"%@",[[objappShareManager.VehicleTypeArray objectAtIndex:indexPath.row] valueForKey:@"name"]];
    
    
    
    
    NSString *strSel=[objappShareManager.sFlageArray objectAtIndex:indexPath.row];
    
    
    if ([strSel isEqualToString:@"0"])
    {
        [cell.imgCheck setImage:[UIImage imageNamed:@"uncheck.png"]];
        
    }else{
        [cell.imgCheck setImage:[UIImage imageNamed:@"check.png"]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *strSel=[objappShareManager.sFlageArray objectAtIndex:indexPath.row];
    rowSelected=YES;
    
    if ([strSel isEqualToString:@"0"])
    {
        [objappShareManager.sFlageArray replaceObjectAtIndex:indexPath.row withObject:@"1"];
    }else{
        
        [objappShareManager.sFlageArray replaceObjectAtIndex:indexPath.row withObject:@"0"];
    }
    
    [self.tblVehicleType reloadData];
    
}



- (IBAction)btnCloseAction:(id)sender {
    
    
    NSString *str=[NSString stringWithFormat:@"%@", objappShareManager.sFlageArray];
    NSRange range= [str rangeOfString:@"1"];
    if (range.length==0) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"error"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil,nil];
        
        [alert show];

        
    }
    
    else
    {
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
}

- (IBAction)btnDoneAction:(id)sender {
    
    if ([objappShareManager.selectVelicalidArray count]==0) {
       
    }
    
    else
    {
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
}
@end
