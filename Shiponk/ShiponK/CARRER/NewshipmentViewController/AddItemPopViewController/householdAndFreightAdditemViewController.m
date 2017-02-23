//
//  householdAndFreightAdditemViewController.m
//  ShiponK
//
//  Created by datt on 06/04/1938 SAKA.
//  Copyright © 1938 SAKA com.zaptechsolution. All rights reserved.
//

#import "householdAndFreightAdditemViewController.h"
#import "appShareManager.h"
#import "ComMehod.h"
#import "New_shipment_page1.h"
#import "ApplicationData.h"


@interface householdAndFreightAdditemViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate>
{
    UIImage *selectImg1,*selectImg2,*selectImg3,*selectImg4;
    NSData *imageData1,*imageData2,*imageData3,*imageData4;
    appShareManager *objappShareManager;
     ComMehod *objComMehod;
    NSInteger btntag;
}


@end

@implementation householdAndFreightAdditemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    objappShareManager =[appShareManager sharedManager];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(AddItemNotification:)
                                                 name:@"AddItemForhouseholdAndFreightAdditemVC"
                                               object:nil];
    // Do any additional setup after loading the view.
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    
    if (textField.tag==3) {
        if(range.length + range.location > textField.text.length)
        {
            return NO;
        }
        
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return newLength <= 4;
    }
    else if (textField.tag==5)
    {
        if(range.length + range.location > textField.text.length)
        {
            return NO;
        }
        
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return newLength <= 2;
    }else if (textField.tag==9)
    {
        if(range.length + range.location > textField.text.length)
        {
            return NO;
        }
        
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return newLength <= 3;
        
    }
    else
    {
        return NO;
    }
  
}
-(void)AddItemNotification:(NSNotification *)n
{
   
    
    
    if([[objComMehod spacecheck:_txtItemTitle.text]isEqualToString:@"0"] || _txtItemTitle.text.length<1)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter Item Title." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
//    else if(selectImg1==NULL)
//    {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please Select Img." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//    }
    else if([[objComMehod spacecheck:_txtLengthM.text]isEqualToString:@"0"] || _txtLengthM.text.length<1)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter Length." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if([[objComMehod spacecheck:_txtWidthM.text]isEqualToString:@"0"] || _txtWidthM.text.length<1)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter Width." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if([[objComMehod spacecheck:_txtHeightM.text]isEqualToString:@"0"] || _txtHeightM.text.length<1)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter Height." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
//    else if([[objComMehod spacecheck:_txtQty.text]isEqualToString:@"0"] || _txtQty.text.length<1)
//    {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter Quantity." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//    }
    else if([[objComMehod spacecheck:_txtWeight.text]isEqualToString:@"0"] || _txtWeight.text.length<1)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter Weight." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        
        // UIImage *img = [UIImage imageNamed:@"left-bg.png"];
        //NSData *data = UIImagePNGRepresentation(selectImg);
        
        NSMutableArray *arr=[[NSMutableArray alloc]init];
        
        
        if (imageData1!=nil) {
            NSString *basestr1 =  [imageData1 base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
            NSDictionary *dic1= @{@"name" : basestr1};
            [arr addObject:dic1];
        }
        
        if (imageData2!=nil) {
            NSString *basestr2 = [imageData2 base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
            NSDictionary *dic2= @{@"name" : basestr2};
            [arr addObject:dic2];
        }
         if(imageData3!=nil)
        {
            NSString *basestr3 = [imageData3 base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
            NSDictionary *dic3= @{@"name" : basestr3};
            
            [arr addObject:dic3];
        }
         if(imageData4!=nil)
        {
            NSString *basestr4 = [imageData4 base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
            
            NSDictionary *dic4= @{@"name" : basestr4};
            
            [arr addObject:dic4];
        }
        
        
        
        
        NSDictionary *dic=@{@"images" : arr};
        
        NSString *strLengthM=[NSString stringWithFormat:@"%@",_txtLengthM.text];
        NSString *strWidthM=[NSString stringWithFormat:@"%@",_txtWidthM.text];
        NSString *strHeightM=[NSString stringWithFormat:@"%@",_txtHeightM.text];
        
        
        NSString *strLengthCM=[NSString stringWithFormat:@"%@",_txtLengthCM.text];
        NSString *strWidthCM=[NSString stringWithFormat:@"%@",_txtWidthCM.text];
        NSString *strHeightCM=[NSString stringWithFormat:@"%@",_txtHeightCM.text];
        
        
        if ([strLengthCM length]<1 && [strLengthM length]<1 ) {
            
            strLengthM=[NSString stringWithFormat:@"--"];

            strLengthCM=[NSString stringWithFormat:@" "];

        }
        else if ([strLengthCM length]<1) {
            
            strLengthCM=[NSString stringWithFormat:@"00"];
            
        }

        
        if ([strHeightCM length]<1 && [strHeightM length]<1 ) {
            
            strHeightM=[NSString stringWithFormat:@"--"];
            
            strHeightCM=[NSString stringWithFormat:@" "];
            
        }
        else if ([strHeightCM length]<1) {
            
            strHeightCM=[NSString stringWithFormat:@"00"];
            
        }
        
        
        if ([strWidthCM length]<1 && [strWidthM length]<1 ) {
            
            strWidthM=[NSString stringWithFormat:@"--"];
            
            strWidthCM=[NSString stringWithFormat:@" "];
            
        }
        else if ([strWidthCM length]<1) {
            
            strWidthCM=[NSString stringWithFormat:@"00"];
            
        }

        NSString *strWeight=[NSString stringWithFormat:@"%@",_txtWeight.text];
        NSString *strQty=[NSString stringWithFormat:@"%@",_txtQty.text];
        
       
        if ([strQty length]<1) {
            
            strQty=[NSString stringWithFormat:@"1"];
            
        }
        if ([strWeight length]<1) {
            
            strWeight=[NSString stringWithFormat:@"--"];
            
        }
        
        
        NSMutableDictionary *dataDic;
        
        
        if(selectImg1==NULL && selectImg2==NULL && selectImg3==NULL && selectImg4==NULL)
        {
            
              dataDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",_txtItemTitle.text],@"title",[NSString stringWithFormat:@"%@.%@",strLengthM,strLengthCM],@"length",[NSString stringWithFormat:@"%@.%@",strWidthM,strWidthCM],@"width",[NSString stringWithFormat:@"%@.%@",strHeightM,strHeightCM],@"height",[NSString stringWithFormat:@"%@",strQty],@"quantity",[NSString stringWithFormat:@"%@",strWeight],@"weight", nil];
            
        }
        else
        {
        
        dataDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",_txtItemTitle.text],@"title",[NSString stringWithFormat:@"%@.%@",strLengthM,strLengthCM],@"length",[NSString stringWithFormat:@"%@.%@",strWidthM,strWidthCM],@"width",[NSString stringWithFormat:@"%@.%@",strHeightM,strHeightCM],@"height",[NSString stringWithFormat:@"%@",strQty],@"quantity",[NSString stringWithFormat:@"%@",strWeight],@"weight",dic,@"photo", nil];
        
        
        }
        
        
       
        
        // NSLog(@"%@",objappShareManager.addAnItemArray2);
        if ([[NSString stringWithFormat:@"%@",n.userInfo[@"nextPage"]] isEqualToString:@"YES"]){
//            [[NSNotificationCenter defaultCenter]
//             postNotificationName:@"VehicalSet"
//             object:nil];
            
            if (objappShareManager.addAnItemArray2.count==0) {
                [objappShareManager.addAnItemArray2 addObject:dataDic];
                
            }
            else{
                [objappShareManager.addAnItemArray2 replaceObjectAtIndex:0 withObject:dataDic];
            }
            
            New_shipment_page1 *objviewController =(New_shipment_page1 *) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"New_shipment_page1"];
            
            
            [APPDATA pushNewViewController:objviewController];
        }
        else
        {
            [objappShareManager.addAnItemArray2 addObject:dataDic];
        }

        
    }
    
    
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    if (btntag==1) {
        selectImg1 = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        [_btnimgItem setBackgroundImage:selectImg1 forState:UIControlStateNormal];
        
        imageData1 = UIImageJPEGRepresentation(selectImg1, 0.25);
    }
     if(btntag==2)
    {
        selectImg2 = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        [_btnimgItem2 setBackgroundImage:selectImg2 forState:UIControlStateNormal];
        
        imageData2 = UIImageJPEGRepresentation(selectImg2, 0.25);
        
    }
     if(btntag==3)
    {
        selectImg3 = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        [_btnimgItem3 setBackgroundImage:selectImg3 forState:UIControlStateNormal];
        
        imageData3 = UIImageJPEGRepresentation(selectImg3, 0.25);
    }
     if(btntag==4)
    {
        selectImg4 = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        [_btnimgItem4 setBackgroundImage:selectImg4 forState:UIControlStateNormal];
        
        imageData4 = UIImageJPEGRepresentation(selectImg4, 0.25);
    }
    
    
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

- (IBAction)btnItemimgAction:(id)sender {
    
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

- (IBAction)btnDoneAction:(id)sender {
    
   
    if([[objComMehod spacecheck:_txtItemTitle.text]isEqualToString:@"0"] || _txtItemTitle.text.length<1)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter Item Title." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
//    else if(selectImg1==NULL)
//    {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please Select Img." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//    }
    else if([[objComMehod spacecheck:_txtLengthM.text]isEqualToString:@"0"] || _txtLengthM.text.length<1)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter Length." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if([[objComMehod spacecheck:_txtWidthM.text]isEqualToString:@"0"] || _txtWidthM.text.length<1)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter Width." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if([[objComMehod spacecheck:_txtHeightM.text]isEqualToString:@"0"] || _txtHeightM.text.length<1)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter Height." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if([[objComMehod spacecheck:_txtQty.text]isEqualToString:@"0"] || _txtQty.text.length<1)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter Quantity." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if([[objComMehod spacecheck:_txtWeight.text]isEqualToString:@"0"] || _txtWeight.text.length<1)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter Weight." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        
        // UIImage *img = [UIImage imageNamed:@"left-bg.png"];
       // NSData *data = UIImagePNGRepresentation(selectImg);
        NSMutableArray *arr=[[NSMutableArray alloc]init];
        
        
        if (imageData1!=nil) {
            NSString *basestr1 =  [imageData1 base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
            NSDictionary *dic1= @{@"name" : basestr1};
            [arr addObject:dic1];
        }
        
        if (imageData2!=nil) {
            NSString *basestr2 = [imageData2 base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
            NSDictionary *dic2= @{@"name" : basestr2};
            [arr addObject:dic2];
        }
         if(imageData3!=nil)
        {
            NSString *basestr3 = [imageData3 base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
            NSDictionary *dic3= @{@"name" : basestr3};
            
            [arr addObject:dic3];
        }
         if(imageData4!=nil)
        {
            NSString *basestr4 = [imageData4 base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
            
            NSDictionary *dic4= @{@"name" : basestr4};
            
            [arr addObject:dic4];
        }
        
        
        
        
        NSDictionary *dic=@{@"images" : arr};
        
        
        NSString *strLengthM=[NSString stringWithFormat:@"%@",_txtLengthM.text];
        NSString *strWidthM=[NSString stringWithFormat:@"%@",_txtWidthM.text];
        NSString *strHeightM=[NSString stringWithFormat:@"%@",_txtHeightM.text];
        
        
        NSString *strLengthCM=[NSString stringWithFormat:@"%@",_txtLengthCM.text];
        NSString *strWidthCM=[NSString stringWithFormat:@"%@",_txtWidthCM.text];
        NSString *strHeightCM=[NSString stringWithFormat:@"%@",_txtHeightCM.text];
        
        
        if ([strLengthCM length]<1 && [strLengthM length]<1 ) {
            
            strLengthM=[NSString stringWithFormat:@"--"];
            
            strLengthCM=[NSString stringWithFormat:@" "];
            
        }
        else if ([strLengthCM length]<1) {
            
            strLengthCM=[NSString stringWithFormat:@"00"];
            
        }
        
        
        if ([strHeightCM length]<1 && [strHeightM length]<1 ) {
            
            strHeightM=[NSString stringWithFormat:@"--"];
            
            strHeightCM=[NSString stringWithFormat:@" "];
            
        }
        else if ([strHeightCM length]<1) {
            
            strHeightCM=[NSString stringWithFormat:@"00"];
            
        }
        
        
        if ([strWidthCM length]<1 && [strWidthM length]<1 ) {
            
            strWidthM=[NSString stringWithFormat:@"--"];
            
            strWidthCM=[NSString stringWithFormat:@" "];
            
        }
        else if ([strWidthCM length]<1) {
            
            strWidthCM=[NSString stringWithFormat:@"00"];
            
        }
        
        NSString *strWeight=[NSString stringWithFormat:@"%@",_txtWeight.text];
        NSString *strQty=[NSString stringWithFormat:@"%@",_txtQty.text];
        
        
        if ([strQty length]<1) {
            
            strQty=[NSString stringWithFormat:@"1"];
            
        }
        if ([strWeight length]<1) {
            
            strWeight=[NSString stringWithFormat:@"--"];
            
        }
        
        
        NSMutableDictionary *dataDic;
        
        
        if(selectImg1==NULL && selectImg2==NULL && selectImg3==NULL && selectImg4==NULL)
        {
            
            dataDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",_txtItemTitle.text],@"title",[NSString stringWithFormat:@"%@.%@",strLengthM,strLengthCM],@"length",[NSString stringWithFormat:@"%@.%@",strWidthM,strWidthCM],@"width",[NSString stringWithFormat:@"%@.%@",strHeightM,strHeightCM],@"height",[NSString stringWithFormat:@"%@",strQty],@"quantity",[NSString stringWithFormat:@"%@",strWeight],@"weight", nil];
            
        }
        else
        {
            
            dataDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",_txtItemTitle.text],@"title",[NSString stringWithFormat:@"%@.%@",strLengthM,strLengthCM],@"length",[NSString stringWithFormat:@"%@.%@",strWidthM,strWidthCM],@"width",[NSString stringWithFormat:@"%@.%@",strHeightM,strHeightCM],@"height",[NSString stringWithFormat:@"%@",strQty],@"quantity",[NSString stringWithFormat:@"%@",strWeight],@"weight",dic,@"photo", nil];
            
            
        }
        
        

        
        
        
        
        [objappShareManager.addAnItemArray2 addObject:dataDic];
        
        // NSLog(@"%@",objappShareManager.addAnItemArray2);
        
        
    

    
    
    
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
