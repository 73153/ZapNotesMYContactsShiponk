//
//  New_shipment_page2.m
//  ShiponK
//
//  Created by bhavik on 5/25/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import "New_shipment_page2.h"
#import "appShareManager.h"
#import "ComMehod.h"
#import "Base_New_Shipment.h"
#import "otherAdditemViewController.h"
#import "animalAdditemViewController.h"
#import "heavystuffAdditemViewController.h"
#import "householdAndFreightAdditemViewController.h"
#import "vehicleAdditemViewController.h"
#import "SlideNavigationController.h"
#import "New_shipment_page1.h"
#import "ApplicationData.h"
#import "Shipment_Category_ViewController.h"

@interface New_shipment_page2 ()<UITextViewDelegate>
{
    appShareManager *objappShareManager;
    ComMehod *objComMehod;
    NSString* fullPathToFile2;
    int index;
}
@end

@implementation New_shipment_page2
@synthesize add_iteam_mut_arr;
- (void)viewDidLoad
{
    [super viewDidLoad];
    index = 0;
    self.viewAddanItemOut.hidden = YES;
    [_scrlviewAddAnItemOut setContentSize:CGSizeMake(0, ViewPlag.frame.size.height)];
    self.viewItemConstraintsOut .layer.cornerRadius = 8.0;
    
    objComMehod = [[ComMehod alloc]init];
    objappShareManager = [appShareManager sharedManager];
    
  objappShareManager.addAnItemArray2 = [[NSMutableArray alloc]init];
    
    _txt_view_description_out.contentInset = UIEdgeInsetsMake(4,5,0,0);
    _txt_view_description_out.textAlignment = NSTextAlignmentLeft;
    
    _txt_view_description_out.text = @" DESCRIPTION";
    _txt_view_description_out.textColor = [UIColor lightGrayColor];
    _txt_view_description_out.delegate = self;
    
    UITapGestureRecognizer *singletap = [[UITapGestureRecognizer alloc]
                                         initWithTarget:self
                                         action:@selector(singleTap)];
    singletap.numberOfTapsRequired = 1;
    singletap.numberOfTouchesRequired = 1;
    
    [_scrlviewAddAnItemOut addGestureRecognizer:singletap];
    
   
//     [_btnMenu addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleLeftMenu) forControlEvents:UIControlEventTouchUpInside];
    
    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(AddItemNotification)
//                                                 name:@"AddItem"
//                                               object:nil];
    
    //    [objotherAdditemViewController.view setFrame:CGRectMake(0,0,objotherAdditemViewController.view.frame.size.width,objotherAdditemViewController.view.frame.size.height)];
    
    [self AddItemNotification];
    
    
}
//-(void)viewDidDisappear:(BOOL)animated
//{
//    _lblFistSelect.hidden=NO;
//    
//   
//    _txt_view_description_out.text = @"  Comment";
//    _txt_view_description_out.textColor = [UIColor lightGrayColor];
//    
//   UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
//    
//  
//    if ([objappShareManager.catagoryIdStrForAdditem isEqualToString:@"1"] || [objappShareManager.catagoryIdStrForAdditem isEqualToString:@"9"] || [objappShareManager.catagoryIdStrForAdditem isEqualToString:@"27"]) {
//        
//        householdAndFreightAdditemViewController *objotherAdditemViewController= (householdAndFreightAdditemViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"householdAndFreightAdditemViewController"];
//        
//        [objotherAdditemViewController removeFromParentViewController];
//        
//        [objotherAdditemViewController didMoveToParentViewController:nil];
//        
//
//        
//    }
//    else if ([objappShareManager.catagoryIdStrForAdditem isEqualToString:@"4"]) {
//        
//        animalAdditemViewController *objotherAdditemViewController= (animalAdditemViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"animalAdditemViewController"];
//        
//        [objotherAdditemViewController removeFromParentViewController];
//        
//        [objotherAdditemViewController didMoveToParentViewController:nil];
//        
//
//        }
//    else if([objappShareManager.catagoryIdStrForAdditem isEqualToString:@"7"])
//    {
//        heavystuffAdditemViewController *objotherAdditemViewController= (heavystuffAdditemViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"heavystuffAdditemViewController"];
//        
//        [objotherAdditemViewController removeFromParentViewController];
//        
//        [objotherAdditemViewController didMoveToParentViewController:nil];
//        
//
//        
//    }
//    else if ([objappShareManager.catagoryIdStrForAdditem isEqualToString:@"8"])
//    {
//        vehicleAdditemViewController *objotherAdditemViewController= (vehicleAdditemViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"vehicleAdditemViewController"];
//        [objotherAdditemViewController removeFromParentViewController];
//        
//        [objotherAdditemViewController didMoveToParentViewController:nil];
//        
//
//        
//    }
//    else if ([objappShareManager.catagoryIdStrForAdditem isEqualToString:@"10"])
//    {
//        otherAdditemViewController *objotherAdditemViewController= (otherAdditemViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"otherAdditemViewController"];
//        
//        [objotherAdditemViewController removeFromParentViewController];
//        
//        [objotherAdditemViewController didMoveToParentViewController:nil];
//        
//     
//    }
//    for (UIView *view in [ViewPlag subviews])
//    {
//        [view removeFromSuperview];
//    }
//    
//    
//    objappShareManager.catagoryIdStrForAdditem=[[NSString alloc]init];
//   
//
//}
-(void)AddItemNotification
{
    
    _lblFistSelect.hidden=YES;
    
     UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
    if ([objappShareManager.catagoryIdStrForAdditem isEqualToString:@"1"] || [objappShareManager.catagoryIdStrForAdditem isEqualToString:@"9"] || [objappShareManager.catagoryIdStrForAdditem isEqualToString:@"27"]) {
        
        householdAndFreightAdditemViewController *objotherAdditemViewController= (householdAndFreightAdditemViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"householdAndFreightAdditemViewController"];
        
        [self addChildViewController:objotherAdditemViewController];
        [ViewPlag addSubview:objotherAdditemViewController.view];
        [objotherAdditemViewController didMoveToParentViewController:self];
        
        objotherAdditemViewController.btnDone.hidden =YES;
        objotherAdditemViewController.btnClose.hidden =YES;
        
        [objotherAdditemViewController.viewAdditem setFrame:CGRectMake(objotherAdditemViewController.viewAdditem.frame.origin.x, -objotherAdditemViewController.viewHeader.frame.size.height, objotherAdditemViewController.viewAdditem.frame.size.width, objotherAdditemViewController.viewAdditem.frame.size.height)];
         objotherAdditemViewController.viewHeader.hidden=YES;

        
    }
    else if ([objappShareManager.catagoryIdStrForAdditem isEqualToString:@"4"]) {
        
          animalAdditemViewController *objotherAdditemViewController= (animalAdditemViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"animalAdditemViewController"];

       [self addChildViewController:objotherAdditemViewController];
       [ViewPlag addSubview:objotherAdditemViewController.view];
       [objotherAdditemViewController didMoveToParentViewController:self];

    objotherAdditemViewController.btnDone.hidden =YES;
        objotherAdditemViewController.btnClose.hidden =YES;
    
    [objotherAdditemViewController.viewAdditem setFrame:CGRectMake(objotherAdditemViewController.viewAdditem.frame.origin.x, -objotherAdditemViewController.viewHeader.frame.size.height, objotherAdditemViewController.viewAdditem.frame.size.width, objotherAdditemViewController.viewAdditem.frame.size.height)];
         objotherAdditemViewController.viewHeader.hidden=YES;
    }
//    else if([objappShareManager.catagoryIdStrForAdditem isEqualToString:@"7"])
//    {
//        heavystuffAdditemViewController *objotherAdditemViewController= (heavystuffAdditemViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"heavystuffAdditemViewController"];
//        
//        [self addChildViewController:objotherAdditemViewController];
//        [ViewPlag addSubview:objotherAdditemViewController.view];
//        [objotherAdditemViewController didMoveToParentViewController:self];
//        
//        objotherAdditemViewController.btnDone.hidden =YES;
//        objotherAdditemViewController.btnClose.hidden =YES;
//        
//        [objotherAdditemViewController.viewAdditem setFrame:CGRectMake(objotherAdditemViewController.viewAdditem.frame.origin.x, -objotherAdditemViewController.viewHeader.frame.size.height, objotherAdditemViewController.viewAdditem.frame.size.width, objotherAdditemViewController.viewAdditem.frame.size.height)];
//        
//    }
    else if ([objappShareManager.catagoryIdStrForAdditem isEqualToString:@"8"])
    {
        vehicleAdditemViewController *objotherAdditemViewController= (vehicleAdditemViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"vehicleAdditemViewController"];
        
        [self addChildViewController:objotherAdditemViewController];
        [ViewPlag addSubview:objotherAdditemViewController.view];
        [objotherAdditemViewController didMoveToParentViewController:self];
        
        objotherAdditemViewController.btnDone.hidden =YES;
        objotherAdditemViewController.btnClose.hidden =YES;
        
        [objotherAdditemViewController.viewAdditem setFrame:CGRectMake(objotherAdditemViewController.viewAdditem.frame.origin.x, -objotherAdditemViewController.viewHeader.frame.size.height, objotherAdditemViewController.viewAdditem.frame.size.width, objotherAdditemViewController.viewAdditem.frame.size.height)];
        objotherAdditemViewController.viewHeader.hidden=YES;
    }
    else if ([objappShareManager.catagoryIdStrForAdditem isEqualToString:@"10"])
    {
        otherAdditemViewController *objotherAdditemViewController= (otherAdditemViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"otherAdditemViewController"];
        
        [self addChildViewController:objotherAdditemViewController];
        [ViewPlag addSubview:objotherAdditemViewController.view];
        [objotherAdditemViewController didMoveToParentViewController:self];
        
        objotherAdditemViewController.btnDone.hidden =YES;
        objotherAdditemViewController.btnClose.hidden =YES;
        
        [objotherAdditemViewController.viewAdditem setFrame:CGRectMake(objotherAdditemViewController.viewAdditem.frame.origin.x, -objotherAdditemViewController.viewHeader.frame.size.height, objotherAdditemViewController.viewAdditem.frame.size.width, objotherAdditemViewController.viewAdditem.frame.size.height)];
         objotherAdditemViewController.viewHeader.hidden=YES;
    }

    
}

- (void)singleTap
{
    _viewAddanItemOut.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, .3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        
      _viewAddanItemOut.hidden = YES;
        
        
    });
    
    
    [UIView animateWithDuration:0.3/1.5 animations:^{
        _viewAddanItemOut.transform=CGAffineTransformScale(CGAffineTransformIdentity,.9,0.9);
        
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3/2 animations:^{
            _viewAddanItemOut.transform=CGAffineTransformScale(CGAffineTransformIdentity,0.001,0.001);
            
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/2 animations:^{
                _viewAddanItemOut.transform=CGAffineTransformIdentity;
                
                
            }];
        }];
    }];

    
   
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.viewAddanItemOut endEditing:YES];
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
    CGPoint scrollPoint = CGPointMake(0,textView.frame.origin.y-textView.frame.size.height);
    [_mainScrollView setContentOffset:scrollPoint animated:YES];
    
    if ([textView.text isEqualToString:@" DESCRIPTION"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor]; //optional
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text =@" DESCRIPTION";
        textView.textColor = [UIColor lightGrayColor]; //optional
    }
    [textView resignFirstResponder];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(cleanTextfield)
                                                 name:@"cleanTextfield2" object:nil];
    
    
}
-(void)cleanTextfield
{
    
    self.txt_view_description_out.text = NULL;
    self.txt_shipment_title_out.text = NULL;
}


    

- (IBAction)btn_add_an_item_act:(id)sender
{
    self.viewAddanItemOut.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    
    self.viewAddanItemOut.hidden = NO;

    
    [UIView animateWithDuration:0.3/1.5 animations:^{
        self.viewAddanItemOut.transform=CGAffineTransformScale(CGAffineTransformIdentity,1.1,1.1);
        
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3/2 animations:^{
            self.viewAddanItemOut.transform=CGAffineTransformScale(CGAffineTransformIdentity,0.9,0.9);
            
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/2 animations:^{
                self.viewAddanItemOut.transform=CGAffineTransformIdentity;
                
                
            }];
        }];
    }];

    
}

- (IBAction)btn_continue_act:(id)sender
{
    
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,10}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    
    NSString *mobileNumberPattern = @"[789][0-9]{9}";
    NSPredicate *mobileNumberPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileNumberPattern];
    
    
//    if([[objComMehod spacecheck:_txt_view_description_out.text]isEqualToString:@"0"] || [_txt_view_description_out.text isEqualToString:@" DESCRIPTION"])
//    {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter shipment Description." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//    }
//    else
        if ([emailTest evaluateWithObject:_txt_view_description_out.text]==YES || [mobileNumberPred evaluateWithObject:_txt_view_description_out.text]==YES)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter Proper Description." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
  
    else
    {
        
        
        if ([objappShareManager.catagoryIdStrForAdditem isEqualToString:@"1"] || [objappShareManager.catagoryIdStrForAdditem isEqualToString:@"9"] || [objappShareManager.catagoryIdStrForAdditem isEqualToString:@"27"]) {
            
         
            
        
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"AddItemForhouseholdAndFreightAdditemVC" object:nil userInfo:@{ @"nextPage" : @"YES" }];
            
  
 
            
            
        }
        else if ([objappShareManager.catagoryIdStrForAdditem isEqualToString:@"4"]) {
            
 
            [[NSNotificationCenter defaultCenter] postNotificationName:@"AddItemForAnimalAdditemVC" object:nil userInfo:@{ @"nextPage" : @"YES" }];
            


            
        }
//        else if([objappShareManager.catagoryIdStrForAdditem isEqualToString:@"7"])
//        {
//            
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"AddItemForHeavystuffAdditemVC" object:nil];
//            
//            
//            
//            
//        }
        else if ([objappShareManager.catagoryIdStrForAdditem isEqualToString:@"8"])
        {
    
            [[NSNotificationCenter defaultCenter] postNotificationName:@"AddItemForVehicleAdditemVC" object:nil userInfo:@{ @"nextPage" : @"YES" }];
            
   
        }
        else if ([objappShareManager.catagoryIdStrForAdditem isEqualToString:@"10"])
        {
            
          
            [[NSNotificationCenter defaultCenter] postNotificationName:@"AddItemForotherAdditemVC" object:nil userInfo:@{ @"nextPage" : @"YES" }];
         

            
            
            
        }

        
      
    
        //[objappShareManager.New_shipment_dic setValue:[NSString stringWithFormat:@"%@", _txt_shipment_title_out.text] forKey:@"title"];
        
        if ([_txt_view_description_out.text isEqualToString:@" DESCRIPTION"]) {
            
             [objappShareManager.New_shipment_dic setValue:[NSString stringWithFormat:@"NO DESCRIPTION"] forKey:@"description"];
        }
        else{
            [objappShareManager.New_shipment_dic setValue:[NSString stringWithFormat:@"%@", _txt_view_description_out.text] forKey:@"description"];
        }
        
        
        [objappShareManager.New_shipment_dic setValue:objappShareManager.addAnItemArray forKey:@"Items"];

        
       

        
    }
    
}
- (IBAction)btnBrowseAct:(id)sender
{
    
    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle:nil
                                message:nil
                                preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* button0 = [UIAlertAction
                              actionWithTitle:@"Cancel"
                              style:UIAlertActionStyleCancel
                              handler:^(UIAlertAction * action)
                              {
                              }];
    
    UIAlertAction* button1 = [UIAlertAction
                              actionWithTitle:@"Take photo"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  UIImagePickerController *imagePickerController= [[UIImagePickerController alloc] init];
                                  imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                                  imagePickerController.delegate = self;
                                  [self presentViewController:imagePickerController animated:YES completion:^{}];
                              }];
    
    UIAlertAction* button2 = [UIAlertAction
                              actionWithTitle:@"Choose Existing"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
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
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    [self.imgviewAddAnItemOut setImage:image];
    
}

- (IBAction)btnDoneAct:(id)sender
{
    if([[objComMehod spacecheck:_txtShipmentNameOut.text]isEqualToString:@"0"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter shipment title." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if([[objComMehod spacecheck:_txtLendthMOut.text]isEqualToString:@"0"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter length." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if([[objComMehod spacecheck:_txtWidthMOut.text]isEqualToString:@"0"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter width." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if([[objComMehod spacecheck:_txtHeightMOut.text]isEqualToString:@"0"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter height." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if([[objComMehod spacecheck:_txtWeightOut.text]isEqualToString:@"0"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter weight." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        
        
        
        NSString *length_m =[NSString stringWithFormat:@"%@", _txtLendthMOut.text];
        NSString *length_cm =[NSString stringWithFormat:@"%@", _txtLengthCMOut.text];
        NSString *width_cm =[NSString stringWithFormat:@"%@", _txtWidthCMOut.text];
        NSString *height_m =[NSString stringWithFormat:@"%@", _txtHeightMOut.text];
        NSString *height_cm =[NSString stringWithFormat:@"%@",  _txtHeightCMOut.text];
        NSString *width_m = [NSString stringWithFormat:@"%@",_txtWidthMOut.text];
        NSString *weight =[NSString stringWithFormat:@"%@",_txtWeightOut.text];
        NSString *qty =[NSString stringWithFormat:@"%@",_txtQtyOut.text];
        
        NSData *imageData = UIImagePNGRepresentation(_imgviewAddAnItemOut.image);
        NSString *imageString = [imageData base64EncodedStringWithOptions:0];
        
        NSString *shipment_title =[NSString stringWithFormat:@"%@", _txtShipmentNameOut.text];
       
        
        
        NSString* length = [NSString stringWithFormat:@"%@.%@",length_m,length_cm];
        NSString * width = [NSString stringWithFormat:@"%@.%@",width_m,width_cm];
        NSString * height = [NSString stringWithFormat:@"%@.%@",height_m,height_cm];
        
        
        NSMutableDictionary *dataDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:shipment_title,@"item_name",length,@"length",width,@"width",height,@"height",weight,@"weight",qty,@"quantity",imageString,@"item_image", nil];
        
        [objappShareManager.addAnItemArray insertObject:dataDic atIndex:index];
        index = index +1;
        
        _txtHeightCMOut.text = NULL;
        _txtHeightMOut.text = NULL;
        _txtLendthMOut.text = NULL;
        _txtLengthCMOut.text = NULL;
        _txtQtyOut.text =NULL;
        _txtShipmentNameOut.text = NULL;
        _txtWeightOut.text = NULL;
        _txtWidthCMOut.text = NULL;
        _txtWidthMOut.text = NULL;
        
        
        _imgviewAddAnItemOut.image = nil;
        _imgviewAddAnItemOut.image = [UIImage imageNamed:@"img_view_img_add_item"];
        
        
        _viewAddanItemOut.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, .3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            
            _viewAddanItemOut.hidden = YES;
            
            
        });
        
        
        [UIView animateWithDuration:0.3/1.5 animations:^{
            _viewAddanItemOut.transform=CGAffineTransformScale(CGAffineTransformIdentity,.9,0.9);
            
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/2 animations:^{
                _viewAddanItemOut.transform=CGAffineTransformScale(CGAffineTransformIdentity,0.001,0.001);
                
            }completion:^(BOOL finished) {
                [UIView animateWithDuration:0.3/2 animations:^{
                    _viewAddanItemOut.transform=CGAffineTransformIdentity;
                    
                    
                }];
            }];
        }];
        
        
    }
}

- (IBAction)btnAdditemAction:(id)sender {
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
    

    if ([objappShareManager.catagoryIdStrForAdditem isEqualToString:@"1"] || [objappShareManager.catagoryIdStrForAdditem isEqualToString:@"9"] || [objappShareManager.catagoryIdStrForAdditem isEqualToString:@"27"]) {
        
        if (objappShareManager.addAnItemArray2.count==0) {
 
            [[NSNotificationCenter defaultCenter] postNotificationName:@"AddItemForhouseholdAndFreightAdditemVC" object:nil userInfo:@{ @"nextPage" : @"NO" }];
            
        }
        if (objappShareManager.addAnItemArray2.count==0)
        {
           
        }
        else
        {
        householdAndFreightAdditemViewController *objotherAdditemViewController= (householdAndFreightAdditemViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"householdAndFreightAdditemViewController"];
        
        objotherAdditemViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
        
        objotherAdditemViewController.imgBG.backgroundColor =[UIColor blackColor];
        objotherAdditemViewController.imgBG.alpha = 0.65;
           
        
        
        
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
    }
    else if ([objappShareManager.catagoryIdStrForAdditem isEqualToString:@"4"]) {
        
        if (objappShareManager.addAnItemArray2.count==0) {
            
            
        [[NSNotificationCenter defaultCenter] postNotificationName:@"AddItemForAnimalAdditemVC" object:nil userInfo:@{ @"nextPage" : @"NO" }];
    
        
        }
        if (objappShareManager.addAnItemArray2.count==0)
        {
            
        }
        else
        {

        animalAdditemViewController *objotherAdditemViewController= (animalAdditemViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"animalAdditemViewController"];
        
        objotherAdditemViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
        
        objotherAdditemViewController.imgBG.backgroundColor =[UIColor blackColor];
        objotherAdditemViewController.imgBG.alpha = 0.65;
        
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
    }
//    else if([objappShareManager.catagoryIdStrForAdditem isEqualToString:@"7"])
//    {
//        
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"AddItemForHeavystuffAdditemVC" object:nil];
//        
//    
//        
//        heavystuffAdditemViewController *objotherAdditemViewController= (heavystuffAdditemViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"heavystuffAdditemViewController"];
//        
//        objotherAdditemViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
//        
//        objotherAdditemViewController.imgBG.backgroundColor =[UIColor blackColor];
//        objotherAdditemViewController.imgBG.alpha = 0.65;
//        
//        [self.view addSubview:objotherAdditemViewController.view];
//        [self addChildViewController:objotherAdditemViewController];
//        [objotherAdditemViewController didMoveToParentViewController:self];
//        
//        [UIView animateWithDuration:0.3/1.5 animations:^{
//            objotherAdditemViewController.view.transform=CGAffineTransformScale(CGAffineTransformIdentity,1.1,1.1);
//            
//        }completion:^(BOOL finished) {
//            [UIView animateWithDuration:0.3/2 animations:^{
//                objotherAdditemViewController.view.transform=CGAffineTransformScale(CGAffineTransformIdentity,0.9,0.9);
//                
//            }completion:^(BOOL finished) {
//                [UIView animateWithDuration:0.3/2 animations:^{
//                    objotherAdditemViewController.view.transform=CGAffineTransformIdentity;
//                    
//                }];
//            }];
//        }];
//        
//    }
    else if ([objappShareManager.catagoryIdStrForAdditem isEqualToString:@"8"])
    {
        
        
        if (objappShareManager.addAnItemArray2.count==0) {
            
            
          [[NSNotificationCenter defaultCenter] postNotificationName:@"AddItemForVehicleAdditemVC" object:nil userInfo:@{ @"nextPage" : @"NO" }];
        }
        if (objappShareManager.addAnItemArray2.count==0)
        {
            
        }
        else
        {

        vehicleAdditemViewController *objotherAdditemViewController= (vehicleAdditemViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"vehicleAdditemViewController"];
        
        objotherAdditemViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
        
        objotherAdditemViewController.imgBG.backgroundColor =[UIColor blackColor];
        objotherAdditemViewController.imgBG.alpha = 0.65;
        
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
        
    }
    else if ([objappShareManager.catagoryIdStrForAdditem isEqualToString:@"10"])
    {
        
        if (objappShareManager.addAnItemArray2.count==0) {
            
            
        [[NSNotificationCenter defaultCenter] postNotificationName:@"AddItemForotherAdditemVC" object:nil userInfo:@{ @"nextPage" : @"NO" }];
        
    
        }
        if (objappShareManager.addAnItemArray2.count==0)
        {
            
        }
        else
        {

        
        otherAdditemViewController *objotherAdditemViewController= (otherAdditemViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"otherAdditemViewController"];
        objotherAdditemViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
        
        objotherAdditemViewController.imgBG.backgroundColor =[UIColor blackColor];
        objotherAdditemViewController.imgBG.alpha = 0.65;
        
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
    }

    
    
}
- (IBAction)btnBackAction:(id)sender {
    
    
    Shipment_Category_ViewController *objviewController =(Shipment_Category_ViewController *) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"Shipment_Category_ViewController"];
    
    
    [APPDATA pushNewViewController:objviewController];
    
//    [[NSNotificationCenter defaultCenter]
//     postNotificationName:@"backPage"
//     object:nil];
//
    
}

- (IBAction)btnHomeAction:(id)sender {
    
    Shipment_Category_ViewController *objviewController =(Shipment_Category_ViewController *) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"Shipment_Category_ViewController"];
    
    
    [APPDATA pushNewViewController:objviewController];
    
}

@end
