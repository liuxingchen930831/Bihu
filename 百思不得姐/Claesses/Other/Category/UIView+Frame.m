//
//  UIView+Frame.m
//  百思不得姐
//
//  Created by liuxingchen on 17/1/12.
//  Copyright © 2017年 liuxingchen. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

+(instancetype)XC_viewForfXib
{
   return  [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}
-(void)setXC_width:(CGFloat)XC_width
{
    CGRect rect = self.frame;
    rect.size.width =  XC_width;
    self.frame = rect;
}
-(CGFloat)XC_width
{
    return self.frame.size.width;
}
-(void)setXC_height:(CGFloat)XC_height
{
    CGRect rect = self.frame;
    rect.size.height =  XC_height;
    self.frame = rect;
}
-(CGFloat)XC_height
{
    return self.frame.size.height;
}
-(void)setXC_x:(CGFloat)XC_x
{
    CGRect rect = self.frame;
    rect.origin.x = XC_x;
    self.frame = rect;
}
-(CGFloat)XC_x
{
    return self.frame.origin.x;
}
-(void)setXC_y:(CGFloat)XC_y
{
    CGRect rect = self.frame;
    rect.origin.y = XC_y;
    self.frame = rect;
}
-(CGFloat)XC_y

{
    return self.frame.origin.y;
}
-(void)setXC_CenterX:(CGFloat)XC_CenterX
{
    CGPoint center = self.center;
    center.x = XC_CenterX;
    self.center = center;
}
-(CGFloat)XC_CenterX
{
    return self.center.x;
}
-(void)setXC_CenterY:(CGFloat)XC_CenterY
{
    CGPoint center = self.center;
    center.y = XC_CenterY;
    self.center = center;
}
-(CGFloat)XC_CenterY
{
    return self.center.y;
}
@end
