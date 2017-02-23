//
//  New_shipment_page4.m
//  ShiponK
//
//  Created by Bhushan on 5/30/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//
#import "LeftMenuViewController.h"
#import "New_shipment_page4.h"
#import "carrier_page6_vc.h"
#import "appShareManager.h"
#import "Constant.h"
#import "ApplicationData.h"
#import "ComMehod.h"
#import "DashbordViewController.h"
#import "NewshipmentViewController.h"
#import "Base_New_Shipment.h"

#import "MyShipment_ViewController.h"
#import "New_shipment_page2.h"

@interface New_shipment_page4 ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>
{
    int btn_tag;
    appShareManager *objappShareManager;
    ComMehod *objComMehod;
    NSMutableDictionary *parameter;
    UIImage *itemImg;
    NSMutableArray *Shipment_img_dataArr;
    int IndexOfArray;
    
}
@end

@implementation New_shipment_page4

- (void)viewDidLoad {
    [super viewDidLoad];
    Shipment_img_dataArr = [[NSMutableArray alloc]init];
    objComMehod = [[ComMehod alloc]init];
    objappShareManager = [appShareManager sharedManager];
    IndexOfArray = 0;
    parameter = [[NSMutableDictionary alloc]init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)btn_img1_act:(id)sender
{
    btn_tag = 0;
    [self image_pick];
    btn_tag  = 1;
}
- (IBAction)btn_img2_act:(id)sender
{
    btn_tag = 0;
    [self image_pick];
    btn_tag  = 2;
}
- (IBAction)btn_img3_act:(id)sender
{
    btn_tag = 0;
    [self image_pick];
    btn_tag  = 3;
}

- (IBAction)btn_img4_act:(id)sender
{
    btn_tag = 0;
    [self image_pick];
    btn_tag = 4;
    //btn_tag  = 4;
}
- (IBAction)btn_submit_act:(id)sender
{
    
    
    [APPDATA showLoader];
    
    NSString *strcategoryId =  [objappShareManager.New_shipment_dic valueForKey:@"category_id"];
    NSString *strsubcategoryId = [objappShareManager.New_shipment_dic valueForKey:@"sub_category_id"];
    NSString *strfromCity = [objappShareManager.New_shipment_dic valueForKey:@"from_city"];
    NSString *strtoCity = [objappShareManager.New_shipment_dic valueForKey:@"to_city"];
    NSString *strneedPackage = [objappShareManager.New_shipment_dic valueForKey:@"need_packaged"];
    NSString *strisUrgent = [objappShareManager.New_shipment_dic valueForKey:@"is_urgent"];
    NSString *strTitle = [objappShareManager.New_shipment_dic valueForKey:@"title"];
    NSString *strDescription = [objappShareManager.New_shipment_dic valueForKey:@"description"];
 
    NSString *strpickup_earliest_date = [objappShareManager.New_shipment_dic valueForKey:@"pickup_earliest_date"];
    NSString *strpickup_latest_date = [objappShareManager.New_shipment_dic valueForKey:@"pickup_latest_date"];
    NSString *strdelievery_earliest_date = [objappShareManager.New_shipment_dic valueForKey:@"delievery_earliest_date"];
    NSString *strdelievery_latest_date = [objappShareManager.New_shipment_dic valueForKey:@"delievery_latest_date"];
   
    NSString *strpickuplocation = [NSString stringWithFormat:@"%@",objappShareManager.pickResid];
    NSString * strdelivlocation = [NSString stringWithFormat:@"%@",objappShareManager.DeliResid];

    
    
    
    NSString *str_uid =[NSString stringWithFormat:@"%@",[objappShareManager.loginDic valueForKey:@"user_id"]];
    
    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:objappShareManager.addAnItemArray options:0 error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSString *strAddAnItem=[NSString stringWithFormat:@"%@",jsonString];
    
    
    NSCharacterSet *charsToTrim = [NSCharacterSet characterSetWithCharactersInString:@"()"];
    NSString *str = [strAddAnItem stringByTrimmingCharactersInSet:charsToTrim];
    
    str = [[str componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]]componentsJoinedByString:@""];
    
    str=[[str stringByReplacingOccurrencesOfString:@")" withString:@""] stringByReplacingOccurrencesOfString:@"(" withString:@""];
    
    str=[[str stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    
    
    
    NSData* jsonData1 = [NSJSONSerialization dataWithJSONObject:Shipment_img_dataArr options:0 error:nil];
    NSString *jsonString1 = [[NSString alloc] initWithData:jsonData1 encoding:NSUTF8StringEncoding];
    
    NSString *strAddAnItem1=[NSString stringWithFormat:@"%@",jsonString1];
    
    
    
    
    NSCharacterSet *charsToTrim1 = [NSCharacterSet characterSetWithCharactersInString:@"()"];
    NSString *str1 = [strAddAnItem1 stringByTrimmingCharactersInSet:charsToTrim1];
    
    str1 = [[str1 componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]]componentsJoinedByString:@""];
    
    str1=[[str1 stringByReplacingOccurrencesOfString:@")" withString:@""] stringByReplacingOccurrencesOfString:@"(" withString:@""];
    
    str1=[[str1 stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    
    
    
    [parameter setValue:str_uid forKey:@"user_id"];
    [parameter setValue:strTitle forKey:@"title"];
    [parameter setValue:strcategoryId forKey:@"category_id"];
    [parameter setValue:strsubcategoryId forKey:@"sub_category_id"];
    [parameter setValue:strfromCity forKey:@"from_city"];
    [parameter setValue:strtoCity forKey:@"to_city"];
    [parameter setValue:strpickuplocation forKey:@"pickup_location"];
    [parameter setValue:strdelivlocation forKey:@"delievery_location"];
    [parameter setValue:strDescription forKey:@"description"];
    [parameter setValue:strisUrgent forKey:@"is_urgent"];
    [parameter setValue:strneedPackage forKey:@"need_packaged"];
    [parameter setValue:str forKey:@"items"];
    [parameter setValue:str1 forKey:@"shipment_image"];
    
    [parameter setValue:strpickup_earliest_date forKey:@"pickup_earliest_date"];
    [parameter setValue:strpickup_latest_date forKey:@"pickup_latest_date"];
    [parameter setValue:strdelievery_earliest_date forKey:@"delievery_earliest_date"];
    [parameter setValue:strdelievery_latest_date forKey:@"delievery_latest_date"];
    
    
    void (^successed)(id responseObject) = ^(id responseObject)
    {
        NSLog(@"%@",responseObject);
        
        
        objappShareManager.New_shipment_dic=nil;
        objappShareManager.addAnItemArray = nil;
        
        
        
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"cleanTextfield1"
         object:nil];
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"cleanTextfield2"
         object:nil];
        
        self.img_view_1.image = NULL;
        self.img_view_2.image = NULL;
        self.img_view_3.image = NULL;
        self.img_view_4.image = NULL;
        self.imgPlaceHolder1.image = [UIImage imageNamed:@"img_view_img_add_item"];
        self.imgPlaceholder2.image = [UIImage imageNamed:@"img_view_img_add_item"];
        self.imgPlaceholder3.image = [UIImage imageNamed:@"img_view_img_add_item"];
        self.imgPlaceholder4.image = [UIImage imageNamed:@"img_view_img_add_item"];
        
        
        [APPDATA hideLoader];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sucess"
                                                        message:@"Shipment Created Sucessfully"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        
        [alert show];
        
        
        MyShipment_ViewController *objMyShipment_ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MyShipment_ViewController"];
        [APPDATA pushNewViewController:objMyShipment_ViewController];
        
    };
    
    void (^failure)(NSError * error) = ^(NSError *error)
    {
        [APPDATA hideLoader];
        NSLog(@"%@",error);
    };
    
    
    
    
    
    [ApiCall sendToService:API_CREATE_SHIPMENT andDictionary:parameter success:successed failure:failure];
    
    
    
    
    
    
}



#pragma mark image picker ........

-(void)image_pick
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
    UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    if(btn_tag == 1)
    {
        _imgPlaceHolder1.image = NULL;
        [self.img_view_1 setImage:img];
        NSData *imageData = UIImagePNGRepresentation(_img_view_1.image);
        NSString *imageString = [imageData base64EncodedStringWithOptions:0];
        
        NSMutableDictionary *dataDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:imageString,@"shipment_image", nil];
        [Shipment_img_dataArr insertObject:dataDic atIndex:IndexOfArray];
        IndexOfArray = IndexOfArray +1;
    }
    else if(btn_tag == 2)
    {
        
        _imgPlaceholder2.image = NULL;
        [self.img_view_2 setImage:img];
        NSData *imageData = UIImagePNGRepresentation(_img_view_2.image);
        NSString *imageString = [imageData base64EncodedStringWithOptions:0];
        
        NSMutableDictionary *dataDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:imageString,@"shipment_image", nil];
        [Shipment_img_dataArr insertObject:dataDic atIndex:IndexOfArray];
        IndexOfArray = IndexOfArray +1;

        
    }
    else if(btn_tag == 3)
    {
        _imgPlaceholder3.image = NULL;
        [self.img_view_3 setImage:img];
        NSData *imageData = UIImagePNGRepresentation(_img_view_3.image);
        NSString *imageString = [imageData base64EncodedStringWithOptions:0];
        
        NSMutableDictionary *dataDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:imageString,@"shipment_image", nil];
        [Shipment_img_dataArr insertObject:dataDic atIndex:IndexOfArray];
        IndexOfArray = IndexOfArray +1;
        
    }
    else if(btn_tag == 4)
    {
        
        _imgPlaceholder4.image = NULL;
        [self.img_view_4 setImage:img];
        NSData *imageData = UIImagePNGRepresentation(_img_view_4.image);
        NSString *imageString = [imageData base64EncodedStringWithOptions:0];
        
        NSMutableDictionary *dataDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:imageString,@"shipment_image", nil];
        [Shipment_img_dataArr insertObject:dataDic atIndex:IndexOfArray];
        IndexOfArray = IndexOfArray +1;
        
    }
    
}
@end