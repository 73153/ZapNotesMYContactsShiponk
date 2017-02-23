//
//  Message_ViewController.m
//  ShiponK
//
//  Created by datt on 06/03/1938 SAKA.
//  Copyright © 1938 SAKA com.zaptechsolution. All rights reserved.
//

#import "Message_ViewController.h"
#import "cellMessageTblCell.h"
#import "SlideNavigationController.h"
#import "AppDelegate.h"
#import "ApplicationData.h"
#import "appShareManager.h"
#import "Shipment_Description_ViewController.h"

@interface Message_ViewController ()<SlideNavigationControllerDelegate>
{
    appShareManager* objappShareManager;
    NSMutableArray *DictMsg;
    
    NSString *page,*offset;
    
    UIRefreshControl *refreshControl;
}
@end

@implementation Message_ViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
     [_menuButton addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleLeftMenu) forControlEvents:UIControlEventTouchUpInside];
    
    objappShareManager = [appShareManager sharedManager];
    DictMsg=[[NSMutableArray alloc]init];
    
    refreshControl = [[UIRefreshControl alloc]init];
    [_tblView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(massageGetMethod) forControlEvents:UIControlEventValueChanged];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    
    page=@"0";
    offset=@"0";
    DictMsg=[[NSMutableArray alloc]init];
    [self massageGetMethod];

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([DictMsg isEqual:@""])
    {
        _tblView.hidden=YES;
        _lblnoNotifcation.hidden=NO;
        return 0;
    }else{
        _lblnoNotifcation.hidden=YES;
         _tblView.hidden=NO;
    
    NSLog(@"%lu",(unsigned long)[DictMsg count]);
         return [DictMsg count];
    }
    
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"cellMessageTblCell";
    
    cellMessageTblCell *cell = (cellMessageTblCell *)[_tblView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"cellMessageTblCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.lbl_username_message.text=[NSString stringWithFormat:@"%@",[[DictMsg objectAtIndex:indexPath.row]valueForKey:@"shipment_title"]];
    
    
    
    
    cell.txt_desc.text=[NSString stringWithFormat:@"%@",[[DictMsg objectAtIndex:indexPath.row]valueForKey:@"message"]];
    
     cell.lblDate.text=[NSString stringWithFormat:@"%@",[[DictMsg objectAtIndex:indexPath.row]valueForKey:@"created_at"]];
    
    
    NSString *msgCheck=[NSString stringWithFormat:@"%@",[[DictMsg objectAtIndex:indexPath.row]valueForKey:@"is_read"]];
    
    if ([msgCheck isEqualToString:@"0"])
    {
        [cell.imgeMsgReadandUnread setImage:[UIImage imageNamed:@"unreadmsg"]];
        cell.lbl_username_message.textColor=[UIColor blackColor];
        
        
    }else{
        [cell.imgeMsgReadandUnread setImage:[UIImage imageNamed:@"readmsg"]];
         cell.lbl_username_message.textColor=[UIColor grayColor];
    }
    cell.btn_close.tag=indexPath.row;
    
    [cell.btn_close addTarget:self
                        action:@selector(deleMethod:)
              forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
    
    
    
}

-(IBAction)deleMethod:(id)sender{
    
    void (^successed)(id responseObject) = ^(id responseObject)
    {
        
        [APPDATA hideLoader];
        
        
        NSString *codeStr=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"code"]];
        NSString *meg=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"message"]];
        
        
        
        if ([codeStr isEqualToString:@"1"])
        {
            
            DictMsg=[[NSMutableArray alloc]init];
            page=@"0";
            offset=@"0";
            
            [self massageGetMethod];
            
            
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
    
    [APPDATA showLoader];
   
    
    NSString *nid=[NSString stringWithFormat:@"%@",[[DictMsg objectAtIndex:[sender tag]]valueForKey:@"id"]];
    
     NSString *spid=[NSString stringWithFormat:@"%@",[[DictMsg objectAtIndex:[sender tag]]valueForKey:@"shipment_id"]];
    
    NSDictionary *dict = @{@"shipment_id":spid,@"notification_id":nid};
    
    [ApiCall sendToService:API_DELETE_NOTIFICATION andDictionary:dict success:successed failure:failure];
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSString *notid=[NSString stringWithFormat:@"%@",[[DictMsg objectAtIndex:indexPath.row]valueForKey:@"id"]];
      NSString *shipid=[NSString stringWithFormat:@"%@",[[DictMsg objectAtIndex:indexPath.row]valueForKey:@"shipment_id"]];
    
    [self notificationStatus:notid :shipid];
    
}


-(void)notificationStatus:(NSString *)strnotid :(NSString*)shipid
{
    
    void (^successed)(id responseObject) = ^(id responseObject)
    {
        
        [APPDATA hideLoader];
        
        
        NSString *codeStr=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"code"]];
        NSString *meg=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"message"]];
        
        
        
        
        if ([codeStr isEqualToString:@"1"])
        {
            
            objappShareManager.Shipment_id=[NSString stringWithFormat:@"%@",shipid];
            
            
            Shipment_Description_ViewController *objviewController =(Shipment_Description_ViewController *) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"Shipment_Description_ViewController"];
            
            objviewController.ShipmentidStr = [NSString stringWithFormat:@"%@",shipid];
            
            [[self navigationController]pushViewController:objviewController animated:YES];
            
            
            
            
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
    
    [APPDATA showLoader];
    NSString *struserid=[NSString stringWithFormat:@"%@",[objappShareManager.loginDic valueForKey:@"user_id" ]];
    
    NSDictionary *dict = @{@"user_id":struserid,@"notification_id":strnotid,@"shipment_id":shipid};
    
    [ApiCall sendToService:API_CHABGE_NOTIFICATION_STATUS andDictionary:dict success:successed failure:failure];
    
}
-(void)massageGetMethod{
    
    void (^successed)(id responseObject) = ^(id responseObject)
    {
        
        [APPDATA hideLoader];
        
        
        NSString *codeStr=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"code"]];
        NSString *meg=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"message"]];
        
        page=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"page"]];
        offset=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"offset"]];
        
        
        
        
        if ([codeStr isEqualToString:@"1"])
        {
            
            NSDictionary *dicData =[responseObject objectForKey:@"data"];
            
            NSString *strnot=[NSString stringWithFormat:@"%@",[dicData objectForKey:@"badge_count"]];

            
            NSCharacterSet *charsToTrim = [NSCharacterSet characterSetWithCharactersInString:@"< > null()  \n\""];
           
            strnot = [strnot stringByTrimmingCharactersInSet:charsToTrim];
            
            if ([strnot length]<1) {
                strnot=@"0";
            }
            
            _lbl_not.text=strnot;
            
            
            
            NSArray *arrTemp=[[responseObject valueForKey:@"data"]valueForKey:@"bid_list"];
            
            for (int i=0; i<arrTemp.count; i++)
            {
                [DictMsg addObject:[arrTemp objectAtIndex:i]];
            }
            
            
            [self.tblView reloadData];
            [refreshControl endRefreshing];
            
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
    
     [APPDATA showLoader];
    NSString *struserid=[NSString stringWithFormat:@"%@",[objappShareManager.loginDic valueForKey:@"user_id" ]];
    
    NSDictionary *dict = @{@"userid":struserid,@"page":page,@"offset":offset};
    
    [ApiCall sendToService:API_NOTIFICATION_HISTORY andDictionary:dict success:successed failure:failure];
    
}



@end
