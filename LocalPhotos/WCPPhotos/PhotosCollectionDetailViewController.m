//
//  PhotosCollectionDetailViewController.m
//  FangXiaoMi
//
//  Created by 王程鹏 on 16/7/6.
//  Copyright © 2016年 baling. All rights reserved.
//

#import "PhotosCollectionDetailViewController.h"

@interface PhotosCollectionDetailViewController ()
{
    UIView *_shadowView;
}

@end

@implementation PhotosCollectionDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
}


- (void)createUI
{
    
    self.navigationController.navigationBar.hidden=YES;
    
    _shadowView=[[UIView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:_shadowView];
    _shadowView.backgroundColor=[UIColor blackColor];
    
    CGSize size=[UIScreen mainScreen].bounds.size;
    UIImage *img=_img;
    CGFloat rate=img.size.height/img.size.width;
    CGFloat w=img.size.width > size.width ? size.width : img.size.width;
    CGFloat h=w*rate;
    UIImageView *imgView=[[UIImageView alloc]init];
    imgView.image=img;
    imgView.alpha=0;
    [_shadowView addSubview:imgView];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeShadow)];
    [_shadowView addGestureRecognizer:tap];
    
    [UIImageView animateWithDuration:1.5 animations:^{
        imgView.alpha=1;
        imgView.frame=CGRectMake((size.width-w)/2, (size.height-h)/2, w, h);
    }];
    
}


- (void)removeShadow
{
    [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.navigationBar.hidden=NO;
    [_shadowView removeFromSuperview];
    
}



























- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
