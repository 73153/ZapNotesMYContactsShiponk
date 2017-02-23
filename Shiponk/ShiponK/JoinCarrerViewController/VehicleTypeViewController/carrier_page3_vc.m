//
//  carrier_page3_vc.m
//  ShiponK
//
//  Created by Bhushan on 5/23/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import "carrier_page3_vc.h"
#import "btypeTableViewCell.h"
#import "appShareManager.h"
#import "carrier_page4_vc.h"
#import "ApplicationData.h"

@interface carrier_page3_vc ()
{
    appShareManager *objappShareManager;
    NSString *btypeStr,*business_type;
  
}
@end

@implementation carrier_page3_vc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    objappShareManager = [appShareManager sharedManager];
    btypeStr=@"";
    
     if ([objappShareManager.CarrierProfileViewShowID isEqualToString:@"1"])
     {
       business_type=[[[objappShareManager.carrierProfileDataDict valueForKey:@"profile"]objectAtIndex:0]valueForKey:@"business_type"];
     }
   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


#pragma mark TableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex {
    
    
    return objappShareManager.AppbusnessArray.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"btypeTableViewCell";
    
    btypeTableViewCell  *cell = (btypeTableViewCell *)[self.tbl_btype dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSString *strtype = [NSString stringWithFormat:@"%@",[[objappShareManager.AppbusnessArray objectAtIndex:indexPath.row] valueForKey:@"name"]] ;
    
    NSString *bcheck;
    
    
   
    
    if ([business_type isEqualToString:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1]] ) {
        
        [cell.img_select setImage:[UIImage imageNamed:@"check.png"]];
    }
    else{
        
    bcheck = [NSString stringWithFormat:@"%@",[[objappShareManager.AppbusnessArray objectAtIndex:indexPath.row] valueForKey:@"id"]] ;
        if ([btypeStr isEqualToString:bcheck])
        {
            [cell.img_select setImage:[UIImage imageNamed:@"check.png"]];
        }else{
            [cell.img_select setImage:[UIImage imageNamed:@"uncheck.png"]];
        }
        
    }
   
    
 
    cell.lbl_name.text=strtype;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    business_type=nil;
    
    btypeStr=[NSString stringWithFormat:@"%@",[[objappShareManager.AppbusnessArray objectAtIndex:indexPath.row] valueForKey:@"id"]];
    [_tbl_btype reloadData];
    
    
}

- (IBAction)btnBackAction:(id)sender {
    
    
//    [[NSNotificationCenter defaultCenter]
//     postNotificationName:@"backPage"
//     object:nil];
    [self.navigationController popViewControllerAnimated:YES];

}

- (IBAction)btn_continueAction:(id)sender
{
    if ([btypeStr length]>0)
    {
        
         [objappShareManager.carrierSignupDict setObject:btypeStr forKey:@"btype"];
        
//        [[NSNotificationCenter defaultCenter]
//         postNotificationName:@"VehicalSet"
//         object:nil];
        
        carrier_page4_vc  *objviewController =(carrier_page4_vc *) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"carrier_page4_vc"];
        
        
        [APPDATA pushNewViewController:objviewController];
        
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please select business type." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}




@end
