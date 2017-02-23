//
//  TransporterCollectionViewCell.h
//  ShiponK
//
//  Created by ronakj on 6/13/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransporterCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UILabel *lbl_titlename;
@property (strong, nonatomic) IBOutlet UIImageView *imgview_inscllView;
@property (strong, nonatomic) IBOutlet UILabel *lblTitleOut;

@property (strong, nonatomic) IBOutlet UITextView *txtViewFieldDataOut;

@property (strong, nonatomic) IBOutlet UIImageView *imgViewItemImgOut;
@property (strong, nonatomic) IBOutlet UILabel *lbl_tit;

@property (strong, nonatomic) IBOutlet UIImageView *imgIteam;


@end
