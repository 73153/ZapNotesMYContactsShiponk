//
//  IteamDetailsViewcontroller.m
//  ShiponK
//
//  Created by Bhushan on 7/5/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import "IteamDetailsViewcontroller.h"
#import "IteamDetailsCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "ApplicationData.h"
#import "appShareManager.h"

@interface IteamDetailsViewcontroller ()
{
    appShareManager *objappsharemanager;
    NSIndexPath *currentSelection;
}


@end

@implementation IteamDetailsViewcontroller
@synthesize strItemID,itemImageArr,strUrl;

- (void)viewDidLoad {
    [super viewDidLoad];
//    objappsharemanager=[appShareManager sharedManager];
//    
//    [APPDATA showLoader];
//    
//    
//    void (^successed)(id responseObject) = ^(id responseObject)
//    {
//        
//        [APPDATA hideLoader];
//        
//        
//        
//         [_collectionViewImg reloadData];
//        
//    };
//    
//    void (^failure)(NSError * error) = ^(NSError *error)
//    {
//        [APPDATA hideLoader];
//        
//    };
//    
//    
//    NSString *useridStr=[NSString stringWithFormat:@"%@",[objappsharemanager.loginDic valueForKey:@"user_id"]];
//    
//    
//   NSDictionary *dict = @{@"user_id":useridStr,@"shipment_id":objappsharemanager.Shipment_id,@"item_id":[NSString stringWithFormat:@"%@",strItemID]};
//    
//    [ApiCall sendToService:API_SHIPMENT_ITEM_DETAIL andDictionary:dict success:successed failure:failure];
//
//
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (![[NSString stringWithFormat:@"%@",itemImageArr] isEqualToString:@""]) {
    
        return [itemImageArr count];
    }else
    {
        return 0;
    }
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
     currentSelection = indexPath;
    
    IteamDetailsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"IteamDetailsCollectionViewCell" forIndexPath:indexPath];
    NSString *img;
    
    
    NSString *imageData=[NSString stringWithFormat:@"%@",[itemImageArr objectAtIndex:indexPath.row]];
    
    if ([imageData length]>2) {
        img=[NSString stringWithFormat:@"%@%@",strUrl,imageData];
        
       
      
        
        
        [cell.img sd_setImageWithURL:[NSURL URLWithString:img]
                          placeholderImage:[UIImage imageNamed:@"Loading.png"]];

        
    }
    else
    {
        [cell.img setImage:[UIImage imageNamed:@"myImage.jpg"]];
    }
    

    return cell;
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

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat cellWidth =  _viewItemDetail.bounds.size.width;
    CGFloat cellHeight =  _viewItemDetail.bounds.size.height*.88;
    return CGSizeMake(cellWidth, cellHeight);
}


- (IBAction)btnRightArrowAction:(id)sender {
    if(currentSelection){
        currentSelection = [NSIndexPath indexPathForRow:currentSelection.row+1 inSection:currentSelection.section];
    }else{
        currentSelection = [NSIndexPath indexPathForRow:0 inSection:0];
    }
    [self.collectionViewImg scrollToItemAtIndexPath:currentSelection atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
   // [self.collectionViewImg selectItemAtIndexPath:selectRowAtIndexPath:currentSelection animated:YES scrollPosition:UICollectionViewScrollDirectionHorizontal];
     //selectRowAtIndexPath:currentSelection animated:YES scrollPosition: UITableViewScrollPositionTop];

}

@end
