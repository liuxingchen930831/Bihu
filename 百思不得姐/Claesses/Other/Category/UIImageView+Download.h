//
//  UIImageView+Download.h
//  百思不得姐
//
//  Created by liuxingchen on 17/2/8.
//  Copyright © 2017年 liuxingchen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@interface UIImageView (Download)

- (void)XC_setOriginImage:(NSString *)originImageURL thumbnailImage:(NSString *)thumbnailImageURL placeholder:(UIImage *)placeholder completed:(SDWebImageCompletionBlock)completedBlock;
- (void)XC_setHeader:(NSString *)headerUrl;
@end
