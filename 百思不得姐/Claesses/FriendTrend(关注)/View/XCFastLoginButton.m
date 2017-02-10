//
//  XCFastLoginButton.m
//  百思不得姐
//
//  Created by liuxingchen on 17/1/17.
//  Copyright © 2017年 liuxingchen. All rights reserved.
//

#import "XCFastLoginButton.h"

@implementation XCFastLoginButton

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.XC_y = 0;
    self.imageView.XC_CenterX = self.XC_width * 0.5;
    
    self.titleLabel.XC_y = self.XC_height - self.titleLabel.XC_height;
    [self.titleLabel sizeToFit];
    self.titleLabel.XC_CenterX = self.XC_width * 0.5;
}
@end
