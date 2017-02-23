//
//  Shipment_Category_ViewController.m
//  ShiponK
//
//  Created by datt on 04/03/1938 SAKA.
//  Copyright © 1938 SAKA com.zaptechsolution. All rights reserved.
//

#import "Shipment_Category_ViewController.h"
#include "Constant.h"
#import "ComMehod.h"
#import "ApplicationData.h"
#import "appShareManager.h"
#import "Base_New_Shipment.h"
#import "CustCellCollView.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "New_shipment_page2.h"
#import "SlideNavigationController.h"

@interface Shipment_Category_ViewController ()
{
    
    NSMutableArray *CategoryTitleArr,*CategoryidArr,*SubCategoryTitleArr,*SubCategoryidArr;
    NSMutableData *receivedData;
    NSMutableDictionary *CategoryDic;
    NSString *categoryID,*subcategoryID;
    
    ComMehod *objComMethod;
    appShareManager *objappShareManager;
    
    UITapGestureRecognizer *tap;
    NSMutableArray *namearray;
    NSString *CellIdentifier;
    CustCellCollView *cell;
    
    NSString *optCateAndSubcate;
    
    NSDictionary *DictCatSub;
    
    
    
    
}

@end

@implementation Shipment_Category_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CategoryTitleArr = [[NSMutableArray alloc]init];
    objComMethod = [[ComMehod alloc]init];
    SubCategoryidArr = [[NSMutableArray alloc]init];
    SubCategoryTitleArr = [[NSMutableArray alloc]init];
    CategoryidArr = [[NSMutableArray alloc]init];
    objappShareManager = [appShareManager sharedManager];
    optCateAndSubcate = @"1";
    objappShareManager.CarrierProfileViewShowID=[NSString stringWithFormat:@"0"];
    
     [_btnmenu addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleLeftMenu) forControlEvents:UIControlEventTouchUpInside];
    
    _btnBackOut.hidden = YES;
    NSString *rechability = [objComMethod checkNetworkRechability];
    if ([rechability isEqualToString:@"YES"])
    {
        [APPDATA showLoader];
        [self getCategoryTypeMethod];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Disconnected"
                                                        message:@"Internet Connection Failed"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Ok",nil];
        [alert show];
        
    }
    
    
    [self.CollViewOut setBackgroundView:nil];
    [self.CollViewOut setBackgroundColor:[UIColor clearColor]];
    
     if (IS_IPHONE4==YES) {
         
         [_CollViewOut setFrame:CGRectMake(_CollViewOut.frame.origin.x+30, _CollViewOut.frame.origin.y, _CollViewOut.frame.size.width-60, _CollViewOut.frame.size.height)];
         
     }
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    objappShareManager.New_shipment_dic=[[NSMutableDictionary alloc]init];
    objappShareManager.addAnItemArray2=[[NSMutableArray alloc]init];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([optCateAndSubcate isEqualToString:@"1"])
    {
        return [CategoryTitleArr count];
    }
    else
    {
        return [SubCategoryTitleArr count];
    }
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CellIdentifier =@"CustCellCollView";
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.ImgViewOut.layer.cornerRadius= _CollViewOut.bounds.size.width/8;
   //cell.ImgViewOut.layer.cornerRadius=cell.ImgViewOut.bounds.size.width/2.0;
    cell.ImgViewOut.layer.masksToBounds=YES;
    cell.ImgViewOut.clipsToBounds=YES;
    
    if (cell == nil ) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustCellCollView" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
        
    }
    if ([optCateAndSubcate isEqualToString:@"1"])
    {
    
         cell.lblNameCollViewOut.text = CategoryTitleArr[indexPath.row];
        
        
        NSString *imgstr=[NSString stringWithFormat:@"http://216.55.169.45/~shiponk/master/assets/uploads/images/category/%@",[[CategoryDic valueForKey:@"category_icon_hover"]objectAtIndex:indexPath.row]];
        
        [cell.ImgViewOut setImageWithURL:[NSURL URLWithString:imgstr] placeholderImage:[UIImage imageNamed:@""] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        
        
    }
    else
    {
        cell.lblNameCollViewOut.text = SubCategoryTitleArr[indexPath.row];
        
        NSString *imgstr=[NSString stringWithFormat:@"http://216.55.169.45/~shiponk/master/assets/uploads/images/category/%@",[[DictCatSub valueForKey:@"sub_category_icon"]objectAtIndex:indexPath.row]];
        
        [cell.ImgViewOut setImageWithURL:[NSURL URLWithString:imgstr] placeholderImage:[UIImage imageNamed:@""] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    
   
    
    

    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if([optCateAndSubcate isEqualToString:@"1"])
    {
        categoryID =[CategoryidArr objectAtIndex:indexPath.row] ;
        
        NSString *rechability = [objComMethod checkNetworkRechability];
        if ([rechability isEqualToString:@"YES"])
        {
            _btnBackOut.hidden = NO;
            _btnmenu.hidden=YES;
            [self getSubCategoryTypeMethod];
            
            
            
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Disconnected"
                                                            message:@"Internet Connection Failed"
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Ok",nil];
            [alert show];
            
        }
    }
    else if ([optCateAndSubcate isEqualToString:@"2"])
    {
        
        optCateAndSubcate = @"1";
        [_CollViewOut reloadData];
        _btnBackOut.hidden =YES;
        _btnmenu.hidden=NO;
        
        subcategoryID = [SubCategoryidArr objectAtIndex:indexPath.row];
        [objappShareManager.New_shipment_dic setValue:[NSString stringWithFormat:@"%@",categoryID] forKey:@"category_id"];
        
        [objappShareManager.New_shipment_dic setValue:[NSString stringWithFormat:@"%@",subcategoryID] forKey:@"sub_category_id"];
        
        
//        [[NSNotificationCenter defaultCenter]
//         postNotificationName:@"VehicalSet"
//         object:nil];

        New_shipment_page2 *objviewController =(New_shipment_page2 *) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"New_shipment_page2"];
        
        
        [APPDATA pushNewViewController:objviewController];
        
        
        objappShareManager.catagoryIdStrForAdditem=[[NSString alloc]init];
        objappShareManager.catagoryIdStrForAdditem=[NSString stringWithFormat:@"%@",categoryID];
        
        objappShareManager.subCatagoryIdStrForAnimalBreed=[[NSString alloc]init];
        objappShareManager.subCatagoryIdStrForAnimalBreed=[NSString stringWithFormat:@"%@",subcategoryID];
        
        
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"AddItem"
         object:nil];

    
        
    }
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (IS_IPHONE4==YES) {
       
        return  CGSizeMake(100, 100);
    }
    else
    {
        int screenWidth = _CollViewOut.bounds.size.width;
        int ans = ((screenWidth/2)-5);
        return  CGSizeMake(ans, ans);
    }
    
}



#pragma mark webservices----
-(void)getCategoryTypeMethod
{
    @try
    {
        [APPDATA showLoader];
        
        
        void (^successed)(id responseObject) = ^(id responseObject)
        {
              
            [APPDATA hideLoader];
           
            CategoryDic=[responseObject objectForKey:@"data"];
            CategoryTitleArr=[CategoryDic valueForKey:@"category_title"];
            CategoryidArr=[CategoryDic valueForKey:@"id"];
            
            [_CollViewOut reloadData];
            
            
        };
        
        void (^failure)(NSError * error) = ^(NSError *error)
        {
            
            NSString *rechability = [objComMethod checkNetworkRechability];
            if ([rechability isEqualToString:@"YES"])
            {
                
                [self getCategoryTypeMethod];
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Disconnected"
                                                                message:@"Internet Connection Failed"
                                                               delegate:self
                                                      cancelButtonTitle:@"Cancel"
                                                      otherButtonTitles:@"Ok",nil];
                [alert show];
                
            }
            
            
        };
        
        [ApiCall callGetWebService:API_CATEGORY_LIST andDictionary:nil success:successed failure:failure];
    }
    @catch (NSException *exception) {
        [APPDATA hideLoader];
    }
    @finally {
        [APPDATA hideLoader];
        
    }
    
}
-(void)getSubCategoryTypeMethod
{
    @try
    {
        [APPDATA showLoader];
        
        
        
        NSDictionary *dict = @{@"category_id":categoryID};
        void (^successed)(id responseObject) = ^(id responseObject)
        {
            optCateAndSubcate = @"2";
            
            DictCatSub=[responseObject objectForKey:@"data"];
            SubCategoryidArr=[DictCatSub valueForKey:@"id"];
            SubCategoryTitleArr=[DictCatSub valueForKey:@"category_title"];
            [_CollViewOut reloadData];
            [APPDATA hideLoader];
            
        };
        
        void (^failure)(NSError * error) = ^(NSError *error)
        {
            
            NSString *rechability = [objComMethod checkNetworkRechability];
            if ([rechability isEqualToString:@"YES"])
            {
                
                [self getSubCategoryTypeMethod];
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Disconnected"
                                                                message:@"Internet Connection Failed"
                                                               delegate:self
                                                      cancelButtonTitle:@"Cancel"
                                                      otherButtonTitles:@"Ok",nil];
                [alert show];
                
            }
            
            
        };
        
        
        [ApiCall sendToService:API_SUB_CATEGORY_LIST andDictionary:dict success:successed failure:failure];
    }
    @catch (NSException *exception) {
        [APPDATA hideLoader];
        
    }
    @finally {
        [APPDATA hideLoader];
        
    }
    
}




- (IBAction)btnBackAct:(id)sender
{
    optCateAndSubcate = @"1";
    [_CollViewOut reloadData];
    _btnBackOut.hidden =YES;
    _btnmenu.hidden=NO;
}





@end
