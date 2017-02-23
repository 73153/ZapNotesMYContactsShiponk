//
//  PackagingTypeViewController.m
//  ShiponK
//
//  Created by datt on 11/07/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import "PackagingTypeViewController.h"

@interface PackagingTypeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *typeArr;
}

@end

@implementation PackagingTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tblPackaging.delegate=self;
    _tblPackaging.dataSource=self;
    
    typeArr=[NSArray arrayWithObjects: @"None",@"Select Packaging Service", @"Crates and Pallets", @"Shrink Wrap", @"Vacuum Packaging", @"Preservation Packaging", @"Shock Mount Packaging",@"Other",nil];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [typeArr count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"cell";
    
    UITableViewCell* cell = (UITableViewCell *)[_tblPackaging dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [typeArr objectAtIndex:indexPath.row];
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([typeArr count]-1==indexPath.row) {
        if ([UIAlertController class])
        {
            // use UIAlertController
            UIAlertController *alert= [UIAlertController
                                       alertControllerWithTitle:nil
                                       message:@"Please Enter Packaging Type"
                                       preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * action){
                                                           //Do Some action here
                                                           UITextField *textField = alert.textFields[0];
                                                           NSLog(@"text was %@", textField.text);
                                                           [[NSNotificationCenter defaultCenter] postNotificationName:@"PackagingType" object:nil userInfo:@{ @"PackagingType" :[NSString stringWithFormat:@"%@",textField.text] }];
                                                           
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
                                                           
                                                           
                                                       }];
            UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * action) {
                                                               
                                                               NSLog(@"cancel btn");
                                                               
                                                               [alert dismissViewControllerAnimated:YES completion:nil];
                                                               
                                                           }];
            
            [alert addAction:ok];
            [alert addAction:cancel];
            
            [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                textField.placeholder = @" Enter Packaging Type";
                textField.keyboardType = UIKeyboardTypeDefault;
            }];
            
            [self presentViewController:alert animated:YES completion:nil];
            
        }
        else
        {
            // use UIAlertView
            UIAlertView* dialog = [[UIAlertView alloc] initWithTitle:nil
                                                             message:@" Please Enter Packaging Type"
                                                            delegate:self
                                                   cancelButtonTitle:@"Cancel"
                                                   otherButtonTitles:@"OK", nil];
            
            dialog.alertViewStyle = UIAlertViewStylePlainTextInput;
            dialog.tag = 400;
            [dialog show];
            
        }
    }
    else
    {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PackagingType" object:nil userInfo:@{ @"PackagingType" :[NSString stringWithFormat:@"%@",[typeArr objectAtIndex:indexPath.row]] }];
    
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

/*
 
 
 
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnMainCloseAction:(id)sender {
    
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
