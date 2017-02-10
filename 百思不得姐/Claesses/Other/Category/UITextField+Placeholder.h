//
//  UITextField+Placeholder.h
//  百思不得姐
//
//  Created by liuxingchen on 17/1/18.
//  Copyright © 2017年 liuxingchen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Placeholder)
/**
 使用placeholderColor属性需要先设置placeholderColor的颜色
 在设置placeholder.text
 */
@property UIColor *placeholderColor;
- (void)setXc_Placeholder:(NSString *)placeholder;
@end
