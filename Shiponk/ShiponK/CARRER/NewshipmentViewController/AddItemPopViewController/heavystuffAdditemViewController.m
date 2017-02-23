//
//  heavystuffAdditemViewController.m
//  ShiponK
//
//  Created by datt on 06/04/1938 SAKA.
//  Copyright © 1938 SAKA com.zaptechsolution. All rights reserved.
//

#import "heavystuffAdditemViewController.h"
#import "appShareManager.h"
#import "ComMehod.h"

@interface heavystuffAdditemViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    UIImage *selectImg;
    NSData *imageData;
    appShareManager *objappShareManager;
    ComMehod *objComMehod;
}

@end

@implementation heavystuffAdditemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    objappShareManager =[appShareManager sharedManager];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(AddItemNotification)
                                                 name:@"AddItemForHeavystuffAdditemVC"
                                               object:nil];
  //  _mainScrollView.contentSize = CGSizeMake(_mainScrollView.frame.size.width, 385);
    
    // Do any additional setup after loading the view.
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    selectImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    
    [_btnimgItem setBackgroundImage:selectImg forState:UIControlStateNormal];
    
    imageData = UIImageJPEGRepresentation(selectImg, 0.25);
    
    
    
}

-(void)AddItemNotification
{
    if([[objComMehod spacecheck:_txtItemTitle.text]isEqualToString:@"0"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter city name" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if([[objComMehod spacecheck:_txtQty.text]isEqualToString:@"0"])
    {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter Qty." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
    }
    else if([[objComMehod spacecheck:_txtBreed.text]isEqualToString:@"0"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter city name." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if([[objComMehod spacecheck:_txtWeight.text]isEqualToString:@"0"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter city name." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if([[objComMehod spacecheck:_txtModel.text]isEqualToString:@"0"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter city name." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }

    else
    {
        
        // UIImage *img = [UIImage imageNamed:@"left-bg.png"];
        NSData *data = UIImagePNGRepresentation(selectImg);
        
        NSString *basestr =  [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        
        //NSData *imgData = UIImagePNGRepresentation(selectImg);
        //  NSData *imgData =   UIImageJPEGRepresentation(selectImg, .10);
        //= [imgData base64EncodedStringWithOptions:0];
        
        //        NSArray *arr=@[
        //                       @{@"Title":[NSString stringWithFormat:@"%@",_txtItemTitle.text]},
        //                       @{@"Breed":[NSString stringWithFormat:@"%@",_txtBreed.text]},
        //                       @{@"Weight":[NSString stringWithFormat:@"%@",_txtWeight.text]},
        //                       @{@"Description":[NSString stringWithFormat:@"%@",_txtItemDescription.text]},
        //                       @{@"Photo":[NSString stringWithFormat:@"%@",imageString]},
        //                       ];
        
        NSMutableDictionary *dataDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",_txtItemTitle.text],@"title",[NSString stringWithFormat:@"%@",_txtBreed.text],@"breed",[NSString stringWithFormat:@"%@",_txtWeight.text],@"weight",[NSString stringWithFormat:@"%@",basestr],@"photo",[NSString stringWithFormat:@"%@",_txtQty.text],@"qty", nil];
        
        
        //
        
        
        
        
        [objappShareManager.addAnItemArray2 addObject:dataDic];
        
        // NSLog(@"%@",objappShareManager.addAnItemArray2);
        
        
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
