//
//  XCTopicVoiceView.m
//  百思不得姐
//
//  Created by liuxingchen on 17/2/7.
//  Copyright © 2017年 liuxingchen. All rights reserved.
//

#import "XCTopicVoiceView.h"
#import "XCAllItem.h"
#import "XCSeeBigPictureViewController.h"
@interface XCTopicVoiceView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *voiceTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *placeholderimageView;

@end
@implementation XCTopicVoiceView

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
    }];
    // 播放数量
    if (topic.playcount >= 10000) {
        self.playCountLabel.text = [NSString stringWithFormat:@"%.1f万播放", topic.playcount / 10000.0];
    } else {
        self.playCountLabel.text = [NSString stringWithFormat:@"%zd播放", topic.playcount];
    }
    // %02d : 占据2位，多余的空位用0填补
    self.voiceTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",topic.voicetime / 60,topic.voicetime %60];
}
@end
