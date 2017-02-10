//
//  XCAllItem.h
//  百思不得姐
//
//  Created by liuxingchen on 17/1/23.
//  Copyright © 2017年 liuxingchen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XCComment;
@interface XCAllItem : NSObject

typedef NS_ENUM(NSUInteger, XCTopicType) {
    /** 全部 */
    XCTopicTypeAll = 1,
    /** 图片 */
    XCTopicTypePicture = 10,
    /** 段子 */
    XCTopicTypeWord = 29,
    /** 声音 */
    XCTopicTypeVoice = 31,
    /** 视频 */
    XCTopicTypeVideo = 41
};

/** 用户的名字 */
@property (nonatomic, copy) NSString *name;
/** 用户的头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 帖子的文字内容 */
@property (nonatomic, copy) NSString *text;
/** 帖子审核通过的时间 */
@property (nonatomic, copy) NSString *passtime;
/** id */
@property (nonatomic, copy) NSString *ID; // id
/** 顶数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发\分享数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论数量 */
@property (nonatomic, assign) NSInteger comment;
/** 最热评论 */
@property (nonatomic, strong) NSArray *top_cmt;
/** 文章类型 全部1，图片10，段子29，声音31，视频41 */
@property (nonatomic, assign) NSInteger type;
/** 宽度(像素) */
@property (nonatomic, assign) NSInteger width;
/** 高度(像素) */
@property (nonatomic, assign) NSInteger height;
/** 小图 */
@property (nonatomic, copy) NSString *image0;
/** 中图 */
@property (nonatomic, copy) NSString *image2;
/** 原图 */
@property (nonatomic, copy) NSString *image1;
/** 是否为动图 */
@property (nonatomic, assign) BOOL is_gif;
/** 评论的最热评论 */
@property (nonatomic, strong) XCComment *topComment;

/** 音频时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 视频时长 */
@property (nonatomic, assign) NSInteger videotime;
/** 音频\视频的播放次数 */
@property (nonatomic, assign) NSInteger playcount;

/**与服务器无关属性自行添加*/

/**
 cell高度 
 */
@property(nonatomic,assign)CGFloat cellHeight ;
/** 中间内容的frame */
@property (nonatomic, assign) CGRect middleFrame;
/** 是否为超长图片 */
@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;
@end
