//
//  XCADItem.h
//  百思不得姐
//
//  Created by liuxingchen on 17/1/15.
//  Copyright © 2017年 liuxingchen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCADItem : NSObject
/** 广告地址 */
@property (nonatomic, copy) NSString * w_picurl;
/** 点击广告跳转的界面 */
@property (nonatomic, strong) NSString * ori_curl;
@property (nonatomic,assign)CGFloat w;
@property (nonatomic,assign)CGFloat h;
@end
