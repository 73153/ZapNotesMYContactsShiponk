//
//  AddBranchViewController.m
//  ShiponK
//
//  Created by Bhushan on 6/27/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import "AddBranchViewController.h"
#import "appShareManager.h"
#import "ComMehod.h"
#define BASE_KEY @"AIzaSyBG2lM5lHV6a0N2_Gk3fUV3Vz8DnI8z_OU"
@interface AddBranchViewController ()<UITextFieldDelegate>
{
    NSMutableDictionary *dictAddBranch;
    appShareManager *objGlobal;
    ComMehod* objComMehod;
    
    NSArray *feed_dataDic;
    NSDictionary *dataDic,*dataDic1,*dataDic2,*dataDic3;
    NSString *strpostalcode,*strplaceid;
    NSString *cityStr,*urlString;
    NSMutableArray *aryCity,*aryTypes,*arypcode,*arydata,*aryPostalCode;
    
    BOOL setView;
}
@end

@implementation AddBranchViewController
@synthesize txtFieldTotalAmt,txtFieldCity,txtFieldMobileNo,txtFieldZipCode,strCompanyName,strLicense;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    objGlobal = [appShareManager sharedManager];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    @try {
        
        dictAddBranch = [[NSMutableDictionary alloc]init];
        
    }
    @catch (NSException *exception) {
         NSLog(@"Exception At: %s %d %s %s %@", __FILE__, __LINE__, __PRETTY_FUNCTION__, __FUNCTION__,exception);
    }
    
}

- (IBAction)btnDoneAction:(id)sender {
    
   
    if([[objComMehod spacecheck:txtFieldTotalAmt.text] isEqualToString:@"0"] || txtFieldTotalAmt.text.length<1){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter compay address." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else if([[objComMehod spacecheck:txtFieldCity.text] isEqualToString:@"0"] || txtFieldCity.text.length<1){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter city." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if([[objComMehod spacecheck:txtFieldZipCode.text] isEqualToString:@"0"] || txtFieldZipCode.text.length<1){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter pincode." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else{
        
    
    
    dictAddBranch =  [[NSMutableDictionary alloc]initWithObjects:@[[NSString stringWithFormat:@"%@",txtFieldTotalAmt.text],[NSString stringWithFormat:@"%@",txtFieldCity.text],[NSString stringWithFormat:@"%@",txtFieldZipCode.text]] forKeys:@[@"address",@"city",@"zipcode"]];
    
    [objGlobal.arrAddBranch addObject:dictAddBranch.mutableCopy];
    
    
    NSLog(@"Final Array:%@",objGlobal.arrAddBranch);
    
    
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
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (textField.tag==100) {
        
        
        NSCharacterSet *charsToTrim = [NSCharacterSet characterSetWithCharactersInString:@"()   ;    ^^ ?? ? // [{]}+=_-* / ,' \\  \" ^#`<>| ^  % : @ @@"];
        
        
        NSString *str1 = [self.txtFieldCity.text stringByTrimmingCharactersInSet:charsToTrim];
        NSString *strSearch1 = [str1 stringByReplacingOccurrencesOfString:@" " withString:@""];//stringByReplacingOccurrencesOfString:@"/" withString:@""]stringByReplacingOccurrencesOfString:@"^" withString:@""]stringByReplacingOccurrencesOfString:@"?" withString:@""];
        
        
        
        
        
        urlString = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/autocomplete/json?key=%@&input=%@",BASE_KEY,strSearch1];
        if (txtFieldCity.text.length>0) {
            self.tblCity.hidden=NO;
        }
        else
        {
            self.tblCity.hidden=YES;
        }
        
        
        
        
        NSURL *url=[NSURL URLWithString:urlString];
        
        //  dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL: url];
        // [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
        //  })
        NSError* error;
        NSDictionary* json = [NSJSONSerialization
                              JSONObjectWithData:data
                              
                              options:kNilOptions
                        error:&error];
        
        //The results from Google will be an array obtained from the NSDictionary object with the key "results".
        dataDic = [json objectForKey:@"predictions"];
        feed_dataDic=(NSArray *)dataDic;
        aryCity = [feed_dataDic valueForKey:@"description"];
        aryPostalCode=[feed_dataDic valueForKey:@"place_id"];
        
        //Write out the data to the console.
        
        
        
        if(string.length == 0 && textField.text.length==1)
        {
            aryCity=nil;
            // _City_tbl_view.hidden=YES;
            [self.tblCity reloadData];
        }
        
        [self.tblCity reloadData];
        
        return YES;
    }
    else
    {
        return YES;
    }
}


-(void)json{
    
    NSString *urlString1 = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/details/json?key=%@&placeid=%@",BASE_KEY,strplaceid];
    NSURL *url=[NSURL URLWithString:urlString1];
    
    
    NSData* data = [NSData dataWithContentsOfURL: url];
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:data
                          
                          options:kNilOptions
                          error:&error];
    
    dataDic1 = [json objectForKey:@"result"];
    dataDic2 = [dataDic1 objectForKey:@"address_components"];
    
    strpostalcode=[[NSString alloc]init];
    for(int i=0;i<[dataDic2 count];i++)
    {
        if ([[[[dataDic2 valueForKey:@"types"]objectAtIndex:i]objectAtIndex:0] isEqualToString:@"postal_code"]) {
            aryTypes=[dataDic2 valueForKey:@"long_name"];
            
            strpostalcode=[aryTypes objectAtIndex:i];
        }
        
    }
    
    NSLog(@"Data:%@",strpostalcode);
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    
    if(textField.tag==100)
    {
        if(setView==NO)
        {
            [UIView animateWithDuration:0.5f animations:^{
                [self.view setFrame:CGRectOffset(self.view.frame, 0,- self.tblCity.frame.size.height)];
            }];
            setView=YES;
        }
    }
    else
    {
        [self setMainView];
    }
    
}
-(void)setMainView
{
    self.tblCity.hidden=YES;
    if (setView==YES) {
        setView=NO;
        
        [UIView animateWithDuration:0.5f animations:^{
            [self.view setFrame:CGRectOffset(self.view.frame, 0, self.tblCity.frame.size.height)];
        }];
        [txtFieldCity resignFirstResponder];
        
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return aryCity.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [_tblCity dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [aryCity objectAtIndex:indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    strplaceid=[aryPostalCode objectAtIndex:indexPath.row];
    [self json];
    UITableViewCell *selectedcell=(UITableViewCell *)[self.tblCity cellForRowAtIndexPath:indexPath];
    cityStr=selectedcell.textLabel.text;
    
    
    
    self.txtFieldCity.text=[NSString stringWithFormat:@"%@",cityStr];
    
    self.txtFieldZipCode.text=[NSString stringWithFormat:@"%@",strpostalcode];
    [self setMainView];
    
    
    self.tblCity.hidden=YES;
    
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
