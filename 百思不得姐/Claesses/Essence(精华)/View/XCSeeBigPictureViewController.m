//
//  XCSeeBigPictureViewController.m
//  百思不得姐
//
//  Created by liuxingchen on 17/2/8.
//  Copyright © 2017年 liuxingchen. All rights reserved.
//

#import "XCSeeBigPictureViewController.h"
#import "XCAllItem.h"
#import <Photos/Photos.h>
@interface XCSeeBigPictureViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property(nonatomic,weak)UIScrollView * scorllView ;
@property(nonatomic,weak)UIImageView * imageView ;
/** 当前App对应的自定义相册 */
- (PHAssetCollection *)createdCollection;
/** 返回刚才保存到【相机胶卷】的图片 */
- (PHFetchResult<PHAsset *> *)createdAssets;
@end
@implementation XCSeeBigPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIScrollView * scrollView = ({
        UIScrollView * scrollView = [[UIScrollView alloc]init];
        scrollView.backgroundColor = [UIColor clearColor];
        scrollView.frame = [UIScreen mainScreen].bounds;
        [scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss:)]];
        [self.view insertSubview:scrollView atIndex:0];
        _scorllView = scrollView;
        scrollView;
    });
    UIImageView *imageView = ({
        UIImageView *imageView = [[UIImageView alloc]init];
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.image1] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (imageView == nil) {
                [SVProgressHUD showErrorWithStatus:@"下载失败"];
                return;
            }
            self.saveButton.enabled = YES;
        }];
        imageView.XC_width = scrollView.XC_width;
        imageView.XC_height = scrollView.XC_width * self.topic.height / self.topic.width;
        imageView.XC_x = 0;
        if (imageView.XC_height > XCScreenH) { //超过一个屏幕
            imageView.XC_y = 0;
            scrollView.contentSize = CGSizeMake(0, imageView.XC_height);
            
        }else{
            imageView.XC_CenterY = scrollView.XC_height * 0.5;
        }
        
        imageView;
    });
    [scrollView addSubview:imageView];
    _imageView = imageView;
    
    CGFloat maxScale = self.topic.width / imageView.XC_width;
    if (maxScale > 1.0) {
        scrollView.maximumZoomScale = maxScale;
        scrollView.delegate = self;
    }
}

#pragma mark - <UIScrollViewDelegate>
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}
- (IBAction)dismiss:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)save:(id)sender
{
    PHAuthorizationStatus oldStatus = [PHPhotoLibrary authorizationStatus];
    
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
       dispatch_async(dispatch_get_main_queue(), ^{
          
           if (status == PHAuthorizationStatusDenied) { // 用户拒绝当前App访问相册
               if (oldStatus != PHAuthorizationStatusNotDetermined) {
                   XCLog(@"拒绝了app访问相册");
               }
           }else if (status == PHAuthorizationStatusAuthorized ){   // 用户允许当前App访问相册
                [self saveImageIntoAlbum];
           }else if (status == PHAuthorizationStatusRestricted){ //无法访问相册
               [SVProgressHUD showErrorWithStatus:@"无法访问相册"];
           }
       });
    }];
}
- (void)saveImageIntoAlbum
{
    //获得图片
    PHFetchResult<PHAsset *> *createdAssets = self.createdAssets;
    if (createdAssets ==nil) {
        [SVProgressHUD showErrorWithStatus:@"保存图片失败"];
        return;
    }
    //获得相册
    PHAssetCollection *createdCollection = self.createdCollection;
    if (createdCollection ==nil) {
        [SVProgressHUD showErrorWithStatus:@"创建-获取相册失败"];
        return;
    }
    NSError * error = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:createdCollection];
        [request insertAssets:createdAssets atIndexes:[NSIndexSet indexSetWithIndex:0]];
    } error:&error];
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
}
#pragma mark - 获得当前App对应的自定义相册
-(PHAssetCollection *)createdCollection
{
    //获得软件名字
    NSString *title = [NSBundle mainBundle].infoDictionary[(NSString *)kCFBundleNameKey];
    
    //获得所有自定义相册
    PHFetchResult<PHAssetCollection *> *collections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    // 查找当前App对应的自定义相册
    for (PHAssetCollection * collection in collections) {
        if ([collection.localizedTitle isEqualToString:title]) {
            return collection;
        }
    }
    //当前自定义相册没有被创建过，创建一个自定义相册
    NSError *error = nil;
    __block NSString *createdCollectionID = nil;
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        createdCollectionID = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title].placeholderForCreatedAssetCollection.localIdentifier;
        
    } error:&error];
    if (error)return nil;
    
    // 根据唯一标识获得刚才创建的相册
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[createdCollectionID] options:nil].firstObject;
}
-(PHFetchResult<PHAsset *> *)createdAssets
{
    NSError *error = nil;
    __block NSString *assetID = nil;
    //保存图片到相机胶卷
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        assetID = [PHAssetChangeRequest creationRequestForAssetFromImage:self.imageView.image].placeholderForCreatedAsset.localIdentifier;
    } error:&error];
    // 获取刚才保存的相片
    return [PHAsset fetchAssetsWithLocalIdentifiers:@[assetID] options:nil];
}
@end
