//
//  carrier_page2_vc.m
//  ShiponK
//
//  Created by Bhushan on 5/23/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import "carrier_page2_vc.h"
#import "ComMehod.h"
#import "appShareManager.h"
#import "AddBranchViewController.h"
#import "ViewBranchViewController.h"
#import "carrier_page3_vc.h"
#import "ApplicationData.h"
#define BASE_KEY @"AIzaSyBG2lM5lHV6a0N2_Gk3fUV3Vz8DnI8z_OU"

#import "IQUIView+Hierarchy.h"
#import "IQUIView+IQKeyboardToolbar.h"


@interface carrier_page2_vc ()<UITextFieldDelegate>
{
    ComMehod* objComMehod;
    appShareManager* objappShareManager;
    NSMutableDictionary *dictAddBranch;
    NSInteger btntag;
    UIImage *selectImg1,*selectImg2;
    
    
    NSArray *feed_dataDic;
    NSDictionary *dataDic,*dataDic1,*dataDic2,*dataDic3;
    NSString *strpostalcode,*strplaceid;
    NSString *cityStr,*urlString;
    NSMutableArray *aryCity,*aryTypes,*arypcode,*arydata,*aryPostalCode;
    
    BOOL setView;
}
@end

@implementation carrier_page2_vc

- (void)viewDidLoad {
    [super viewDidLoad];
    objComMehod =[[ComMehod alloc]init];
    
    objappShareManager = [appShareManager sharedManager];
    
    objappShareManager.arrAddBranch=[[NSMutableArray alloc]init];

    self.tblCity.hidden=YES;
    
    //[self.txt_city addDoneOnKeyboardWithTarget:self action:@selector(doneAction:)];
    
    if ([objappShareManager.CarrierProfileViewShowID isEqualToString:@"1"])
    {
        NSMutableArray *Arr=[[NSMutableArray alloc]init];
        
        
        Arr=[objappShareManager.carrierProfileDataDict valueForKey:@"profile"];
        
        NSLog(@"%@",objappShareManager.carrierProfileDataDict);
        
        NSMutableArray *Arr2=[[NSMutableArray alloc]init];
        Arr2=[objappShareManager.carrierProfileDataDict valueForKey:@"company_branch"];
        
        for (int i=0; i<Arr2.count-1; i++) {
            
            
            [objappShareManager.arrAddBranch addObject:Arr2[i]];
        }
   
       
    
       // objappShareManager.arrAddBranch=
        
        _txt_companyName.text=[NSString stringWithFormat:@"%@",[[Arr objectAtIndex:0]valueForKey:@"company_name"]];
        
        _txt_comp_address.text=[NSString stringWithFormat:@"%@",[[Arr2 objectAtIndex:Arr2.count-1]valueForKey:@"address"]];
        
        _txt_city.text=[NSString stringWithFormat:@"%@",[[Arr2 objectAtIndex:Arr2.count-1]valueForKey:@"city"]];
        
        _txt_zip.text=[NSString stringWithFormat:@"%@",[[Arr2 objectAtIndex:Arr2.count-1]valueForKey:@"zipcode"]];
        
      //  _txt_license_number.text=[NSString stringWithFormat:@"%@",[[Arr objectAtIndex:0]valueForKey:@"license_number"]];
        
        
        
        _txtPanNumber.text=[NSString stringWithFormat:@"%@",[[Arr objectAtIndex:0]valueForKey:@"cst_number"]];
        _txtPanNumber.text=[NSString stringWithFormat:@"%@",[[Arr objectAtIndex:0]valueForKey:@"pan_number"]];

    }
    else{
        
    }
  
    
}

-(void)doneAction:(UIBarButtonItem*)barButton
{
    [self setMainView];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (textField.tag==100) {
        

        NSCharacterSet *charsToTrim = [NSCharacterSet characterSetWithCharactersInString:@"()   ;    ^^ ?? ? // [{]}+=_-* / ,' \\  \" ^#`<>| ^  % : @ @@"];
        
        
        NSString *str1 = [self.txt_city.text stringByTrimmingCharactersInSet:charsToTrim];
        NSString *strSearch1 = [str1 stringByReplacingOccurrencesOfString:@" " withString:@""];//stringByReplacingOccurrencesOfString:@"/" withString:@""]stringByReplacingOccurrencesOfString:@"^" withString:@""]stringByReplacingOccurrencesOfString:@"?" withString:@""];
        
        
        
        
       
            urlString = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/autocomplete/json?key=%@&input=%@",BASE_KEY,strSearch1];
            if (_txt_city.text.length>0) {
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
    [_txt_city resignFirstResponder];

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
    
 
        
        self.txt_city.text=[NSString stringWithFormat:@"%@",cityStr];
    
      self.txt_zip.text=[NSString stringWithFormat:@"%@",strpostalcode];
        [self setMainView];
        
     
   self.tblCity.hidden=YES;
   
}

-(void) viewWillDisappear:(BOOL)animated
{
    dictAddBranch = [[NSMutableDictionary alloc]init];
}

-(void)viewDidAppear:(BOOL)animated{
    
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)viewDidUnload{
    
}


- (BOOL) shouldAutomaticallyForwardAppearanceMethods
{
    return NO;
}

- (BOOL) validatePanCardNumber: (NSString *) cardNumber {
    NSString *emailRegex = @"^[A-Z]{5}[0-9]{4}[A-Z]$";
    NSPredicate *cardTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [cardTest evaluateWithObject:cardNumber];
}
- (IBAction)btn_coneinueAction:(id)sender

{
    
    
    

    if([[objComMehod spacecheck:_txt_companyName.text] isEqualToString:@"0"]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter compay name." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else if([[objComMehod spacecheck:_txt_comp_address.text] isEqualToString:@"0"]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter compay address." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else if([[objComMehod spacecheck:_txt_city.text] isEqualToString:@"0"]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter city." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if([[objComMehod spacecheck:_txt_zip.text] isEqualToString:@"0"]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter pincode." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else if([[objComMehod spacecheck:_txtPanNumber.text] isEqualToString:@"0"]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter PAN number." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
        
    else if([self validatePanCardNumber:_txtPanNumber.text]==NO){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter a valid PAN number." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }
    else if(selectImg1 == nil){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please select License Image." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if(selectImg2 == nil){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please select Cancle Cheque Image." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    
    
    
    else{
        
        
        [objappShareManager.carrierSignupDict setObject:_txt_companyName.text forKey:@"companyName"];
        
        [objappShareManager.carrierSignupDict setObject:_txt_comp_address.text forKey:@"comp_address"];
        
         [objappShareManager.carrierSignupDict setObject:_txtPanNumber.text forKey:@"pan_number"];
        
        
       // [objappShareManager.carrierSignupDict setObject:_txtCstNumber.text forKey:@"cst_number"];
       [objappShareManager.carrierSignupDict setObject:_txt_city.text forKey:@"city"];
        [objappShareManager.carrierSignupDict setObject:_txt_zip.text forKey:@"zip"];
       // [objappShareManager.carrierSignupDict setObject:_txt_license_number.text forKey:@"license_numbe"];
        
        dictAddBranch =  [[NSMutableDictionary alloc]initWithObjects:@[_txt_comp_address.text,_txt_city.text,_txt_zip.text] forKeys:@[@"address",@"city",@"zipcode"]];
        
        [objappShareManager.arrAddBranch addObject:dictAddBranch.mutableCopy];
        
         [objappShareManager.carrierSignupDict setObject:selectImg1 forKey:@"imageLicense"];
         [objappShareManager.carrierSignupDict setObject:selectImg2 forKey:@"imageCancleCheque"];
        NSLog(@"Final Array:%@",objappShareManager.arrAddBranch);

        
        
//    [[NSNotificationCenter defaultCenter]
//     postNotificationName:@"VehicalSet"
//     object:nil];
        
        carrier_page3_vc  *objviewController =(carrier_page3_vc *) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"carrier_page3_vc"];
        
        
        [APPDATA pushNewViewController:objviewController];
        

        
    }
}

- (IBAction)btnAddBranchAction:(id)sender {
    
        
    AddBranchViewController *controller2 =(AddBranchViewController *) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:
                                                                       @"AddBranchViewController"];
    
    
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

- (IBAction)btnViewBranchAction:(id)sender {
    
    ViewBranchViewController *controller2 =(ViewBranchViewController *) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:
                                                                       @"ViewBranchViewController"];
    
    
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

- (IBAction)btnBackAction:(id)sender {
    
//    [[NSNotificationCenter defaultCenter]
//     postNotificationName:@"backPage"
//     object:nil];
//
    [self.navigationController popViewControllerAnimated:YES];

}

- (IBAction)imgLicense:(id)sender {
    UIButton *button = (UIButton *)sender;
    btntag = button.tag;
    
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
    
    
    
    // UIImage *small = [UIImage imageWithCGImage:selectImg.CGImage scale:0.25     orientation:selectImg.imageOrientation];
    if (btntag==1) {
        selectImg1 = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        [_btnLicenseImgOut setBackgroundImage:selectImg1 forState:UIControlStateNormal];
        _imgLicensePlace.hidden=YES;
        //imageData1 = UIImageJPEGRepresentation(selectImg1, 0.25);
    }
    if(btntag==2)
    {
         selectImg2 = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        [_btnCancleChequeImg setBackgroundImage:selectImg2 forState:UIControlStateNormal];
         _imgCanclePlace.hidden=YES;
       // imageData2 = UIImageJPEGRepresentation(selectImg2, 0.25);
        
    }
    
    
    
    
}


@end
