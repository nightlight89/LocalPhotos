//
//  PhotoCollectionViewController.m
//  Photo
//
//  Created by 王程鹏 on 16/7/5.
//  Copyright © 2016年 baling. All rights reserved.
//

#import "PhotoCollectionViewController.h"
#import "PhotosCollectionViewCell.h"
#import "PhotosCollectionDetailViewController.h"
#import "PhotosManger.h"


#define MaxNum  4

@interface PhotoCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    UICollectionView *_collectionView;
    NSMutableArray   *_dataArray;
    UIView           *_shadowView;
}

@end

@implementation PhotoCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    _dataArray=[[NSMutableArray alloc]init];
    
    [self getDataArray];
    
    [self configBar];
    
    [self createCollectionView];

    
}

-(void)getDataArray
{
    PHFetchResult *fectchResult = [PHAsset fetchAssetsInAssetCollection:self.asset options:nil];
    
    for (PHAsset *ass in fectchResult){

        [_dataArray addObject:ass];
        
    }
    
}

- (void)configBar
{
    [PhotosManger defaultPhotosManager].selectedPhotosNum=(int)[PhotosManger defaultPhotosManager].selectedPhotosArray.count;
    self.navigationItem.title=[NSString stringWithFormat:@"%d/%d",[PhotosManger defaultPhotosManager].selectedPhotosNum,MaxNum];
    
    UIBarButtonItem *sureButton = [[UIBarButtonItem alloc]initWithTitle:@"选择" style:UIBarButtonItemStylePlain target:self action:@selector(sureButtonClick)];
    self.navigationItem.rightBarButtonItem = sureButton;
    
    
// UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backButtonClick)];
    
//    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(backButtonClick)];
//    self.navigationItem.leftBarButtonItem = backButton;
//    
//}
//
//-(void)backButtonClick
//{
//    
//    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)sureButtonClick
{
    NSArray *arr=[_collectionView subviews];
    NSMutableArray *array=[NSMutableArray arrayWithCapacity:0];
    NSMutableArray *a=[NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<_dataArray.count; i++)
    {
        PhotosCollectionViewCell *cell=arr[i];
        if (cell.isSelect)
        {
            [array addObject:cell.imageView.image];
            [a addObject:cell.index];
        }
        
    }
    
    
   [PhotosManger defaultPhotosManager].selectedPhotosArray=array;
    [PhotosManger defaultPhotosManager].selectedPhotosIndexArray=a;
    NSArray   *vcArray = self.navigationController.viewControllers;
   [self.navigationController popToViewController:[vcArray objectAtIndex:0] animated:YES];
    //
    NSLog(@"你一共选择了%d张图片！分别时%@",[PhotosManger defaultPhotosManager].selectedPhotosNum,[PhotosManger defaultPhotosManager].selectedPhotosIndexArray);
   
    
}

- (void)createCollectionView
{
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    CGSize size=[UIScreen mainScreen].bounds.size;
    layout.sectionInset=UIEdgeInsetsMake(10, 10, 10, 10);
    //列距
    layout.minimumInteritemSpacing=10;
    //行距
    layout.minimumLineSpacing=10;
    double w=(size.width-10*5)/4.0-1;
    //每个cell的大小
    layout.itemSize=CGSizeMake(w, w);
    
    
    
    //创建集合视图
    _collectionView= [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height) collectionViewLayout:layout];
    _collectionView.backgroundColor=[UIColor whiteColor];
    _collectionView.dataSource=self;
    _collectionView.delegate=self;
    [self.view addSubview:_collectionView];

    
    [_collectionView registerClass:[PhotosCollectionViewCell class] forCellWithReuseIdentifier:@"PhotosCollectionViewCell"];
    
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotosCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"PhotosCollectionViewCell" forIndexPath:indexPath];
    cell.item=self.navigationItem;
    cell.vc=self;
    cell.index=[NSString stringWithFormat:@"%ld",(long)indexPath.item];
    cell.bigNum=MaxNum;    //最多选几张
    cell.isSelect=NO;
    
    NSArray *array=[PhotosManger defaultPhotosManager].selectedPhotosIndexArray;
    for (NSString *index in array)
    {
        if ([index integerValue]==indexPath.item)
        {
            cell.selectImage.image=[UIImage imageNamed:@"ico_check_select"];
            cell.isSelect=YES;
        }
        
    }

    
    
    
    
    
    PHAsset *asset=_dataArray[indexPath.item];
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.synchronous = YES;
    options.resizeMode = PHImageRequestOptionsResizeModeExact;
//    CGSize size = CGSizeMake(asset.pixelWidth > scaleWidth ? scaleWidth : asset.pixelWidth, asset.pixelHeight > scaleWidth ? scaleWidth : asset.pixelHeight);
    CGSize size = CGSizeMake(asset.pixelWidth , asset.pixelHeight);
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        
        cell.imageView.image=result;
    }];
    
    return cell;
    
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    PHAsset *asset=_dataArray[indexPath.item];
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.synchronous = YES;
    options.resizeMode = PHImageRequestOptionsResizeModeExact;
    //    CGSize size = CGSizeMake(asset.pixelWidth > scaleWidth ? scaleWidth : asset.pixelWidth, asset.pixelHeight > scaleWidth ? scaleWidth : asset.pixelHeight);
    CGSize size = CGSizeMake(asset.pixelWidth , asset.pixelHeight);
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        
        PhotosCollectionDetailViewController *vc=[[PhotosCollectionDetailViewController alloc]init];
        vc.img=result;
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    
    
    
    
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
