//
//  UITextField+Placeholder.m
//  百思不得姐
//
//  Created by liuxingchen on 17/1/18.
//  Copyright © 2017年 liuxingchen. All rights reserved.
//

#import "UITextField+Placeholder.h"
#import <objc/message.h>
@implementation UITextField (Placeholder)
+(void)load
{
    
    Method setPlaceholderMethod = class_getInstanceMethod(self, @selector(setPlaceholder:));
    Method setXc_PlaceholderMethod = class_getInstanceMethod(self, @selector(setXc_Placeholder:));
    //添加交换方法把系统的方法换成自定义的方法
    method_exchangeImplementations(setPlaceholderMethod, setXc_PlaceholderMethod);
}
-(void)setPlaceholderColor:(UIColor *)placeholderColor
{
    //添加成员属性
    objc_setAssociatedObject(self, @"placeholderColor", placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // 快速设置占位文字颜色 => 文本框占位文字可能是label => 验证占位文字是label => 拿到label => 查看label属性名(1.runtime 2.断点)
    /**
     通过断点调试找到placeholderLabel属性，用kvc修换占位文字颜色
     如果单纯的使用kvc修改占位文字颜色，会产生bug
     如果先设置占位文字，在设置占位文字颜色会没有占位文字颜色，
     所以需要用runtime给textFild添加自定义的属性，然后添加交换方法
     */
    UILabel *placeholderLabel  = [self valueForKey:@"placeholderLabel"];
    placeholderLabel.textColor = placeholderColor;
    
}
-(UIColor *)placeholderColor
{
    return objc_getAssociatedObject(self, @"placeholderColor");
}
// 设置占位文字
// 设置占位文字颜色
- (void)setXc_Placeholder:(NSString *)placeholder
{
    [self setXc_Placeholder:placeholder];
    self.placeholderColor = self.placeholderColor;
}
@end
