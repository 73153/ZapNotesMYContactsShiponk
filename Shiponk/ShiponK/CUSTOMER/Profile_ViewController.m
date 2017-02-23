//
//  Profile_ViewController.m
//  ShiponK
//
//  Created by datt on 16/03/1938 SAKA.
//  Copyright © 1938 SAKA com.zaptechsolution. All rights reserved.
//

#import "Profile_ViewController.h"
#import "RegistrationCustomerViewController.h"
#import "appShareManager.h"
#import "ApplicationData.h"
#import "JoinCarrerViewController.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "ViewRatingAndReviewVC.h"
#import "AddBranchViewController.h"
#import "ViewBranchViewController.h"
#import "VehicleTypeViewController.h"
#import "EditBusinessTypeViewController.h"
#import "EditVehicleTypeViewController.h"
#import "ComMehod.h"
#define BASE_KEY @"AIzaSyBG2lM5lHV6a0N2_Gk3fUV3Vz8DnI8z_OU"
@interface Profile_ViewController ()<UITextFieldDelegate>{
    appShareManager *objappShareManager;
    
    NSArray *profileArray;
    NSString *isHome,*busType;
     NSUserDefaults *prefs;
    UIImage *selectImg;
    NSDictionary *parameters;
    NSString *imgStr1;
    
    ComMehod   *objComMehod;
    NSMutableDictionary *dictUpload;
  
    NSArray *feed_dataDic;
    NSDictionary *dataDic,*dataDic1,*dataDic2,*dataDic3;
    NSString *strpostalcode,*strplaceid;
    NSString *cityStr,*urlString;
    NSMutableArray *aryCity,*aryTypes,*arypcode,*arydata,*aryPostalCode;
    
    BOOL setView;
    
}

@end

@implementation Profile_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self getCarrierSignupData];

    
    objappShareManager=[appShareManager sharedManager];
    
    objappShareManager.arrAddBranch=[[NSMutableArray alloc]init];
    objappShareManager.carrierSignupDict=[[NSMutableDictionary alloc]init];
    
   [_menuBtn addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleLeftMenu) forControlEvents:UIControlEventTouchUpInside];
    
    _img_userProfileimg.layer.cornerRadius=_img_userProfileimg.frame.size.width/2.0;
    _img_userProfileimg.layer.masksToBounds=YES;
    _img_userProfileimg.clipsToBounds=YES;    
    
    _mainScrollView.contentSize=CGSizeMake(_mainScrollView.frame.size.width, 1100);
    isHome=@"1";
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(setBusienessType:)
                                                 name:@"BusinessType"
                                               object:nil];
    
    
    //objappShareManager = [appShareManager sharedManager];
    
    

       // Do any additional setup after loading the view.
}

-(void)setBusienessType:(NSNotification *)n
{
    busType=[NSString stringWithFormat:@"%@",n.userInfo[@"BusinessType"]];
}

-(void)viewDidAppear:(BOOL)animated
{
   
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getProfileDetails{
    @try
    {
        
        NSString *struserID=[NSString stringWithFormat:@"%@",[objappShareManager.loginDic valueForKey:@"user_id"]];
        NSDictionary *dicttt = @{@"user_id":struserID};
        void (^successed)(id responseObject) = ^(id responseObject)
        {
            
            profileArray=[responseObject valueForKey:@"data"];
            NSLog(@"%@",profileArray);
            
            _lbl_username.text=[NSString stringWithFormat:@"%@ %@",[[profileArray objectAtIndex:0]valueForKey:@"first_name"],[[profileArray objectAtIndex:0]valueForKey:@"last_name"]];
            
           
            

           
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
-(void)getCarrierSignupData
{
    
    @try
    {
        [APPDATA showLoader];
        
        
        
        NSString *struserID=[NSString stringWithFormat:@"%@",[objappShareManager.loginDic valueForKey:@"user_id"]];
        
        NSDictionary *dicttt = @{@"user_id":struserID};
        
        void (^successed)(id responseObject) = ^(id responseObject)
        {
            objappShareManager.carrierProfileDataDict=[[NSMutableDictionary alloc]init];
            
            objappShareManager.carrierProfileDataDict=(NSMutableDictionary *)responseObject;
            
            
            profileArray=[responseObject valueForKey:@"data"];
            objComMehod=[[ComMehod alloc]init];
            
            int vid;
            for (int i=0; i<objappShareManager.sFlageArray.count; i++) {
                
                for (int j=0; j<[[objappShareManager.carrierProfileDataDict valueForKey:@"vehicle"] count]; j++) {
                    
                    
                    vid = [[[[objappShareManager.carrierProfileDataDict valueForKey:@"vehicle"]objectAtIndex:j]valueForKey:@"vehicle_id"] intValue];;
                    
                    
                    
                    if (i==(vid-1)) {
                        
                        [objappShareManager.sFlageArray replaceObjectAtIndex:i withObject:@"1"];
                        
                    }
                    
                    
                }
                
            }
            

            
            [self displayData];
            
            
            
        };
        
        void (^failure)(NSError * error) = ^(NSError *error)
        {
            [self getCarrierSignupData];
        };
        
        
        [ApiCall sendToService:API_USER_PROFILE andDictionary:dicttt success:successed failure:failure];
    }
    @catch (NSException *exception) {
        [APPDATA hideLoader];
        
    }
    @finally {
        [APPDATA hideLoader];
        
    }
    
    
}

-(void)displayData
{
    _lbl_username.text=[NSString stringWithFormat:@"%@ %@",[[profileArray objectAtIndex:0]valueForKey:@"first_name"],[[profileArray objectAtIndex:0]valueForKey:@"last_name"]];
    
    NSString *imgStr=[NSString stringWithFormat:@"%@",[[profileArray objectAtIndex:0]valueForKey:@"profile_picture"]];
    if ([imgStr length]>1)
    {
        imgStr1=[NSString stringWithFormat:@"http://216.55.169.45/~shiponk/master/assets/uploads/images/profilepicture/%@",imgStr];
        
        [_img_userProfileimg setImageWithURL:[NSURL URLWithString:imgStr1] placeholderImage:[UIImage imageNamed:@""] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        
        _noimageView.hidden=YES;
    }else{
        _noimageView.hidden=NO;
    }
    
    
    
    
    
    _tr_txtfirst_name.text=[NSString stringWithFormat:@"%@",[[profileArray objectAtIndex:0]valueForKey:@"first_name"]];
    
    _tr_lastname.text=[NSString stringWithFormat:@"%@",[[profileArray objectAtIndex:0]valueForKey:@"last_name"]];
    
    _tr_email.text=[NSString stringWithFormat:@"%@",[[profileArray objectAtIndex:0]valueForKey:@"email"]];
    
   
    
    _tr_moble.text=[NSString stringWithFormat:@"%@",[[profileArray objectAtIndex:0]valueForKey:@"mobile_number"]];
    
    NSString *strhome=[[profileArray valueForKey:@"is_home"]objectAtIndex:0];
    
    if ([strhome isEqualToString:@"1"])
    {
        
        [self btn_homeAction:nil];
        
    }else{
        
        [self btn_officeAction:nil];
        
    }

    
    
    
    
    NSMutableArray *Arr=[[NSMutableArray alloc]init];
    Arr=[objappShareManager.carrierProfileDataDict valueForKey:@"profile"];
    
    NSLog(@"%@",objappShareManager.carrierProfileDataDict);
    
    NSMutableArray *Arr2=[[NSMutableArray alloc]init];
    Arr2=[objappShareManager.carrierProfileDataDict valueForKey:@"company_branch"];
    
    for (int i=0; i<Arr2.count-1; i++) {
        
        
        [objappShareManager.arrAddBranch addObject:Arr2[i]];
    }
    
    // objappShareManager.arrAddBranch
    
    _tr_companyname.text=[NSString stringWithFormat:@"%@",[[Arr objectAtIndex:0]valueForKey:@"company_name"]];
    
    _tr_txt_comp_address.text=[NSString stringWithFormat:@"%@",[[Arr2 objectAtIndex:Arr2.count-1]valueForKey:@"address"]];
    
    _tr_city.text=[NSString stringWithFormat:@"%@",[[Arr2 objectAtIndex:Arr2.count-1]valueForKey:@"city"]];
    
    _tr_zip.text=[NSString stringWithFormat:@"%@",[[Arr2 objectAtIndex:Arr2.count-1]valueForKey:@"zipcode"]];
    
    _tr_txt_comp_pan.text=[NSString stringWithFormat:@"%@",[[Arr objectAtIndex:0]valueForKey:@"pan_number"]];

}


- (IBAction)btn_Edit_Action:(id)sender {
    
    if([objappShareManager.CarrierProfileViewShowID isEqualToString:@"1"]) {
        
        JoinCarrerViewController *objview_cont =(JoinCarrerViewController
                                                 *) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"JoinCarrerViewController"];
        
        [[self navigationController]pushViewController:objview_cont animated:YES];
       
    }
    else
    {
        RegistrationCustomerViewController  *objview_cont =(RegistrationCustomerViewController
                                                            *) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"RegistrationCustomerViewController"];
        
        [[self navigationController]pushViewController:objview_cont animated:YES];
    }
  
    
}
- (IBAction)btnMyReviewAction:(id)sender {
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewRatingAndReviewVC* controller = [storyboard instantiateViewControllerWithIdentifier:@"ViewRatingAndReviewVC"];
    
    [self.navigationController pushViewController:controller animated:YES];
}



#pragma mark set Home and office.....
- (IBAction)btn_homeAction:(id)sender
{
    
    isHome=@"1";
    
    _imgMobilePhn.hidden=NO;
    _imgOfficePhn.hidden=YES;
    
    UIImage *btnImage = [UIImage imageNamed:@"check.png"];
    [_btn_home setImage:btnImage forState:UIControlStateNormal];
    
    
    UIImage *btnImage1 = [UIImage imageNamed:@"uncheck.png"];
    [_btn_office setImage:btnImage1 forState:UIControlStateNormal];
}

- (IBAction)btnEditProfileImgAction:(id)sender {
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (textField.tag==100) {
        
        
        NSCharacterSet *charsToTrim = [NSCharacterSet characterSetWithCharactersInString:@"()   ;    ^^ ?? ? // [{]}+=_-* / ,' \\  \" ^#`<>| ^  % : @ @@"];
        
        
        NSString *str1 = [self.tr_city.text stringByTrimmingCharactersInSet:charsToTrim];
        NSString *strSearch1 = [str1 stringByReplacingOccurrencesOfString:@" " withString:@""];//stringByReplacingOccurrencesOfString:@"/" withString:@""]stringByReplacingOccurrencesOfString:@"^" withString:@""]stringByReplacingOccurrencesOfString:@"?" withString:@""];
        
        
        
        
        
        urlString = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/autocomplete/json?key=%@&input=%@",BASE_KEY,strSearch1];
        if (_tr_city.text.length>0) {
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
        [_tr_city resignFirstResponder];
        
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
    
    
    
    self.tr_city.text=[NSString stringWithFormat:@"%@",cityStr];
    
    self.tr_zip.text=[NSString stringWithFormat:@"%@",strpostalcode];
    [self setMainView];
    
    
    self.tblCity.hidden=YES;
    
}




- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    
    selectImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    //[[SDImageCache sharedImageCache] removeImageForKey:imgStr1 fromDisk:YES];
    
    
        
        _img_userProfileimg.image=selectImg;
  
   
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
    
    
}


- (IBAction)btn_officeAction:(id)sender {
    
    isHome=@"2";
    _imgMobilePhn.hidden=YES;
    _imgOfficePhn.hidden=NO;
    
    UIImage *btnImage = [UIImage imageNamed:@"check.png"];
    [_btn_office setImage:btnImage forState:UIControlStateNormal];
    
    UIImage *btnImage1 = [UIImage imageNamed:@"uncheck.png"];
    [_btn_home setImage:btnImage1 forState:UIControlStateNormal];
}



- (IBAction)btnEditVehicalTypeAction:(id)sender {
    
    EditVehicleTypeViewController *controller2 =(EditVehicleTypeViewController *) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"EditVehicleTypeVC"];
    
    
    controller2.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    
    [self.view addSubview:controller2.view];
    [self addChildViewController:controller2];
    [controller2 didMoveToParentViewController:self];
    
    [UIView animateWithDuration:0.3/1.5 animations:^{
        controller2.view.transform=CGAffineTransformScale(CGAffineTransformIdentity,1.1,1.1);
        
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3/2 animations:^{
            controller2.view.transform=CGAffineTransformScale(CGAffineTransformIdentity,0.9,0.9);
            
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/2 animations:^{
                controller2.view.transform=CGAffineTransformIdentity;
                
                
            }];
        }];
    }];
    

}

- (IBAction)btn_updateBusinessAction:(id)sender {
    
    
    
    EditBusinessTypeViewController *controller2 =(EditBusinessTypeViewController *) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"EditBusinessTypeVC"];
    
    
    controller2.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);

    [self.view addSubview:controller2.view];
    [self addChildViewController:controller2];
    [controller2 didMoveToParentViewController:self];
    
    [UIView animateWithDuration:0.3/1.5 animations:^{
        controller2.view.transform=CGAffineTransformScale(CGAffineTransformIdentity,1.1,1.1);
        
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3/2 animations:^{
            controller2.view.transform=CGAffineTransformScale(CGAffineTransformIdentity,0.9,0.9);
            
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/2 animations:^{
                controller2.view.transform=CGAffineTransformIdentity;
                
                
            }];
        }];
    }];
    

    
}

- (IBAction)btn_viewBranchAction:(id)sender
{
    ViewBranchViewController *controller2 =(ViewBranchViewController *) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:
                                                                         @"ViewBranchViewController"];
    
    
    controller2.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    
    
    [self.view addSubview:controller2.view];
    [self addChildViewController:controller2];
    [controller2 didMoveToParentViewController:self];
    
//    [controller2.viewBranchView setFrame:CGRectOffset(controller2.viewBranchView.frame, controller2.viewBranchView.frame.size.width*.025, controller2.viewBranchView.frame.size.height*.12)];
//    
//     [controller2.btnCLose setFrame:CGRectOffset(controller2.btnCLose.frame, controller2.viewBranchView.frame.size.width*.025, controller2.viewBranchView.frame.size.height*.12)];
    
    [UIView animateWithDuration:0.3/1.5 animations:^{
        controller2.view.transform=CGAffineTransformScale(CGAffineTransformIdentity,1.1,1.1);
        
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3/2 animations:^{
            controller2.view.transform=CGAffineTransformScale(CGAffineTransformIdentity,0.9,0.9);
            
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/2 animations:^{
                controller2.view.transform=CGAffineTransformIdentity;
                
                
            }];
        }];
    }];

}

- (IBAction)btn_addBranchAction:(id)sender {
    
    
    AddBranchViewController *controller2 =(AddBranchViewController *) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:
                                                                       @"AddBranchViewController"];
    
    
    controller2.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    
    
    [self.view addSubview:controller2.view];
    [self addChildViewController:controller2];
    [controller2 didMoveToParentViewController:self];
    
//    [controller2.viewAddBranch setFrame:CGRectOffset(controller2.viewAddBranch.frame, controller2.viewAddBranch.frame.size.width*.025, controller2.viewAddBranch.frame.size.height*.3)];
//    
//    [controller2.btnClose setFrame:CGRectOffset(controller2.btnClose.frame, controller2.viewAddBranch.frame.size.width*.025, controller2.viewAddBranch.frame.size.height*.3)];

    
    [UIView animateWithDuration:0.3/1.5 animations:^{
        controller2.view.transform=CGAffineTransformScale(CGAffineTransformIdentity,1.1,1.1);
        
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3/2 animations:^{
            controller2.view.transform=CGAffineTransformScale(CGAffineTransformIdentity,0.9,0.9);
            
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/2 animations:^{
                controller2.view.transform=CGAffineTransformIdentity;
                
                
            }];
        }];
    }];
    

    
}
-(void)updateProfile
{
    
    
    
}
-(void)succefulUpload{
    
    [APPDATA hideLoader];
    
    NSDictionary *dic=[[dictUpload valueForKey:@"data"] valueForKey:@"data"];
    
    objappShareManager.L_FNameStr=[NSString stringWithFormat:@"%@ %@",[dic valueForKey:@"first_name"],[dic valueForKey:@"last_name"]];
    
     objappShareManager.L_P_FStr=[NSString stringWithFormat:@"%@%@",[dic valueForKey:@"profile_pic_url"],[dic valueForKey:@"profile_picture"]];
    
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:[dictUpload valueForKey:@"status"]
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil,nil];
    
    [alert show];
    
    
    
    
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

- (BOOL) validatePanCardNumber: (NSString *) cardNumber {
    NSString *emailRegex = @"^[A-Z]{5}[0-9]{4}[A-Z]$";
    NSPredicate *cardTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [cardTest evaluateWithObject:cardNumber];
}
- (IBAction)btn_updateProfile:(id)sender {
    
    [APPDATA showLoader];
    
     [self seleCtDictMethod];
    
    if([[objComMehod spacecheck:_tr_companyname.text] isEqualToString:@"0"]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter compay name." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else if([[objComMehod spacecheck:_tr_txt_comp_address.text] isEqualToString:@"0"]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter compay address." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else if([[objComMehod spacecheck:_tr_city.text] isEqualToString:@"0"]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter city." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if([[objComMehod spacecheck:_tr_zip.text] isEqualToString:@"0"]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter pincode." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else if([[objComMehod spacecheck:_tr_txt_comp_pan.text] isEqualToString:@"0"]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter PAN number." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    
    else if([self validatePanCardNumber:_tr_txt_comp_pan.text]==NO){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter a valid PAN number." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }else{
    

    
     NSDictionary  *dictAddBranch =  [[NSDictionary alloc]initWithObjects:@[_tr_txt_comp_address.text,_tr_city.text,_tr_zip.text] forKeys:@[@"address",@"city",@"zipcode"]];
    
    [objappShareManager.arrAddBranch addObject:dictAddBranch.mutableCopy];
    
    
    
    NSString *str;
    NSString *strVT=[NSString stringWithFormat:@"[%@]",objappShareManager.selectVelicalidArray];
    NSCharacterSet *charsToTrim = [NSCharacterSet characterSetWithCharactersInString:@"()"];
     str= [strVT stringByTrimmingCharactersInSet:charsToTrim];
    
    str = [[str componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@""];
    
    
    str=[[str stringByReplacingOccurrencesOfString:@")" withString:@""] stringByReplacingOccurrencesOfString:@"(" withString:@""];
    
    str=[[str stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
  
    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:objappShareManager.arrAddBranch  options:0 error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSString *strAddAnItem=[NSString stringWithFormat:@"%@",jsonString];
    NSString  *strAddbranch =[strAddAnItem stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    
    
    
    NSString *struserID=[NSString stringWithFormat:@"%@",[objappShareManager.loginDic valueForKey:@"user_id"]];

    
    NSString *password = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"password"];
     NSData *imageData = UIImageJPEGRepresentation(_img_userProfileimg.image, 0.5);
    
    if (busType==nil) {
        busType=[NSString stringWithFormat:@"%@",[[[objappShareManager.carrierProfileDataDict valueForKey:@"profile"]objectAtIndex:0]valueForKey:@"business_type"]];
    }
    
    
  
    
    
    [APPDATA showLoader];
    
    
    NSString *strr=[NSString stringWithFormat:API_EDIT_USER_PROFILE];
    NSString *urlString = [NSString stringWithFormat:@"%@",strr];
    
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
    

    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"customer_type\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[@"2" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"user_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[struserID dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"firstname_carrier\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"%@",_tr_txtfirst_name.text] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
   
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"lastname_carrier\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"%@",_tr_lastname.text] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"mobilenumber_carrier\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"%@",_tr_moble.text] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"ishome\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"%@",isHome] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"pan_number\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"%@",_tr_txt_comp_pan.text] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"companyname_carrier\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"%@",_tr_companyname.text] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"business_type\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"%@",busType] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"vehicle_type\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"%@",str] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"company_branch\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"%@",strAddbranch] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];

    
    
    //pass method
   
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"password\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[password dataUsingEncoding:NSUTF8StringEncoding]];
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
        [self succefulUpload];
    });

    

    
    [self updateProfile];
    }
}
@end
