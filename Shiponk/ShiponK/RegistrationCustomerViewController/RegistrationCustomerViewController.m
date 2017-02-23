//
//  LoginCustomerViewController.m
//  ShiponK
//
//  Created by Bhushan on 5/11/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import "RegistrationCustomerViewController.h"
#import "MBProgressHUD.h"
#import "ApiCall.h"
#import "appShareManager.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "DashbordViewController.h"

#import "ComMehod.h"
#import "Constant.h"
#import "ApplicationData.h"
#import "NewshipmentViewController.h"
#import "ProfileImgViewController.h"


@interface RegistrationCustomerViewController()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    appShareManager *objappShareManager;
    ComMehod *objComMehod;
     NSUserDefaults *prefs;
    NSString *struserID;
    UIImage *selectImg;
    NSDictionary *dictUpload;
    
    NSData *imageData;
}
@end

@implementation RegistrationCustomerViewController
@synthesize btn_registration;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    objComMehod=[[ComMehod alloc]init];
    
    objappShareManager = [appShareManager sharedManager];
   
    prefs = [NSUserDefaults standardUserDefaults];
    
    

    
  
    if ([objappShareManager.ProfileViewShowID isEqualToString:@"1"]) {
        
       [_scr_view setContentSize:(CGSizeMake(self.scr_view.frame.size.width,350))];
        //_viewProfileUpdate.hidden=NO;
        _Lbl_title.text= [NSString stringWithFormat:@"Update Profile"];
        _scr_view.scrollEnabled=YES;
        [_scr_view setFrame:CGRectOffset(_scr_view.frame, 0,_viewProfileImg.frame.size.height )];
        
        _btnBack.hidden=YES;
        _btnmenu.hidden=NO;
        [_btnmenu addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleLeftMenu) forControlEvents:UIControlEventTouchUpInside];

        
        UIImage *img=_img_profile_browse.image;
        
        imageData = UIImageJPEGRepresentation(img, 1);
        
        _img_profile_browse.layer.cornerRadius=_img_profile_browse.frame.size.width/2.0;
        _img_profile_browse.layer.masksToBounds=YES;
        _img_profile_browse.clipsToBounds=YES;
    
        
        _btnEditProfile.hidden=NO;
        _txt_emaiAddress.userInteractionEnabled=NO;
        _txt_userName.userInteractionEnabled=NO;
        _txt_password.hidden=YES;
        _txt_cobfirmPassword.hidden=YES;
        _imgConPassBG.hidden=YES;
        _imgPassBG.hidden=YES;
        
       // _txt_userName.hidden=YES;
        _btnJoinShiponk.hidden=YES;
        [self getProfileDetails];
        }
    else
    {
        
        _btnBack.hidden=NO;
        _btnmenu.hidden=YES;

        [_scr_view setContentSize:(CGSizeMake(self.scr_view.frame.size.width, 450))];
        //_viewProfileUpdate.hidden=YES;
        _btnEditProfile.hidden=YES;
        _txt_emaiAddress.userInteractionEnabled=YES;
        _txt_userName.userInteractionEnabled=YES;
       // _txt_userName.hidden=YES;
        _txt_password.hidden=NO;
        _txt_cobfirmPassword.hidden=NO;
        _imgConPassBG.hidden=NO;
        _imgPassBG.hidden=NO;
        _btnJoinShiponk.hidden=NO;
        _scr_view.scrollEnabled=NO;
    }
    
//    [_menu_action addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleLeftMenu) forControlEvents:UIControlEventTouchUpInside];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}



- (IBAction)btn_fbActions:(id)sender
    {
    
        NSString* rechability = [objComMehod checkNetworkRechability];
        
        if ([rechability isEqualToString:@"YES"])
        {
            
            [self loginButtonClicked];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Disconnected"
                                                            message:@"Internet Connection Failed"
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Ok",nil];
            [alert show];
            
        }
        

    
    }



-(void)loginButtonClicked
{
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login
     logInWithReadPermissions: @[@"public_profile",@"email"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error)
         {
             NSLog(@"Process error");
             
         } else if (result.isCancelled)
         {
             NSLog(@"Cancelled");
         }
         else
         {
             NSLog(@"Logged in");
             if ([FBSDKAccessToken currentAccessToken])
             {
                 [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{ @"fields" : @"id,first_name,last_name,email,name"}]startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error)
                  {
                     if (!error)
                     {
                         
                         
                         [prefs setObject:[result valueForKey:@"first_name"] forKey:@"s_first_name"];
                         
                         
                         [prefs setObject:[result valueForKey:@"last_name"] forKey:@"s_last_name"];
                         
                         [prefs setObject:[result valueForKey:@"email"] forKey:@"s_email"];
                         
                         
                         [prefs setObject:[result valueForKey:@"social_id"] forKey:@"s_social_id"];
                         
                         
                         [prefs setObject:[result valueForKey:@"id"] forKey:@"s_id"];
                         
                         
                         [prefs synchronize];
                         
                         [appDelegate socialLogin:result andSocialType:@"Facebook"];
                         
                         
                         
                     }
                 }];
             }
         }
     }];
}


- (IBAction)btn_backAction:(id)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)btn_registrationAction:(id)sender
{
    
    
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,10}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    
    if([[objComMehod spacecheck:_txt_firstName.text]isEqualToString:@"0"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter first name." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else if([[objComMehod spacecheck:_txt_lastName.text]isEqualToString:@"0"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter last name." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    
   else if ([emailTest evaluateWithObject:_txt_userName.text] == NO) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please Enter Valid Email Address." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
       
   } else if ([emailTest evaluateWithObject:_txt_emaiAddress.text] == NO) {
       
       UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please Enter Valid confirm Email Address." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
       [alert show];
       
   }else if(![_txt_emaiAddress.text isEqualToString:_txt_userName.text])
   {
       UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Email address do not match" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
       [alert show];
   }else if([[objComMehod spacecheck:_txt_mobileNumber.text ] isEqualToString:@"0"]){
       
       UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter mobile number." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
       [alert show];
       
   }
//   else if([_txt_password.text length] <7){
//       
//       UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please Enter password maximum 8 character." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//       [alert show];
//       
//   }else if(![_txt_password.text isEqualToString:_txt_cobfirmPassword.text]){
//       
//       UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Password do not match" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//       [alert show];
//   }
   
   else
   {
       
       if ([objappShareManager.ProfileViewShowID isEqualToString:@"1"]) {
           
           
           
           if(_img_profile_browse==nil){
               
               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"plz browse image" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
               [alert show];
           }
           
           
           else{
               NSString* rechability = [objComMehod checkNetworkRechability];
               
               if ([rechability isEqualToString:@"YES"])
               {
                   
                   //calling update method....
                   [self updateProfile];
               }
               else
               {
                   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Disconnected"
                                                                   message:@"Internet Connection Failed"
                                                                  delegate:self
                                                         cancelButtonTitle:@"Cancel"
                                                         otherButtonTitles:@"Ok",nil];
                   [alert show];
                   
               }
               
            
           }
           
           
       }
       else{
           NSString* rechability = [objComMehod checkNetworkRechability];
           
           if ([rechability isEqualToString:@"YES"])
           {
               
               [self RegistrationMethod];
           }
           else
           {
               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Disconnected"
                                                               message:@"Internet Connection Failed"
                                                              delegate:self
                                                     cancelButtonTitle:@"Cancel"
                                                     otherButtonTitles:@"Ok",nil];
               [alert show];
               
           }
           

    
       }
   }
    
}

- (IBAction)btn_img_Browse:(id)sender {
    
        
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

- (IBAction)btn_back_Action:(id)sender {
    
    
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnProfileImgAction:(id)sender {
   // ProfileImgViewController
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
  //  NSArray *arr=[[shipmentItemDataArr objectAtIndex:indexPath.row]valueForKey:@"image"];
    
    ProfileImgViewController *objotherAdditemViewController= (ProfileImgViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"ProfileImgViewController"];
    
    objotherAdditemViewController.imgProfile=_img_profile_browse;
  
    
    objotherAdditemViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    
    
    [self.view addSubview:objotherAdditemViewController.view];
    [self addChildViewController:objotherAdditemViewController];
    [objotherAdditemViewController didMoveToParentViewController:self];
    
    
    
    [UIView animateWithDuration:0.3/1.5 animations:^{
        objotherAdditemViewController.view.transform=CGAffineTransformScale(CGAffineTransformIdentity,1.1,1.1);
        
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3/2 animations:^{
            objotherAdditemViewController.view.transform=CGAffineTransformScale(CGAffineTransformIdentity,0.9,0.9);
            
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/2 animations:^{
                objotherAdditemViewController.view.transform=CGAffineTransformIdentity;
                
                
            }];
        }];
    }];
    

}
    

    
    - (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
    {
        [picker dismissViewControllerAnimated:YES completion:nil];
        
        selectImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        
        
        _img_profile_browse.image=selectImg;
        imageData = UIImageJPEGRepresentation(selectImg, 0.5);

        
    }
-(void)RegistrationMethod{
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    void (^successed)(id responseObject) = ^(id responseObject)
    {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        
        
        
        
        NSString *codeStr=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"code"]];
        NSString *meg=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"message"]];
        
        
        if ([codeStr isEqualToString:@"1"])
        {
            
            
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"SlideNavigationControllerDidOpen"
             object:nil];

            
            objappShareManager.loginDic=nil;
            
            objappShareManager.loginDic=[responseObject objectForKey:@"data"];
            
            objappShareManager.L_FNameStr=[[NSString stringWithFormat:@"%@ %@",[objappShareManager.loginDic valueForKey:@"first_name"],[objappShareManager.loginDic valueForKey:@"last_name"]] uppercaseString];
            objappShareManager.L_P_FStr=[NSString stringWithFormat:@"%@",[objappShareManager.loginDic valueForKey:@"profile_picture"]];
            
            NSDictionary *Dict=[responseObject objectForKey:@"data"];
            
            
            NSString *strFlage=[NSString stringWithFormat:@"%@",[Dict objectForKey:@"user_type"]];
            
            
            objappShareManager.loginUserFlage=[NSString stringWithFormat:@"%@",strFlage];
            
            
            
            
             prefs = [NSUserDefaults standardUserDefaults];
            [prefs setObject:_txt_emaiAddress.text forKey:@"email"];
            [prefs setObject:_txt_password.text forKey:@"password"];
            [prefs setObject:strFlage forKey:@"userType"];
            
            [prefs setObject:@"regular" forKey:@"SocialorRegular"];
            
            [prefs synchronize];

            
            
            
            if([strFlage isEqualToString:@"2"])
            {
                
                [APPDATA hideLoader];
                
                DashbordViewController *objDashbordViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DashbordViewController"];
                [APPDATA pushNewViewController:objDashbordViewController];
                
            }else{
                [APPDATA hideLoader];
                
                
                NewshipmentViewController *objDashbordViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NewshipmentViewController"];
                [APPDATA pushNewViewController:objDashbordViewController];
            }
            
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:meg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        

        
        
        NSString *savedUsername = [prefs stringForKey:@"rememberme"];
        
        if ([savedUsername isEqualToString:@"1"] )
        {
            [prefs setObject:_txt_emaiAddress.text forKey:@"email"];
            [prefs setObject:_txt_password.text forKey:@"password"];
            [prefs setObject:@"Regular" forKey:@"LoginType"];
            
            [prefs synchronize];
        }

        
        
    };
    
    void (^failure)(NSError * error) = ^(NSError *error)
    {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    };
    
    if([objappShareManager.device_tokenApp length]<1){
        objappShareManager.device_tokenApp=@"123456678";
    }
  
    
    NSDictionary *dict = @{@"customer_type":@"1",@"first_name":_txt_firstName.text,@"last_name":_txt_lastName.text,@"email":_txt_emaiAddress.text,@"mobile_number":_txt_mobileNumber.text,@"password":_txt_cobfirmPassword.text,@"device_token":objappShareManager.device_tokenApp};
    
    [ApiCall sendToService:API_SIGNUP andDictionary:dict success:successed failure:failure];
    
    
    
    
}


-(void)updateProfile{
        
    NSString *strUserid=[NSString stringWithFormat:@"%@",[objappShareManager.loginDic valueForKey:@"user_id"]];
    
    
    [APPDATA showLoader];
    
    
    NSString *str=[NSString stringWithFormat:API_EDIT_USER_PROFILE];
    NSString *urlString = [NSString stringWithFormat:@"%@",str];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    NSMutableData *body = [NSMutableData data];
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    
    if (selectImg!=nil) {
        
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Disposition: form-data; name=\"profile_picture\"; filename=\"a.jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    //  parameter username
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"user_type\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[@"1" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    //  parameter token
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"first_name\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[_txt_firstName.text dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    // parameter method
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"last_name\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[_txt_lastName.text dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    //parameter method
   
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"mobile_number\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[_txt_mobileNumber.text dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    //pass method
    NSString *password = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"password"];
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"password\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[password dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    // method strUserid
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"user_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[strUserid dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    // close form
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    // NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    dictUpload=[NSJSONSerialization JSONObjectWithData:returnData options:NSJSONReadingMutableLeaves error:nil];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self succefulUpload];
    });

    
}
-(void)succefulUpload{
    
    [APPDATA hideLoader];
    
    
    NSDictionary *dict=[dictUpload valueForKey:@"data"];
    
    objappShareManager.L_FNameStr=[NSString stringWithFormat:@"%@ %@",[dict valueForKey:@"first_name"],[dict valueForKey:@"last_name"]];
    objappShareManager.L_P_FStr=[NSString stringWithFormat:@"%@%@",[dict valueForKey:@"profile_pic_url"],[dict valueForKey:@"profile_picture"]];
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                                   message:[dictUpload valueForKey:@"status"]
                                                                                  delegate:self
                                                                         cancelButtonTitle:@"OK"
                                                                         otherButtonTitles:nil,nil];
                                   [alert show];
    
    
    if ([[dictUpload valueForKey:@"status"] isEqualToString:@"Success"]) {
        NSString *rechability = [objComMehod checkNetworkRechability];
        if ([rechability isEqualToString:@"YES"])
        {
            
            [self getProfileDetails];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Disconnected"
                                                            message:@"Internet Connection Failed"
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Ok",nil];
            [alert show];
            
        }
    }
    
    prefs = [NSUserDefaults standardUserDefaults];
    
             [prefs setObject:_txt_cobfirmPassword.text forKey:@"password"];
    
    
             [prefs synchronize];
    
    
    
                 
            // [self.navigationController popViewControllerAnimated:YES];
    
    
}

    
    

        
        



-(void)getProfileDetails{
    @try
    {
        
        struserID=[NSString stringWithFormat:@"%@",[objappShareManager.loginDic valueForKey:@"user_id"]];
        NSDictionary *dicttt = @{@"user_id":struserID};
        void (^successed)(id responseObject) = ^(id responseObject)
        {
            
            
            
            NSMutableArray *Arr=[[NSMutableArray alloc]init];
            Arr=[responseObject valueForKey:@"data"];
            NSLog(@"%@",Arr);
            
            
            
            
            _lblUserName.text=[NSString stringWithFormat:@"%@ %@",[[Arr objectAtIndex:0]valueForKey:@"first_name"],[[Arr objectAtIndex:0]valueForKey:@"last_name"]];
            
            
            _txt_firstName.text=[NSString stringWithFormat:@"%@",[[Arr objectAtIndex:0]valueForKey:@"first_name"]];
            
            _txt_lastName.text=[NSString stringWithFormat:@"%@",[[Arr objectAtIndex:0]valueForKey:@"last_name"]];
            
            _txt_userName.text=[NSString stringWithFormat:@"%@",[[Arr objectAtIndex:0]valueForKey:@"email"]];
            
            _txt_emaiAddress.text=[NSString stringWithFormat:@"%@",[[Arr objectAtIndex:0]valueForKey:@"email"]];
            
            _txt_mobileNumber.text=[NSString stringWithFormat:@"%@",[[Arr objectAtIndex:0]valueForKey:@"mobile_number"]];
            
            NSString *imgStr=[NSString stringWithFormat:@"http://216.55.169.45/~shiponk/master/assets/uploads/images/profilepicture/%@",[[Arr objectAtIndex:0]valueForKey:@"profile_picture"]];
            //imageData=[NSData dataWithContentsOfURL: [NSURL URLWithString:imgStr]];
            if ([imgStr length]>1)
            {
                 [_img_profile_browse setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:[UIImage imageNamed:@""] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            }
            
        };
        
        void (^failure)(NSError * error) = ^(NSError *error)
        {
            
            NSLog(@"%@",error);
        };
        
        
        [ApiCall sendToService:API_USER_PROFILE andDictionary:dicttt success:successed failure:failure];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    

}


#pragma mark textfild Delegate Method......
- (void)textFieldDidBeginEditing:(UITextField *)textField;  {
    
    _scr_view.scrollEnabled=YES;
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    
     _scr_view.scrollEnabled=NO;
    return YES;
}

@end
