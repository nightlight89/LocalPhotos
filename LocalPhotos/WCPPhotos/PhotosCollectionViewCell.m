//
//  PhotosCollectionViewCell.m
//  Photo
//
//  Created by 王程鹏 on 16/7/5.
//  Copyright © 2016年 baling. All rights reserved.
//

#import "PhotosCollectionViewCell.h"
#import "PhotosManger.h"

@implementation PhotosCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        CGSize size=[UIScreen mainScreen].bounds.size;
        double w=(size.width-10*5)/4.0-1;
        double ww=w*0.25;
        _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, w, w)];
        [self.contentView addSubview:_imageView];
        
        _selectImage=[[UIImageView alloc]initWithFrame:CGRectMake(ww*3-2, 2, ww, ww)];
        [self.contentView addSubview:_selectImage];
        _selectImage.image=[UIImage imageNamed:@"ico_check_nomal"];
        _selectImage.userInteractionEnabled=YES;
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
        [_selectImage addGestureRecognizer:tap];
        
        
    }
    
    return self;
}



- (void)tapClick
{
    int num=  [PhotosManger defaultPhotosManager].selectedPhotosNum;
    
    if (_isSelect)
    {
        num--;
        [PhotosManger defaultPhotosManager].selectedPhotosNum=num;
        
        _selectImage.image=[UIImage imageNamed:@"ico_check_nomal"];
        _isSelect=NO;
        
    }else
    {
        if (num >= _bigNum)
        {
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"警告" message:@"你已经选择够多了" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action=[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alert addAction:action];
            [_vc presentViewController:alert animated:YES completion:nil];
            
        }else
        {
             num++;
            [PhotosManger defaultPhotosManager].selectedPhotosNum=num;
            
            _selectImage.image=[UIImage imageNamed:@"ico_check_select"];
            _isSelect=YES;
        }
    }
    
    _item.title=[NSString stringWithFormat:@"%d/%d",num,_bigNum];
    
}






















@end
