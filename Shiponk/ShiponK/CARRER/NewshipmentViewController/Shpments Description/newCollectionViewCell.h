//
//  newCollectionViewCell.h
//  collectionview
//
//  Created by ronakj on 4/11/16.
//  Copyright (c) 2016 com.ronak.zaptech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface newCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UILabel *lbl_titlename;
@property (strong, nonatomic) IBOutlet UIImageView *imgview_inscllView;
@property (strong, nonatomic) IBOutlet UITextView *txtViewFieldDataOut;

@property (strong, nonatomic) IBOutlet UILabel *lbl_length;
@property (strong, nonatomic) IBOutlet UILabel *lbl_width;
@property (strong, nonatomic) IBOutlet UILabel *lbl_height;
@property (strong, nonatomic) IBOutlet UILabel *lbl_weight;
@property (strong, nonatomic) IBOutlet UILabel *lbl_quantity;

@end
