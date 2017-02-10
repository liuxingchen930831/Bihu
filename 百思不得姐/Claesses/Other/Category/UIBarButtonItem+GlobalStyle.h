//
//  UIBarButtonItem+GlobalStyle.h
//  百思不得姐
//
//  Created by liuxingchen on 17/1/12.
//  Copyright © 2017年 liuxingchen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (GlobalStyle)
+(UIBarButtonItem *)navItemWithImage:(UIImage *)image hlghImage:(UIImage *)higHlightImage  target:(id)target action:(SEL)action;
+(UIBarButtonItem *)navItemWithImage:(UIImage *)image selImage:(UIImage *)selectImage  target:( id)target action:(SEL)action;
+(UIBarButtonItem *)backItemWithImage:(UIImage *)image hlghImage:(UIImage *)higHlightImage  target:(id)target action:(SEL)action title:(NSString *)title;
@end
