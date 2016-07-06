//
//  PhotosManger.m
//  Photo
//
//  Created by 王程鹏 on 16/7/5.
//  Copyright © 2016年 baling. All rights reserved.
//

#import "PhotosManger.h"

@implementation PhotosManger


+ (instancetype)defaultPhotosManager
{
    static PhotosManger *photos=nil;
    if (photos==nil)
    {
        photos=[[PhotosManger alloc]init];
    }
    
    return photos;
    
}



@end
