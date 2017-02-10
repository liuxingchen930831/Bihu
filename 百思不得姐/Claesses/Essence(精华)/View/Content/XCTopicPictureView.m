//
//  XCTopicPictureView.m
//  百思不得姐
//
//  Created by liuxingchen on 17/2/7.
//  Copyright © 2017年 liuxingchen. All rights reserved.
//

#import "XCTopicPictureView.h"
#import "XCAllItem.h"
#import "XCSeeBigPictureViewController.h"
@interface XCTopicPictureView ()
@property (weak, nonatomic) IBOutlet UIButton *seeBigPictureButton;
@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *placeholderimageView;
@end
@implementation XCTopicPictureView

-(void)awakeFromNib
{
    [super awakeFromNib];
    //关闭默认的自动伸缩功能
    self.autoresizingMask = UIViewAutoresizingNone;
    self.imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(seeBigPictureTap)];
    [self.imageView addGestureRecognizer:tap];
}
- (void)seeBigPictureTap
{
    XCSeeBigPictureViewController *seeBigPicture = [[XCSeeBigPictureViewController alloc]init];
    seeBigPicture.topic = self.topic;
    [self.window.rootViewController presentViewController:seeBigPicture animated:YES completion:nil];
}
-(void)setTopic:(XCAllItem *)topic
{
    _topic = topic;
    
    self.placeholderimageView.hidden = NO;
    
    [self.imageView XC_setOriginImage:topic.image1 thumbnailImage:topic.image0 placeholder:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (image == nil) return;
        
        self.placeholderimageView.hidden = YES;
        //处理超长图片的大小
        if (topic.isBigPicture) {
            CGFloat imageW = topic.middleFrame.size.width;
            CGFloat imageH = imageW * topic.height / topic.width;
            // 开启上下文
            UIGraphicsBeginImageContext(CGSizeMake(imageW, imageH));
            // 绘制图片到上下文中
            [self.imageView.image drawInRect:CGRectMake(0, 0, imageW, imageH)];
            self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
            // 关闭上下文
            UIGraphicsEndImageContext();
        }
    }];
    //gif标签
    if ([topic.image1.lowercaseString hasSuffix:@"gif"]) {
        self.gifImageView.hidden = NO;
    }else{
        self.gifImageView.hidden = YES;
    }
    //点击查看大图
    if (topic.isBigPicture) { //超长图
        self.seeBigPictureButton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeTop;
        self.imageView.clipsToBounds = YES;
    }else{
        self.seeBigPictureButton.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.imageView.clipsToBounds = NO;
    }
}

@end
