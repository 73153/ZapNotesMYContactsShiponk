//
//  PaymentStatusViewController.m
//  PaymentGateway
//
//  Created by Suraj on 30/07/15.
//  Copyright (c) 2015 Suraj. All rights reserved.
//

#import "PaymentStatusViewController.h"
#import "AppDelegate.h"
#import "ApplicationData.h"
#import "appShareManager.h"
#import "TransporterDetailViewController.h"

@interface PaymentStatusViewController () {
    __weak IBOutlet UITextField *txtFieldProductInfo;
    __weak IBOutlet UITextField *txtFieldTransactionStatus;
    __weak IBOutlet UITextField *txtFieldTransactionID;
    appShareManager *objappShareManager;
}

- (IBAction)popToPaymentPage:(id)sender;

@end

@implementation PaymentStatusViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self setTitle:@"Payment Status"];
    self.navigationItem.hidesBackButton = YES;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    [self setTitle:@""];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    objappShareManager=[appShareManager sharedManager];
    
    [self setUserDataToUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUserDataToUI
{
    [txtFieldProductInfo setText:[self.mutDictTransactionDetails objectForKey:@"Product_Info"]];
    [txtFieldTransactionStatus setText:[self.mutDictTransactionDetails objectForKey:@"Transaction_Status"]];
    [txtFieldTransactionID setText:[self.mutDictTransactionDetails objectForKey:@"Transaction_ID"]];
}

- (IBAction)popToPaymentPage:(id)sender
{
    [self paymentMethod];
    
    
//   [self.navigationController popViewControllerAnimated:YES];
}


-(void)paymentMethod{
    
    [APPDATA showLoader];
    
    void (^successed)(id responseObject) = ^(id responseObject)
    {
        
        [APPDATA hideLoader];
        
        
        NSString *codeStr=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"code"]];
        NSString *meg=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"message"]];
        
      
        
        if ([codeStr isEqualToString:@"1"])
        {
            
            
                [APPDATA hideLoader];
                
                TransporterDetailViewController *objTransporterDetailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TransporterDetailViewController"];
                [APPDATA pushNewViewController:objTransporterDetailViewController];
            
            
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:meg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        
       
        
        
        
    };
    
    void (^failure)(NSError * error) = ^(NSError *error)
    {
        [APPDATA hideLoader];
    };
    
  
    
    
    
     NSString *userid=[NSString stringWithFormat:@"%@",[objappShareManager.loginDic valueForKey:@"user_id"]];
    
    
    
    NSString *Product_InfoStr=[NSString stringWithFormat:@"%@",[self.mutDictTransactionDetails objectForKey:@"Product_Info"]];
    
    NSString *amoutDueStr=[NSString stringWithFormat:@"%@",[self.mutDictTransactionDetails objectForKey:@"Paid_Amount"]];
    
    
     NSString *Payee_NameStr=[NSString stringWithFormat:@"%@",[self.mutDictTransactionDetails objectForKey:@"Payee_Name"]];
    
    NSString *Transaction_IDStr=[NSString stringWithFormat:@"%@",[self.mutDictTransactionDetails objectForKey:@"Transaction_ID"]];
    
     NSString *Transaction_StatusStr=[NSString stringWithFormat:@"%@",[self.mutDictTransactionDetails objectForKey:@"Transaction_Status"]];
    
    
    
    NSDictionary *dict = @{@"mihpayid":Transaction_IDStr,@"carrier_id":userid,@"txnid":Transaction_StatusStr,@"amount":amoutDueStr,@"mode":Product_InfoStr,@"addedon":Payee_NameStr,@"status":Transaction_StatusStr};
    
    [ApiCall sendToService:API_PAYMENT andDictionary:dict success:successed failure:failure];
    
    
    
    
}

@end
