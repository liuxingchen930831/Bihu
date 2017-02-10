//
//  XCtopicCell.m
//  百思不得姐
//
//  Created by liuxingchen on 17/2/6.
//  Copyright © 2017年 liuxingchen. All rights reserved.
//

#import "XCtopicCell.h"
#import "XCAllItem.h"
#import "XCTopicVideoView.h"
#import "XCTopicVoiceView.h"
#import "XCTopicPictureView.h"
@interface XCtopicCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *passtimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UILabel *top_cmtLabel;
@property (weak, nonatomic) IBOutlet UIView *top_cmtView;

/**
 视频控件
 */
@property (weak, nonatomic)  XCTopicVideoView * videoView;
/**
 音频控件
 */
@property (weak, nonatomic)  XCTopicVoiceView * voiceView;
/**
 图片控件
 */
@property (weak, nonatomic)  XCTopicPictureView * pictureView;
@end
@implementation XCtopicCell

-(void)awakeFromNib
{
    [super awakeFromNib];
//    self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
}
#pragma mark - lazy
-(XCTopicVideoView *)videoView
{
    if (_videoView ==nil) {
        XCTopicVideoView *videoView = [XCTopicVideoView XC_viewForfXib];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}
-(XCTopicVoiceView *)voiceView
{
    if (_voiceView ==nil) {
        XCTopicVoiceView *voiceView = [XCTopicVoiceView XC_viewForfXib];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}
-(XCTopicPictureView *)pictureView
{
    if (_pictureView ==nil) {
        XCTopicPictureView *pictureView = [XCTopicPictureView XC_viewForfXib];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}
-(void)setTopic:(XCAllItem *)topic
{
    _topic = topic;
    self.nameLabel.text = topic.name;
    self.passtimeLabel.text = topic.passtime;
    self.text_label.text = topic.text;
    UIImage *placeholderImage = [UIImage XC_circleImageNamed:@"defaultUserIcon"];
    
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:placeholderImage options:0 completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (!image ) return ;// 图片下载失败，直接返回，按照它的默认做法
        self.profileImageView.image = [image XC_circleImage];
    }];
    [self setupButtonTitle:self.dingButton number:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton number:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.repostButton number:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentButton number:topic.comment placeholder:@"评论"];
    
    if (topic.top_cmt.count==0) {//没有最热评论
        self.top_cmtView.hidden =YES;
    }else {//有最热评论
        self.top_cmtView.hidden =NO;
        NSDictionary *cmt = topic.top_cmt.firstObject;
        NSString *content = cmt[@"content"];
        if (content.length ==0) {
            content = @"[语音评论]";
        }
        NSString *username = cmt[@"user"][@"username"];
        self.top_cmtLabel.text = [NSString stringWithFormat:@"%@:%@",username,content];
    }
    //中间内容
    if (topic.type ==XCTopicTypeVideo) {//视频
        self.videoView.hidden = NO;
        self.videoView.topic = topic;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    }else if (topic.type ==XCTopicTypeVoice){//音频
        self.videoView.hidden = YES;
        self.voiceView.hidden = NO;
        self.voiceView.topic = topic;
        self.pictureView.hidden = YES;
        
    }else if (topic.type ==XCTopicTypePicture){//图片
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        self.pictureView.topic = topic;
        self.pictureView.hidden = NO;
    }else if(topic.type ==XCTopicTypeWord){//文字
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    if (self.topic.type ==XCTopicTypeVideo) {
        self.videoView.frame = self.topic.middleFrame;
    }else if (self.topic.type ==XCTopicTypeVoice) {
        self.voiceView.frame = self.topic.middleFrame;
    }else if (self.topic.type ==XCTopicTypePicture) {
        self.pictureView.frame = self.topic.middleFrame;
    }
}
-(void)setupButtonTitle:(UIButton *)button number:(NSInteger)number placeholder:(NSString *)placeholder
{
    if (number >= 10000) {
        [self.dingButton setTitle:[NSString stringWithFormat:@"%.1f万",number / 10000.0] forState:UIControlStateNormal];
    }else if (number > 0){
        [button setTitle:[NSString stringWithFormat:@"%zd",number] forState:UIControlStateNormal];
    }else{
        [button setTitle:placeholder forState:UIControlStateNormal]; //如果没有数据就不显示数量
    }
}
-(void)setFrame:(CGRect)frame
{
    frame.origin.x += XCMargin *0.5 ;
    frame.size.width -= XCMargin;
    frame.size.height -= XCMargin *0.5;
    [super setFrame:frame];
}
@end
