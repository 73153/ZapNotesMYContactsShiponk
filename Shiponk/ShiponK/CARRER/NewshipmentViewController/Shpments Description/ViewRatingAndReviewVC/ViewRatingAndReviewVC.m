//
//  ViewRatingAndReviewVC.m
//  ShiponK
//
//  Created by bhavik on 6/14/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import "ViewRatingAndReviewVC.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"

#import "TransporterDetailViewController.h"
#import "TransporterDetailTableViewCell.h"
#import "ApiCall.h"
#import "Constant.h"
#import "ApplicationData.h"
#import "appShareManager.h"
#import "ComMehod.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "TblViewCellViewRatingAndReview.h"
#import "SlideNavigationController.h"
#import "ReviewDetailsViewController.h"
//#import "RTLabel.h"

@interface ViewRatingAndReviewVC()
{
    appShareManager *objappsharemanager;
    NSString *imgUrlMainStr;
    NSArray *transporterReviewArr;
    CGSize optimumSize;
    BOOL ReviewFlag;
    NSArray *aryReviewPoints;
    NSString *strMaxRating;
    TblViewCellViewRatingAndReview *cell;
}

@end
@implementation ViewRatingAndReviewVC
@synthesize StrTransporterId;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.ViewAvgStarOut.canEdit = NO;
    self.ViewAvgStarOut.maxRating = 5;
    NSString *strMaxRating=[[NSString alloc]init];

  //  aryReviewPoints=[[NSArray alloc]init];
    objappsharemanager=[appShareManager sharedManager];
     aryReviewPoints=[[ NSArray alloc]init];
//initWithObjects:@"1000",@"2000",@"3000",@"4000",@"5000",nil];
    [self getReviewMethod];
   
    ReviewFlag=NO;
    
}

-(void)getReviewMethod{
    void (^successed)(id responseObject) = ^(id responseObject)
    {
        NSLog(@"%@",responseObject);
        [self assignvaltdic:responseObject];
        
        NSDictionary *dic=[responseObject valueForKey:@"data"];
        
        transporterReviewArr=[dic valueForKey:@"transporter_review"];        
        
        [self.tblViewReviewFeedbackOut reloadData];
        
        
    };
    
    void (^failure)(NSError * error) = ^(NSError *error)
    {
        [APPDATA hideLoader];
    };
   
    NSDictionary *dic;
    if([objappsharemanager.CarrierProfileViewShowID isEqualToString:@"1"]) {
        
        _btnWriteReview.hidden=YES;
        dic=@{@"carrier_id":[objappsharemanager.loginDic valueForKey:@"user_id"],@"offset":@"0",@"page":@"0"};
        
    }
    else
    {
        dic=@{@"carrier_id":StrTransporterId,@"offset":@"0",@"page":@"0"};
        
    }

    
    
    
    [ApiCall sendToService:API_VIEW_RATING andDictionary:dic success:successed failure:failure];
}


-(void)rateViewMethod
{
    
    Feedback_And_Review_ViewController *controller2 =(Feedback_And_Review_ViewController *) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"Feedback_And_Review_ViewController"];
    
    
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
    
     ReviewFlag=NO;
    
}



-(void)assignvaltdic:(NSDictionary*)dic
{
    
  imgUrlMainStr = [[dic valueForKey:@"data"] valueForKey:@"profile_pic_url"];
    self.lblUsernameOut.text = [[[[dic valueForKey:@"data"] valueForKey:@"transporter_data"] objectAtIndex:0]valueForKey:@"transporter_name"];
    aryReviewPoints =[[dic valueForKey:@"data"]valueForKey:@"rates"];
    strMaxRating=[[dic valueForKey:@"data"] valueForKey:@"max_rate"];
    _lblRatingAvg.text=[NSString stringWithFormat:@"%@",[[[[dic valueForKey:@"data"] valueForKey:@"transporter_data"] objectAtIndex:0]valueForKey:@"avg_votes"]];
   // =[[dic valueForKey:@"data"] valueForKey:@"profile_pic_url"];


    [_imgViewProfileImgOut setImageWithURL:[NSURL URLWithString:imgUrlMainStr] placeholderImage:[UIImage imageNamed:@""] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    //self.lblVehicleTypeOut.text
    NSString *strvehicletype =[NSString stringWithFormat:@"%@",[[[[dic valueForKey:@"data"] valueForKey:@"transporter_vehicle"] objectAtIndex:0] valueForKey:@"vehicle_name"]];
    if ([strvehicletype isEqualToString:@""]||[strvehicletype isEqualToString:@"(null)"]||[strvehicletype isEqualToString:@"<null>"])
    {
      self.lblVehicleTypeOut.text = @"No detail found";
    }
    else
    {
        self.lblVehicleTypeOut.text = strvehicletype;
    }
    //self.lblBusinessNameOurt.text =
    
    NSString *strbusinesstype = [NSString stringWithFormat:@"%@",[[[[dic valueForKey:@"data"] valueForKey:@"transporter_data"] objectAtIndex:0]valueForKey:@"business_name"]];
    
    if ([strbusinesstype isEqualToString:@""]||[strbusinesstype isEqualToString:@"(null)"]||[strbusinesstype isEqualToString:@"<null>"])
    {
        self.lblBusinessNameOurt.text = @"No Fetail Found";
    }
    else
    {
        self.lblBusinessNameOurt.text = strbusinesstype;
    }

    
   
    NSString *imgstr1=[[[[dic valueForKey:@"data"] valueForKey:@"transporter_data"] objectAtIndex:0] valueForKey:@"profile_picture"];
   
    if ([imgstr1 isEqualToString:@""] ||[imgstr1 isEqualToString:@"<null>"]||[imgstr1 isEqualToString:@"(null)(null)"] )
    {
        self.imgViewProfileImgOut.image = [UIImage imageNamed:@"NO_IMAGE"];
    }
    else
    {
        NSString *fullstr = [NSString stringWithFormat:@"%@%@",imgUrlMainStr,imgstr1];
    [self.imgViewProfileImgOut setImageWithURL:[NSURL URLWithString:fullstr] placeholderImage:[UIImage imageNamed:@""] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }

    NSString *strrating = [NSString stringWithFormat:@"%@",[[[[dic valueForKey:@"data"] valueForKey:@"transporter_data"] objectAtIndex:0] valueForKey:@"avg_votes"]];
    
    float fltstar = [strrating floatValue];
    self.ViewAvgStarOut.rating = fltstar;

    self.imgViewProfileImgOut.layer.cornerRadius=self.imgViewProfileImgOut.frame.size.width/2.0;
    self.imgViewProfileImgOut.layer.masksToBounds=YES;
    self.imgViewProfileImgOut.clipsToBounds=YES;
    
    
    [self setRatingPointMethod];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [transporterReviewArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"TblViewCellViewRatingAndReview";
    
    cell = (TblViewCellViewRatingAndReview *)[_tblViewReviewFeedbackOut dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        cell = [[TblViewCellViewRatingAndReview alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.ViewStarRatingTblOut.canEdit = NO;
    cell.ViewStarRatingTblOut.maxRating = 5;
    NSString *strrating = [NSString stringWithFormat:@"%@",[[transporterReviewArr objectAtIndex:indexPath.row]valueForKey:@"votes"]];
    float fltstar = [strrating floatValue];
    cell.ViewStarRatingTblOut.rating = fltstar;
    
    cell.lblTitleTblOut.text = [NSString stringWithFormat:@"%@",[[transporterReviewArr objectAtIndex:indexPath.row]valueForKey:@"customer_name"]];
    
    NSString*desc = [NSString stringWithFormat:@"%@",[[transporterReviewArr objectAtIndex:indexPath.row]valueForKey:@"description"]];

    if ([desc isEqualToString:@""] ||[desc isEqualToString:@"<null>"]||[desc isEqualToString:@"(null)"] )
    {
        cell.lblDescriptionOut.text = @"-";
    }
    else
    {
        cell.lblDescriptionOut.text = desc;
      
    }
    
    
    NSString *imgstr=[[transporterReviewArr objectAtIndex:indexPath.row]valueForKey:@"profile_picture"];
    
    cell.imgViewProfileTblOut.layer.cornerRadius=cell.imgViewProfileTblOut.frame.size.width/2.0;
    cell.imgViewProfileTblOut.layer.masksToBounds=YES;
    cell.imgViewProfileTblOut.clipsToBounds=YES;

    
    if ([imgstr isEqualToString:@""] ||[imgstr isEqualToString:@"<null>"]||[imgstr isEqualToString:@"(null)(null)"])
    {
        cell.imgViewProfileTblOut.image = [UIImage imageNamed:@"NO_IMAGE"];
    }
    else
    {
        
        
        NSString *fullimgstr = [NSString stringWithFormat:@"%@%@",imgUrlMainStr,imgstr];
        [cell.imgViewProfileTblOut setImageWithURL:[NSURL URLWithString:fullimgstr] placeholderImage:[UIImage imageNamed:@""] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        

    }
    
    
    NSCharacterSet *charsToTrim = [NSCharacterSet characterSetWithCharactersInString:@"()  \n\""];
    
    
    NSString *strSid=[NSString stringWithFormat:@"%@",[transporterReviewArr valueForKey:@"shipment_id"]];
    
    strSid = [strSid stringByTrimmingCharactersInSet:charsToTrim];
    
     NSString *strCid=[NSString stringWithFormat:@"%@",[transporterReviewArr valueForKey:@"carrier_id"]];
                      
    strCid = [strCid stringByTrimmingCharactersInSet:charsToTrim];
    if ([strSid isEqualToString:objappsharemanager.Shipment_id] && [strCid isEqualToString:objappsharemanager.carrieridStr]
        ) {
        
    }else{
        
        ReviewFlag=YES;
        
       
    }
    
    
    
     return cell;
    
   }
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
     ReviewDetailsViewController *objotherAdditemViewController= (ReviewDetailsViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"ReviewDetailsViewController"];
    
    
    objotherAdditemViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    
    
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
    
    NSString *strrating = [NSString stringWithFormat:@"%@",[[transporterReviewArr objectAtIndex:indexPath.row]valueForKey:@"votes"]];
    float fltstar = [strrating floatValue];
    objotherAdditemViewController.viewStarRat.rating=fltstar;
    
    objotherAdditemViewController.lblName.text=[NSString stringWithFormat:@"%@",[[transporterReviewArr objectAtIndex:indexPath.row]valueForKey:@"customer_name"]];
    
    NSString*desc = [NSString stringWithFormat:@"%@",[[transporterReviewArr objectAtIndex:indexPath.row]valueForKey:@"description"]];
    
    if ([desc isEqualToString:@""] ||[desc isEqualToString:@"<null>"]||[desc isEqualToString:@"(null)"] )
    {
       objotherAdditemViewController.lblReview.text = @"-";
    }
    else
    {
       objotherAdditemViewController.lblReview.text = desc;
        
    }
    
    NSString *imgstr=[[transporterReviewArr objectAtIndex:indexPath.row]valueForKey:@"profile_picture"];
    
    
    if ([imgstr isEqualToString:@""] ||[imgstr isEqualToString:@"<null>"]||[imgstr isEqualToString:@"(null)(null)"])
    {
        objotherAdditemViewController.imgProfile.image = [UIImage imageNamed:@"NO_IMAGE"];
    }
    else
    {
        
        
        NSString *fullimgstr = [NSString stringWithFormat:@"%@%@",imgUrlMainStr,imgstr];
        [objotherAdditemViewController.imgProfile setImageWithURL:[NSURL URLWithString:fullimgstr] placeholderImage:[UIImage imageNamed:@""] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        
        
    }

    
    

    
    
    
    
}


- (IBAction)btnBackAct:(id)sender
{
    [[self navigationController]popViewControllerAnimated:YES];
}

-(void)setRatingPointMethod
{
    for (int i=0; i < [aryReviewPoints count]; i++) {
        switch (i) {
            case 0:
              {
                  NSString *str=[[NSString alloc]init];
                  str=[aryReviewPoints valueForKey:@"fivevote"];
                  _lblRatingPoints1.text=str;
                float per=[self getPercentage:[str intValue]];
               NSInteger width= [self getWidth:(NSInteger)per];
                
                _viewRating1.frame=CGRectMake(_viewReviewUser1.frame.origin.x+20, _viewReviewUser1.frame.origin.y,width,16);
                  _viewRating1.backgroundColor=[UIColor yellowColor];
              
                break;
              }
            case 1:
               {
                   
                   NSString *str=[[NSString alloc]init];
                   str=[aryReviewPoints valueForKey:@"fourvote"];
                   _lblRatingPoints2.text=str;

                //_lblRatingPoints2.text=[aryReviewPoints valueForKey:@"fourvote"][i];
                float per=[self getPercentage:[str intValue]];
                NSInteger width= [self getWidth:(NSInteger)per];
                
                _viewRating2.frame=CGRectMake(_viewReviewUser2.frame.origin.x+20, _viewReviewUser2.frame.origin.y,width,16);
                   
                   _viewRating2.backgroundColor=[UIColor colorWithRed:135.0f/255.0f green:185.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
               
                break;
               }
            case 2:
                {
                    NSString *str=[[NSString alloc]init];
                    str=[aryReviewPoints valueForKey:@"threevote"];
                    _lblRatingPoints3.text=str;
                    
               // _lblRatingPoints3.text=[aryReviewPoints valueForKey:@"threevote"];
                float per=[self getPercentage:[str intValue]];
                NSInteger width= [self getWidth:(NSInteger)per];
                
                _viewRating3.frame=CGRectMake(_viewReviewUser3.frame.origin.x+20, _viewReviewUser3.frame.origin.y,width,16);
               // _viewRating3.backgroundColor=[UIColor yellowColor];
                _viewRating3.backgroundColor=[UIColor colorWithRed:210.0f/255.0f green:106.0f/255.0f blue:66.0f/255.0f alpha:1.0f];
                 break;
                }
               
            case 3:
            {
                NSString *str=[[NSString alloc]init];
                str=[aryReviewPoints valueForKey:@"twovote"];
                _lblRatingPoints4.text=str;

              //  _lblRatingPoints4.text=[aryReviewPoints valueForKey:@"twovote"][i];
                float per=[self getPercentage:[str intValue]];
                NSInteger width= [self getWidth:(NSInteger)per];
                
                _viewRating4.frame=CGRectMake(_viewReviewUser4.frame.origin.x+20, _viewReviewUser4.frame.origin.y,width,16);
              //  _viewRating4.backgroundColor=[UIColor yellowColor];
                
                _viewRating4.backgroundColor=[UIColor colorWithRed:168.0f/255.0f green:173.0f/255.0f blue:185.0f/255.0f alpha:1.0f];
                break;
                
            }
            case 4:{
                
                NSString *str=[[NSString alloc]init];
                str=[aryReviewPoints valueForKey:@"onevote"];
                _lblRatingPoints5.text=str;
                
               // _lblRatingPoints5.text=[aryReviewPoints valueForKey:@"onevote"][i];
                float per=[self getPercentage:[str intValue]];
                NSInteger width= [self getWidth:(NSInteger)per];
                
                _viewRating5.frame=CGRectMake(_viewReviewUser5.frame.origin.x+20, _viewReviewUser5.frame.origin.y,width,16);
               // _viewRating5.backgroundColor=[UIColor yellowColor];
                _viewRating5.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:150.0f/255.0f blue:38.0f/255.0f alpha:1.0f];
                break;
            }
                
            default:
                break;
        }
    
        
    
}
}
-(float)getPercentage:(NSInteger)value
{
    
 //strMaxRating =[NSString stringWithFormat:@"%@",[[aryReviewPoints valueForKey:@"transporter_data"]valueForKey:@"avg_votes"]];
    
    float per=((value*100)/[strMaxRating intValue]);
    return per;
}
-(NSInteger)getWidth:(NSInteger)value
{
    NSInteger width=((100*value)/100);
    return width;
}
- (IBAction)btn_writeareviewActions:(id)sender {
    
    [self rateViewMethod];
}
@end
