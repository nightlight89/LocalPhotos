//
//  PhotoTableViewController.m
//  Photo
//
//  Created by 王程鹏 on 16/7/5.
//  Copyright © 2016年 baling. All rights reserved.
//

#import "PhotoTableViewController.h"
#import "PhotosTableViewCell.h"

#import "PhotoCollectionViewController.h"

@interface PhotoTableViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView    *_tableView;
    NSMutableArray *_dataArray;
    
}

@end

@implementation PhotoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataArray=[[NSMutableArray alloc]init];
    [self createTableView];
    
    [self getPhotos];
}

- (void)getPhotos
{
    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil];
    
    for (PHAssetCollection *assetCollection in assetCollections) {
        [_dataArray addObject:assetCollection];
    }
    
    [_tableView reloadData];
    
}

- (void)createTableView
{
    _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [_tableView registerClass:[PhotosTableViewCell class] forCellReuseIdentifier:@"PhotosTableViewCell"];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PhotosTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"PhotosTableViewCell"];
    
    PHAssetCollection *asset=_dataArray[indexPath.row];
    cell.title.text=asset.localizedTitle;
    PHFetchResult *fectchResult = [PHAsset fetchAssetsInAssetCollection:asset options:nil];
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    // 同步获得图片, 只会返回1张图片
    options.synchronous = YES;
    options.resizeMode = PHImageRequestOptionsResizeModeFast;

    for (PHAsset *ass in fectchResult) {
        CGSize size = CGSizeMake(ass.pixelWidth , ass.pixelHeight);
        [[PHImageManager defaultManager] requestImageForAsset:ass targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            cell.headImage.image=result;
        }];
    }
    
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PhotoCollectionViewController *vc=[[PhotoCollectionViewController alloc]init];
    PHAssetCollection *asset=_dataArray[indexPath.row];
    vc.asset=asset;
    [self.navigationController pushViewController:vc animated:YES];
    
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
