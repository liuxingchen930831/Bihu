//
//  UIView+Frame.h
//  百思不得姐
//
//  Created by liuxingchen on 17/1/12.
//  Copyright © 2017年 liuxingchen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)
@property(nonatomic,assign)CGFloat XC_width;
@property(nonatomic,assign)CGFloat XC_height;
@property(nonatomic,assign)CGFloat XC_x;
@property(nonatomic,assign)CGFloat XC_y;
@property(nonatomic,assign)CGFloat XC_CenterX;
@property(nonatomic,assign)CGFloat XC_CenterY;
+(instancetype)XC_viewForfXib;
@end
