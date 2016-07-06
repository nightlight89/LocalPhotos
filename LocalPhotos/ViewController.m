//
//  ViewController.m
//  LocalPhotos
//
//  Created by 王程鹏 on 16/7/6.
//  Copyright © 2016年 baling. All rights reserved.
//
#import "ViewController.h"
#import "PhotosManger.h"
#import "PhotoTableViewController.h"

@interface ViewController ()
{
    UIImageView *_view;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(100, 100, 100, 100);
    button.backgroundColor=[UIColor redColor];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self showPhotos];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [_view removeFromSuperview];
}

- (void)showPhotos
{
    NSArray *array=[PhotosManger defaultPhotosManager].selectedPhotosArray;
    for (int i=0; i<array.count; i++)
    {
        _view=[[UIImageView alloc]initWithFrame:CGRectMake(0+85*i, 300, 80, 80)];
        
        _view.image=array[i];
        [self.view addSubview:_view];
        
    }
    
}


- (void)buttonClick
{
    PhotoTableViewController *vc=[[PhotoTableViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
