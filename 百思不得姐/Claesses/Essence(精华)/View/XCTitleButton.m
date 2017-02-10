//
//  XCTitleButton.m
//  百思不得姐
//
//  Created by liuxingchen on 17/1/19.
//  Copyright © 2017年 liuxingchen. All rights reserved.
//

#import "XCTitleButton.h"

@implementation XCTitleButton
-(void)setHighlighted:(BOOL)highlighted
{
    //只要重写了这个方法，按钮就无法进入highlighted状态
    
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    }
    return self;
}
@end
