//
//  carrier_page4_vc.m
//  ShiponK
//
//  Created by Bhushan on 5/23/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import "carrier_page4_vc.h"
#import "btypeTableViewCell.h"
#import "appShareManager.h"
#import "VehicleTableViewCell.h"
#import "ComMehod.h"
#import "MBProgressHUD.h"
#import "ApiCall.h"
#import "ApplicationData.h"
#import "ViewController.h"


@interface carrier_page4_vc ()<UITableViewDelegate, UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    appShareManager *objappShareManager;
    ComMehod *objComMehod;
    NSString *Dic;
    int vid;
    BOOL rowSelected;
    UIImage *selectImg;
    NSDictionary *parameters,*dictUpload;
    NSUserDefaults *prefs;
    NSString *passwordStr;
    UIImage *imgL,*imgC;
    
}
@end

@implementation carrier_page4_vc

- (void)viewDidLoad {
    [super viewDidLoad];
    
      objappShareManager = [appShareManager sharedManager];
      objComMehod=[[ComMehod alloc]init];
    if ([objappShareManager.CarrierProfileViewShowID isEqualToString:@"1"]) {
        
         //[_mainScrollView setContentSize:(CGSizeMake(_mainScrollView.bounds.size.width-20, 634))];
        
        _viewUpdateProfile.hidden=NO;
        
        for (int i=0; i<objappShareManager.sFlageArray.count; i++) {
            
            for (int j=0; j<[[objappShareManager.carrierProfileDataDict valueForKey:@"vehicle"] count]; j++) {
                
                
                vid = [[[[objappShareManager.carrierProfileDataDict valueForKey:@"vehicle"]objectAtIndex:j]valueForKey:@"vehicle_id"] intValue];;
                
                
                
                if (i==(vid-1)) {
                    
                    [objappShareManager.sFlageArray replaceObjectAtIndex:i withObject:@"1"];
                    
                }
                
                
            }
            
        }
        
        
    }
    else{
        
        _viewUpdateProfile.hidden=YES;
        
        for (int i=0; i<objappShareManager.sFlageArray.count; i++)
        {
            [objappShareManager.sFlageArray replaceObjectAtIndex:i withObject:@"0"];
            
        }
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
    return 40;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex {
    
    
    return [objappShareManager.VehicleTypeArray count];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"VehicleTableViewCell";
    
    VehicleTableViewCell  *cell = (VehicleTableViewCell *)[self.btl_vehicalType dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.lbl_Vehicalname.text=[NSString stringWithFormat:@"%@",[[objappShareManager.VehicleTypeArray objectAtIndex:indexPath.row] valueForKey:@"name"]];
    
    
    
    NSString *strSel=[objappShareManager.sFlageArray objectAtIndex:indexPath.row];
    
    
    if ([strSel isEqualToString:@"0"])
    {
        [cell.img_selecte setImage:[UIImage imageNamed:@"uncheck.png"]];
        
    }else{
        [cell.img_selecte setImage:[UIImage imageNamed:@"check.png"]];
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
    
    [self.btl_vehicalType reloadData];
    
}



-(void)seleCtDictMethod
{
    objappShareManager.selectVelicalArray=[[NSMutableArray alloc]init];
    objappShareManager.selectVelicalidArray=[[NSMutableArray alloc]init];
    for (int i=0; i<objappShareManager.VehicleTypeArray.count; i++) {
        
        
        NSString *strSel=[objappShareManager.sFlageArray objectAtIndex:i];
        if ([strSel isEqualToString:@"1"])
        {
            [objappShareManager.selectVelicalidArray addObject:[[objappShareManager.VehicleTypeArray objectAtIndex:i] valueForKey:@"id"]];
            
            [objappShareManager.selectVelicalArray addObject:[[objappShareManager.VehicleTypeArray objectAtIndex:i] valueForKey:@"name"]];
            
        }
        
        
    }
    
  
    
}

- (IBAction)btnBackAction:(id)sender {
    
    
//    [[NSNotificationCenter defaultCenter]
//     postNotificationName:@"backPage"
//     object:nil];
//    

    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btn_submitAction:(id)sender {
    
   
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, .5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self seleCtDictMethod];
        if(objappShareManager.selectVelicalidArray.count<1)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please select vehicle type" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }else{
            
            NSString *strVT=[NSString stringWithFormat:@"[%@]",objappShareManager.selectVelicalidArray];
            
            
            NSCharacterSet *charsToTrim = [NSCharacterSet characterSetWithCharactersInString:@"()"];
            NSString *str = [strVT stringByTrimmingCharactersInSet:charsToTrim];
            
            str = [[str componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@""];
            
            
            str=[[str stringByReplacingOccurrencesOfString:@")" withString:@""] stringByReplacingOccurrencesOfString:@"(" withString:@""];
            
            str=[[str stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
            
            
            
            NSString *firstnameStr=[objappShareManager.carrierSignupDict valueForKey:@"firstname"];
            
            
            NSString *lastnamestr=[objappShareManager.carrierSignupDict valueForKey:@"lastname"];
            
            NSString *emailaddressStr=[objappShareManager.carrierSignupDict valueForKey:@"emailaddress"];
            
            NSString *isHomeStr=[objappShareManager.carrierSignupDict valueForKey:@"isHome"];
            
            NSString *mobilenumberstr=[objappShareManager.carrierSignupDict valueForKey:@"mobilenumber"];
            
            passwordStr=[objappShareManager.carrierSignupDict valueForKey:@"password"];
            
            imgL = [objappShareManager.carrierSignupDict valueForKey:@"imageLicense"];
            imgC = [objappShareManager.carrierSignupDict valueForKey:@"imageCancleCheque"];
            
            NSString *companyNameStr=[objappShareManager.carrierSignupDict valueForKey:@"companyName"];
            
            //NSString *comp_addressStr=[objappShareManager.carrierSignupDict valueForKey:@"comp_address"];
            
            //    NSString *cityStr=[objappShareManager.carrierSignupDict valueForKey:@"city"];
            NSString *zipStr=[objappShareManager.carrierSignupDict valueForKey:@"zip"];
            NSString *license_numbeStr=[objappShareManager.carrierSignupDict valueForKey:@"license_numbe"];
            
            
            
            //    NSString *banknameStr=[objappShareManager.carrierSignupDict valueForKey:@"bankname"];
            //
            //    NSString *bankAcStr=[objappShareManager.carrierSignupDict valueForKey:@"accountNumber"];
            //
            //    NSString *ac_holderStr=[objappShareManager.carrierSignupDict valueForKey:@"ac_holder"];
            //
            //
            NSString *btype=[objappShareManager.carrierSignupDict valueForKey:@"btype"];
            //
            //    NSString *bank_IFSCStr=[objappShareManager.carrierSignupDict valueForKey:@"bank_IFSC"];
            
            NSString *pan_numberStr=[objappShareManager.carrierSignupDict valueForKey:@"pan_number"];
            
            NSString *cst_numberStr=[objappShareManager.carrierSignupDict valueForKey:@"cst_number"];
            
            
            NSData* jsonData = [NSJSONSerialization dataWithJSONObject:objappShareManager.arrAddBranch  options:0 error:nil];
            NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            NSString *strAddAnItem=[NSString stringWithFormat:@"%@",jsonString];
            NSString  *strAddbranch =[strAddAnItem stringByReplacingOccurrencesOfString:@"\\" withString:@""];
            
            
            
            
            if([[objComMehod spacecheck:firstnameStr]isEqualToString:@"0"]||[firstnameStr length]<1 )
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter first name." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }else if([[objComMehod spacecheck:lastnamestr]isEqualToString:@"0"]||[lastnamestr length]<1)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter list name." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
            
            else if([[objComMehod spacecheck:emailaddressStr ] isEqualToString:@"0"]||[emailaddressStr length]<1){
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter mobile number." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                
            }else if([[objComMehod spacecheck:passwordStr ] isEqualToString:@"0"]||[passwordStr length]<1){
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please Enter password maximum 8 character." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                
            }else if([[objComMehod spacecheck:companyNameStr] isEqualToString:@"0"]||[companyNameStr length]<1){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter compay name." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
            //    else if([[objComMehod spacecheck:comp_addressStr] isEqualToString:@"0"]||[comp_addressStr length]<1){
            //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter compay address." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            //        [alert show];
            //    }
            //    else if([[objComMehod spacecheck:cityStr] isEqualToString:@"0"]||[cityStr length]<1){
            //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter city." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            //        [alert show];
            //    }
            else if([[objComMehod spacecheck:zipStr] isEqualToString:@"0"]||[zipStr length]<1){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter zip code." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
            else if([btype length]<1)
            {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please select business type." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
            else if(objappShareManager.selectVelicalidArray.count<1)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please select vehicle type" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
            //    else if([[objComMehod spacecheck:banknameStr] isEqualToString:@"0"]||[banknameStr length]<1){
            //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter bank name." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            //        [alert show];
            //    }
            //    else if([[objComMehod spacecheck:bankAcStr] isEqualToString:@"0"]||[bankAcStr length]<1){
            //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter bank account number." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            //        [alert show];
            //    }else if([[objComMehod spacecheck:ac_holderStr] isEqualToString:@"0"]||[ac_holderStr length]<1){
            //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter bank account holder." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            //        [alert show];
            //    }else if([[objComMehod spacecheck:bank_IFSCStr] isEqualToString:@"0"]||[bank_IFSCStr length]<1){
            //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter bank branch IFSC. " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            //        [alert show];
            //    }
            else if([[objComMehod spacecheck:pan_numberStr] isEqualToString:@"0"]||[pan_numberStr length]<1){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter pan number. " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
            //        else if(selectImg == nil){
            //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please select cancel cheque image. " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            //            [alert show];
            //        }
            else{
                [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                
                    [APPDATA showLoader];
                    
                }];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, .2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                
                if ([objappShareManager.CarrierProfileViewShowID isEqualToString:@"1"]){
                    if(selectImg == nil){
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please select cancel cheque image. " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        [alert show];
                    }
                    else
                    {
                        NSString *struserID=[NSString stringWithFormat:@"%@",[objappShareManager.loginDic valueForKey:@"user_id"]];
                        parameters = @{@"user_id":struserID,@"customer_type":@"2",@"firstname_carrier":firstnameStr,@"lastname_carrier":lastnamestr,@"mobilenumber_carrier":mobilenumberstr,@"password_carrier":passwordStr,@"ishome":isHomeStr,@"pan_number":pan_numberStr,/*@"cst_number":cst_numberStr,*/@"companyname_carrier":companyNameStr,@"business_type":btype,@"zipcode":zipStr,@"vehicle_type":str,/*@"license_number":license_numbeStr,*/@"company_branch":strAddbranch};
                        
                        [self updateProfile];
                    }
                }
                else
                {
                    
                    if ([objappShareManager.device_tokenApp length]<1)
                    {
                        objappShareManager.device_tokenApp=@"12345678";
                    }
                    
                    
                    parameters = @{@"customer_type":@"2",@"firstname_carrier":firstnameStr,@"lastname_carrier":lastnamestr,@"email_carrier":emailaddressStr,@"mobilenumber_carrier":mobilenumberstr,@"password_carrier":passwordStr,@"ishome":isHomeStr,@"pan_number":pan_numberStr,/*@"cst_number":cst_numberStr,*/@"companyname_carrier":companyNameStr,@"business_type":btype,@"vehicle_type":str,/*@"license_number":license_numbeStr,*/@"device_token":objappShareManager.device_tokenApp,@"device_type":@"1",@"company_branch":strAddbranch};
                    
                    
                    
                    
                    NSString *strr=[NSString stringWithFormat:API_SIGNUP];
                    NSString *urlString = [NSString stringWithFormat:@"%@",strr];
                    
                    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
                    [request setURL:[NSURL URLWithString:urlString]];
                    [request setHTTPMethod:@"POST"];
                    NSMutableData *body = [NSMutableData data];
                    NSString *boundary = @"---------------------------14737809831466499882746641449";
                    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
                    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
                    
                    NSData *imageData = UIImageJPEGRepresentation(imgL, 0.5);
                    NSData *imageData2 = UIImageJPEGRepresentation(imgC, 0.5);
                    
                    
                    
                    
                    
                    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[@"Content-Disposition: form-data; name=\"licensecopy_upload\"; filename=\"a.jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[NSData dataWithData:imageData]];
                    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    
                    
                    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[@"Content-Disposition: form-data; name=\"cancel_cheque\"; filename=\"a.jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[NSData dataWithData:imageData2]];
                    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    
                    
                    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"customer_type\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    [body appendData:[@"2" dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    
                    
                    
                    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"firstname_carrier\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    [body appendData:[[NSString stringWithFormat:@"%@",firstnameStr] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    
                    
                    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"lastname_carrier\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    [body appendData:[[NSString stringWithFormat:@"%@",lastnamestr] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    
                    
                    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"email_carrier\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    [body appendData:[[NSString stringWithFormat:@"%@",emailaddressStr] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    
                    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"mobilenumber_carrier\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    [body appendData:[[NSString stringWithFormat:@"%@",mobilenumberstr] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    
                    
                    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"ishome\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    [body appendData:[[NSString stringWithFormat:@"%@",isHomeStr] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    
                    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"pan_number\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    [body appendData:[[NSString stringWithFormat:@"%@",pan_numberStr] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    
                    
                    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"companyname_carrier\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    [body appendData:[[NSString stringWithFormat:@"%@",companyNameStr] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    
                    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"business_type\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    [body appendData:[[NSString stringWithFormat:@"%@",btype] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    
                    
                    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"vehicle_type\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    [body appendData:[[NSString stringWithFormat:@"%@",str] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    
                    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"company_branch\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    [body appendData:[[NSString stringWithFormat:@"%@",strAddbranch] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    
                    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"device_token\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    [body appendData:[[NSString stringWithFormat:@"%@",objappShareManager.device_tokenApp] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    
                    
                    
                    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"device_type\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    [body appendData:[[NSString stringWithFormat:@"%@",@"1"] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                    //pass method
                    
                    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"password_carrier\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    [body appendData:[passwordStr dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    
                    
                    
                    
                    
                    
                    // close form
                    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    
                    // setting the body of the post to the reqeust
                    [request setHTTPBody:body];
                    
                    
                    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
                    // NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
                    dictUpload=[NSJSONSerialization JSONObjectWithData:returnData options:NSJSONReadingMutableLeaves error:nil];
                    NSLog(@"%@",returnData);
                    
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                        // [self succefulUpload];
                        [APPDATA showLoader];
                        [self callingSignUpMethod];
                        
                    });
                    
                    
                    
                    
                    
                    
                    
                }
                
                });
                
            }
        }
  //

    
    
    
    
    
}
-(void)callingSignUpMethod

{
//    [APPDATA showLoader];
//    
//    NSData *imageData = UIImageJPEGRepresentation(imgL, 0.5);
//    NSData *imageData2 = UIImageJPEGRepresentation(imgC, 0.5);
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    
//    [manager POST:API_SIGNUP parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
//     {
//         [formData appendPartWithFormData:imageData2 name:@"cancel_cheque"];
//         [formData appendPartWithFormData:imageData name:@"licensecopy_upload"];
//         
//     } success:^(AFHTTPRequestOperation *operation, id responseObject)
//     {
//         
//         [APPDATA hideLoader];
//         
//         NSError *errorJson=nil;
//         NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&errorJson];
//         
//         
//         objappShareManager.loginDic=nil;
//         
//         NSString *codeStr=[NSString stringWithFormat:@"%@",[responseDict objectForKey:@"code"]];
//         NSString *meg=[NSString stringWithFormat:@"%@",[responseDict objectForKey:@"message"]];
//         
//         if ([codeStr isEqualToString:@"1"])
//         {
//             
//             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:meg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//             [alert show];
//             
//             [self.navigationController popViewControllerAnimated:YES];
//             
//         }
//         else
//         {
//             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:meg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//             [alert show];
//         }
//         
//     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
//     {
//         [APPDATA hideLoader];
//         NSLog(@"Error: %@", error);
//     }];
    
    
    
    [APPDATA hideLoader];
    
   // NSDictionary *dic=[[dictUpload valueForKey:@"data"] valueForKey:@"data"];
    
//    objappShareManager.L_FNameStr=[NSString stringWithFormat:@"%@ %@",[dic valueForKey:@"first_name"],[dic valueForKey:@"last_name"]];
//    
//    objappShareManager.L_P_FStr=[NSString stringWithFormat:@"%@%@",[dic valueForKey:@"profile_pic_url"],[dic valueForKey:@"profile_picture"]];
    
    
    
    
             [APPDATA hideLoader];
    
             NSError *errorJson=nil;
    
    
    
             objappShareManager.loginDic=nil;
    
             NSString *codeStr=[NSString stringWithFormat:@"%@",[dictUpload objectForKey:@"code"]];
             NSString *meg=[NSString stringWithFormat:@"%@",[dictUpload objectForKey:@"message"]];
    
             if ([codeStr isEqualToString:@"1"])
             {
    
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:meg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                 [alert show];
    
                 ViewController *objviewController =(ViewController *) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"ViewController"];
                 
                 [APPDATA pushNewViewController:objviewController];
             }
             else
             {
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:meg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                 [alert show];
             }


}

-(void)updateProfile
{
    
    [APPDATA showLoader];
    NSString *filename;
    NSData *imageData = UIImageJPEGRepresentation(selectImg, 0.5);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *strurl;
    
    if ([objappShareManager.CarrierProfileViewShowID isEqualToString:@"1"])
    {
        strurl=API_EDIT_USER_PROFILE;
        
        filename=@"profile_picture";
    }
    else
    {
        filename=@"cancel_cheque";
        
        strurl=API_SIGNUP;
    }
    [manager POST:API_EDIT_USER_PROFILE parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         [formData appendPartWithFormData:imageData name:filename];
         
     } success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         
         [APPDATA hideLoader];
         
         NSError *errorJson=nil;
         NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&errorJson];
         
         NSLog(@"%@",responseDict);
         
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                         message:[responseDict valueForKey:@"status"]
                                                        delegate:self
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil,nil];
         [alert show];
         
         prefs = [NSUserDefaults standardUserDefaults];
         
         [prefs setObject:passwordStr forKey:@"password"];
         
         
         [prefs synchronize];
        
         
         
         [self.navigationController popViewControllerAnimated:YES];
         
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [APPDATA hideLoader];
         NSLog(@"Error: %@", error);
     }];
    
    
}


- (IBAction)btnImgBrowseAction:(id)sender {
    
    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle:nil      //  Must be "nil", otherwise a blank title area will appear above our two buttons
                                message:nil
                                preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* button0 = [UIAlertAction
                              actionWithTitle:@"Cancel"
                              style:UIAlertActionStyleCancel
                              handler:^(UIAlertAction * action)
                              {
                                  //  UIAlertController will automatically dismiss the view
                              }];
    
    UIAlertAction* button1 = [UIAlertAction
                              actionWithTitle:@"Take photo"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                                      
                                      UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                            message:@"Device has no camera"
                                                                                           delegate:nil
                                                                                  cancelButtonTitle:@"OK"
                                                                                  otherButtonTitles: nil];
                                      
                                      [myAlertView show];
                                      
                                  }
                                  else{
                                      
                                      UIImagePickerController *imagePickerController= [[UIImagePickerController alloc] init];
                                      imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                                      imagePickerController.delegate = self;
                                      [self presentViewController:imagePickerController animated:YES completion:^{}];
                                  }
                                  
                              }];
    
    UIAlertAction* button2 = [UIAlertAction
                              actionWithTitle:@"Choose Existing"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  //  The user tapped on "Choose existing"
                                  UIImagePickerController *imagePickerController= [[UIImagePickerController alloc] init];
                                  imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                  imagePickerController.delegate = self;
                                  [self presentViewController:imagePickerController animated:YES completion:^{}];
                              }];
    
    [alert addAction:button0];
    [alert addAction:button1];
    [alert addAction:button2];
    [self presentViewController:alert animated:YES completion:nil];

}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    selectImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    
    if ([objappShareManager.CarrierProfileViewShowID isEqualToString:@"1"]) {
        
        _imgProfile.image=selectImg;
    }
    else{
       
    }
    
    
    
    
    
}

@end
