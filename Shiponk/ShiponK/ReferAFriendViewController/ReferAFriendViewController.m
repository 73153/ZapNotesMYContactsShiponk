//
//  ReferAFriendViewController.m
//  ShiponK
//
//  Created by Bhushan on 7/19/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import "ReferAFriendViewController.h"
#import "SlideNavigationController.h"
#import <MessageUI/MFMailComposeViewController.h>
#import <MessageUI/MessageUI.h>

#import <AddressBook/AddressBook.h>
#import <AddressBook/ABPerson.h>
#import <AddressBookUI/AddressBookUI.h>
@interface ReferAFriendViewController ()<MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate,ABPeoplePickerNavigationControllerDelegate,ABPersonViewControllerDelegate,ABNewPersonViewControllerDelegate,ABUnknownPersonViewControllerDelegate,UIDocumentInteractionControllerDelegate>

@end

@implementation ReferAFriendViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   [_menuButton addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleLeftMenu) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark emailShareAction...

- (IBAction)btn_emailShareAction:(id)sender {
    
    
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    [picker setSubject:@"ShiponK App"];
    
    // Set up recipients
    // NSArray *toRecipients = [NSArray arrayWithObject:@"first@example.com"];
    // NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com", @"third@example.com", nil];
    // NSArray *bccRecipients = [NSArray arrayWithObject:@"fourth@example.com"];
    
    // [picker setToRecipients:toRecipients];
    // [picker setCcRecipients:ccRecipients];
    // [picker setBccRecipients:bccRecipients];
    
    // Attach an image to the email
    UIImage *coolImage ;
    NSData *myData = UIImagePNGRepresentation(coolImage);
    [picker addAttachmentData:myData mimeType:@"image/png" fileName:@"ShiphonK_Logo"];
    
    // Fill out the email body text
    NSString *emailBody = @"ShipoK in Appstore :http://216.55.169.45/~shiponk/master/ ";
    [picker setMessageBody:emailBody isHTML:NO];
   // [self presentModalViewController:picker animated:YES];
    
   [self presentViewController:picker animated:YES completion:nil];
    
}


- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    // Notifies users about errors associated with the interface
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Result: canceled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Result: saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Result: sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Result: failed");
            break;
        default:
            NSLog(@"Result: not sent");
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (IBAction)btn_smsShareAction:(id)sender
{
    
    
    
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init] ;
    if([MFMessageComposeViewController canSendText])
    {
        controller.body = @"ShipoK in Appstore :http://216.55.169.45/~shiponk/master/";
        //controller.recipients = [NSArray arrayWithObjects:@"12345678", @"87654321", nil];
        controller.messageComposeDelegate = self;
         [self presentViewController:controller animated:YES completion:nil];
    }
    
    
    
}






- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
    switch (result) {
        case MessageComposeResultCancelled:
            break;
            
        case MessageComposeResultFailed:
        {
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to send SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [warningAlert show];
            break;
        }
            
        case MessageComposeResultSent:
            break;
            
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (IBAction)btn_whatsUpShareAction:(id)sender {
    
    if ([[UIApplication sharedApplication] canOpenURL: [NSURL URLWithString:@"whatsapp://app"]]){
        
        NSString * msg = @"ShipoK in Appstore :http://216.55.169.45/~shiponk/master/";
        NSString * urlWhats = [NSString stringWithFormat:@"whatsapp://send?text=%@",msg];
        NSURL * whatsappURL = [NSURL URLWithString:[urlWhats stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        if ([[UIApplication sharedApplication] canOpenURL: whatsappURL]) {
            [[UIApplication sharedApplication] openURL: whatsappURL];
        } else {
            NSLog(@" Cannot open whatsapp");
        }
        
    } else {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"WhatsApp not installed." message:@"Your device has no WhatsApp installed." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}
@end
