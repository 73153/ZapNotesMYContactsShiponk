//
//  RegisterViewController.m
//  Snapndpack
//
//  Created by pooja on 9/1/16.
//  Copyright © 2016 com.zaptechsolutions. All rights reserved.
//

#import "RegisterViewController.h"
#import "AppDelegate.h"
#import "AppDelegate.h"
#import "FMDBDataAccess.h"

@interface RegisterViewController ()
{
    NSMutableArray *aryData;
    FMDBDataAccess *objFMDBDataAccess;
    AppDelegate *objAppDelegate;
}

@end

@implementation RegisterViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"REGISTER";
    objFMDBDataAccess = [ FMDBDataAccess sharedManager];
    objAppDelegate = [[UIApplication sharedApplication] delegate];
    [self.navigationController.navigationBar
     setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Arial" size:20.0],NSFontAttributeName,
                             [UIColor whiteColor], NSForegroundColorAttributeName,
                             nil]];
    if ([_txtFname respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor blackColor];
        _txtFname.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" First Name" attributes:@{NSForegroundColorAttributeName: color}];
        _txtLname.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" Last Name" attributes:@{NSForegroundColorAttributeName: color}];
        _txtEmailId.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" E-mail Address" attributes:@{NSForegroundColorAttributeName: color}];
        _txtPass.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" Password" attributes:@{NSForegroundColorAttributeName: color}];
        _txtCPass.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" Confirm Password" attributes:@{NSForegroundColorAttributeName: color}];
        
    } else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
        // TODO: Add fall-back code to set placeholder color.
    }


}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationItem.title=@"";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

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

- (IBAction)OnbtnSubmitClick:(id)sender
{
      NSDictionary *parameters = @{@"fname":self.txtFname.text,@"lname":self.txtLname.text,@"email":self.txtEmailId.text,@"password":self.txtPass.text};
    
    NSString *condition = [NSString stringWithFormat:@"where fname='%@'",@"Vivek"];

    //Update
//    if([objFMDBDataAccess updateQueryWithDictionary:@"User" withAttribute:parameters withSQLCondition:condition])
//    {
//        NSLog(@"Data inserted success");
//    }
//    return;
    
    //Insert
   if([objFMDBDataAccess insertQueryWithDictionary:parameters inTable:@"User"])
   {
       NSLog(@"Data inserted success");
   }
   
  
    return;
    
    NSError *error = nil;
    NSLog(@"You are registerd sucessfully");
    // Save the object to persistent store
   
    
    [self dismissViewControllerAnimated:YES completion:nil];
    if(self.txtFname == nil || [self.txtFname.text isEqualToString:@""])
    {
        [self showErrorAlert1];
    }
    
    else if (self.txtLname == nil || [self.txtLname.text isEqualToString:@""])
    {
        [self showErrorAlert2];
    }
    else if (self.txtEmailId == nil || [self.txtEmailId.text isEqualToString:@""])
    {
        [self showErrorAlert3];
    }
    else if (![self.txtPass.text isEqualToString:self.txtCPass.text])
    {
        UIAlertController *ErrorAlert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Password mismatch" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [ErrorAlert addAction:ok];
        
        [self presentViewController:ErrorAlert animated:YES completion:nil];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:true];

    }
}
-(void)showErrorAlert1
    {
        UIAlertController *ErrorAlert = [UIAlertController alertControllerWithTitle:@"Title" message:@"please enter your First name." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [ErrorAlert addAction:ok];
        [self presentViewController:ErrorAlert animated:YES completion:nil];
    }

-(void)showErrorAlert2
{
    UIAlertController *ErrorAlert = [UIAlertController alertControllerWithTitle:@"Title" message:@"please enter your Last name." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [ErrorAlert addAction:ok];
    [self presentViewController:ErrorAlert animated:YES completion:nil];
}

-(void)showErrorAlert3
{
    UIAlertController *ErrorAlert = [UIAlertController alertControllerWithTitle:@"Title" message:@"please enter your Email Address." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [ErrorAlert addAction:ok];
    [self presentViewController:ErrorAlert animated:YES completion:nil];
}



@end
