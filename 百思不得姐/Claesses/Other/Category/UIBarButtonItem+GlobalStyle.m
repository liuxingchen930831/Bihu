//
//  UIBarButtonItem+GlobalStyle.m
//  百思不得姐
//
//  Created by liuxingchen on 17/1/12.
//  Copyright © 2017年 liuxingchen. All rights reserved.
//

#import "UIBarButtonItem+GlobalStyle.h"

@implementation UIBarButtonItem (GlobalStyle)
+(UIBarButtonItem *)navItemWithImage:(UIImage *)image hlghImage:(UIImage *)higHlightImage  target:(nullable id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:higHlightImage forState:UIControlStateHighlighted];
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    /**
     解决button点左边其他位置也会变高亮问题，
     */
    UIView *containView = [[UIView alloc]initWithFrame:button.bounds];
    [containView addSubview:button];
    
    return [[UIBarButtonItem alloc]initWithCustomView:containView];
}
+(UIBarButtonItem *)navItemWithImage:(UIImage *)image selImage:(UIImage *)selectImage  target:(nullable id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:selectImage forState:UIControlStateSelected];
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    /**
     解决button点左边其他位置也会变高亮问题，
     */
    UIView *containView = [[UIView alloc]initWithFrame:button.bounds];
    [containView addSubview:button];
    
    return [[UIBarButtonItem alloc]initWithCustomView:containView];
}
+(UIBarButtonItem *)backItemWithImage:(UIImage *)image hlghImage:(UIImage *)higHlightImage  target:(id)target action:(SEL)action title:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:higHlightImage forState:UIControlStateHighlighted];
    [button sizeToFit];
    //设置button的内边距
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
   return  [[UIBarButtonItem alloc]initWithCustomView:button];
}
@end
