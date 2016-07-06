//
//  PhotosTableViewCell.m
//  Photo
//
//  Created by 王程鹏 on 16/7/5.
//  Copyright © 2016年 baling. All rights reserved.
//

#import "PhotosTableViewCell.h"

@implementation PhotosTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _headImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 60)];
        [self.contentView addSubview:_headImage];
        
        _title =[[UILabel alloc]initWithFrame:CGRectMake(80, 30, 100, 20)];
        [self.contentView addSubview:_title];
    }
    
    return self;
}
















@end
