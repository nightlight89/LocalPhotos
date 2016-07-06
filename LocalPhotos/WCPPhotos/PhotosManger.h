//
//  PhotosManger.h
//  Photo
//
//  Created by 王程鹏 on 16/7/5.
//  Copyright © 2016年 baling. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotosManger : NSObject

+ (instancetype)defaultPhotosManager;

@property (nonatomic,assign) int selectedPhotosNum;

@property (nonatomic,copy)   NSArray *selectedPhotosArray;
@property (nonatomic,copy)   NSArray *selectedPhotosIndexArray;

@end
