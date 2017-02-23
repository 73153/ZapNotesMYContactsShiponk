//
//  carrier_page6_vc.m
//  ShiponK
//
//  Created by Bhushan on 5/25/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import "carrier_page6_vc.h"
#import "appShareManager.h"
#import "Constant.h"
#import "ApplicationData.h"
#import "ComMehod.h"
#import "DashbordViewController.h"
#import "NewshipmentViewController.h"
@interface carrier_page6_vc ()<UIActionSheetDelegate,UINavigationControllerDelegate,UIPickerViewDataSource,UIImagePickerControllerDelegate,UIPickerViewDataSource>
{
    appShareManager *objappShareManager;
    UIImage *selectImg;
    NSDictionary *parameters;
    ComMehod *objComMehod;
    NSUserDefaults *prefs;
    
    
    NSString *passwordStr, *firstnameStr,*lastnamestr;
}
@end

@implementation carrier_page6_vc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    objappShareManager = [appShareManager sharedManager];
    if ([objappShareManager.CarrierProfileViewShowID isEqualToString:@"1"]) {
        
        _view_Profile_Picture.hidden=NO;
        
             
    }
    else{
        _view_Profile_Picture.hidden=YES;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)btn_imageUploadeAction:(id)sender
{
    
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
        
        _img_Profile_Picture.image=selectImg;
    }
    else{
        [_btn_imgeuploade setBackgroundImage:selectImg
                                    forState:UIControlStateNormal];
    }
    
  
    
    
    
}

-(void)getDataMethod
{
    NSString *strVT=[NSString stringWithFormat:@"[%@]",objappShareManager.selectVelicalidArray];
    
    
    NSCharacterSet *charsToTrim = [NSCharacterSet characterSetWithCharactersInString:@"()"];
    NSString *str = [strVT stringByTrimmingCharactersInSet:charsToTrim];
    
    str = [[str componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@""];
    
    
    str=[[str stringByReplacingOccurrencesOfString:@")" withString:@""] stringByReplacingOccurrencesOfString:@"(" withString:@""];
    
    str=[[str stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    
    
    firstnameStr=[objappShareManager.carrierSignupDict valueForKey:@"firstname"];
    
    
    lastnamestr=[objappShareManager.carrierSignupDict valueForKey:@"lastname"];
    
    NSString *emailaddressStr=[objappShareManager.carrierSignupDict valueForKey:@"emailaddress"];
    
    NSString *isHomeStr=[objappShareManager.carrierSignupDict valueForKey:@"isHome"];
    
    NSString *mobilenumberstr=[objappShareManager.carrierSignupDict valueForKey:@"mobilenumber"];
    
    passwordStr=[objappShareManager.carrierSignupDict valueForKey:@"password"];
    
    
    
    
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
    }else if([[objComMehod spacecheck:license_numbeStr] isEqualToString:@"0"]||[license_numbeStr length]<1){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter license number." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
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
    }else if([[objComMehod spacecheck:cst_numberStr] isEqualToString:@"0"]||[cst_numberStr length]<1){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter CST. " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else if(selectImg == nil){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please select cancel cheque image. " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else{
        
        
        
        if ([objappShareManager.CarrierProfileViewShowID isEqualToString:@"1"]){
            NSString *struserID=[NSString stringWithFormat:@"%@",[objappShareManager.loginDic valueForKey:@"user_id"]];
            parameters = @{@"user_id":struserID,@"customer_type":@"2",@"firstname_carrier":firstnameStr,@"lastname_carrier":lastnamestr,@"mobilenumber_carrier":mobilenumberstr,@"password_carrier":passwordStr,@"ishome":isHomeStr,@"pan_number":pan_numberStr,@"cst_number":cst_numberStr,@"companyname_carrier":companyNameStr,@"business_type":btype,@"zipcode":zipStr,@"vehicle_type":str,@"license_number":license_numbeStr,@"company_branch":strAddbranch};

              [self updateProfile];
            
            }
        else
            {
                
                if ([objappShareManager.device_tokenApp length]<1)
                {
                    objappShareManager.device_tokenApp=@"12345678";
                }
                
                parameters = @{@"customer_type":@"2",@"firstname_carrier":firstnameStr,@"lastname_carrier":lastnamestr,@"email_carrier":emailaddressStr,@"mobilenumber_carrier":mobilenumberstr,@"password_carrier":passwordStr,@"ishome":isHomeStr,@"pan_number":pan_numberStr,@"cst_number":cst_numberStr,@"companyname_carrier":companyNameStr,@"business_type":btype,@"vehicle_type":str,@"license_number":license_numbeStr,@"device_token":objappShareManager.device_tokenApp,@"device_type":@"1",@"company_branch":strAddbranch};

                   [self callingSignUpMethod];
            }
        
        
      
    }
}



- (IBAction)btn_submitAction:(id)sender {
    
    [self getDataMethod];
    
    
    
}
-(void)callingSignUpMethod

{
    [APPDATA showLoader];
    
    NSData *imageData = UIImageJPEGRepresentation(selectImg, 0.5);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    [manager POST:API_SIGNUP parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         [formData appendPartWithFormData:imageData name:@"cancel_cheque"];
         
     } success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         
         [APPDATA hideLoader];
         
           NSError *errorJson=nil;
          NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&errorJson];
         
         
         objappShareManager.loginDic=nil;
         
         NSString *codeStr=[NSString stringWithFormat:@"%@",[responseDict objectForKey:@"code"]];
         NSString *meg=[NSString stringWithFormat:@"%@",[responseDict objectForKey:@"message"]];
         
         if ([codeStr isEqualToString:@"1"])
         {
             
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:meg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
             [alert show];
             
             [self.navigationController popViewControllerAnimated:YES];
             
         }
         else
         {
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:meg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
             [alert show];
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
           [APPDATA hideLoader];
         NSLog(@"Error: %@", error);
     }];
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




@end
