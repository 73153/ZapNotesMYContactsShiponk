//
//  ProfileImgViewController.m
//  ShiponK
//
//  Created by datt on 20/07/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import "ProfileImgViewController.h"
#import "ApplicationData.h"
#import "appShareManager.h"


@interface ProfileImgViewController ()
{
    appShareManager *objappsharemanager;
    NSDictionary  *parameters;
    UIImage *selectImg;
    NSDictionary *dictUpload;
}

@end

@implementation ProfileImgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    objappsharemanager=[appShareManager sharedManager];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [_imgProfile addGestureRecognizer:tapRecognizer];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)tap
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
    
    
    selectImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    //[[SDImageCache sharedImageCache] removeImageForKey:imgStr1 fromDisk:YES];
    
    
    
    _imgProfile.image=selectImg;
    
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnCloseAction:(id)sender {
    
    
    if (selectImg!=nil) {
        
    
    [APPDATA showLoader];
    NSString *strUserid=[NSString stringWithFormat:@"%@",[objappsharemanager.loginDic valueForKey:@"user_id"]];
    
    
   NSData *imageData = UIImageJPEGRepresentation(selectImg, 0.5);
    
    
    NSString *str=[NSString stringWithFormat:API_EDIT_USER_PROFILE];
    NSString *urlString = [NSString stringWithFormat:@"%@",str];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    NSMutableData *body = [NSMutableData data];
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Disposition: form-data; name=\"profile_picture\"; filename=\"a.jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
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


-(void)succefulUpload{
    
    [APPDATA hideLoader];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:[dictUpload valueForKey:@"status"]
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil,nil];
    [alert show];
    
    
    

}


@end
