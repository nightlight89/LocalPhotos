//
//  PhotosCollectionViewCell.h
//  Photo
//
//  Created by 王程鹏 on 16/7/5.
//  Copyright © 2016年 baling. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotosCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UIImageView *selectImage;

@property (nonatomic,assign) int            bigNum;
@property (nonatomic,assign)   BOOL         isSelect;
@property (nonatomic,strong) UINavigationItem *item;
@property (nonatomic,strong) UIViewController *vc;

@property (nonatomic,copy) NSString   *index;

@end
