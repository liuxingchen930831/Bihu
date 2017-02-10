//
//  XCLoginRegisterView.m
//  百思不得姐
//
//  Created by liuxingchen on 17/1/17.
//  Copyright © 2017年 liuxingchen. All rights reserved.
//

#import "XCLoginRegisterView.h"

@implementation XCLoginRegisterView


+(instancetype)loadloginView
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]firstObject];
}
+(instancetype)loadRegisterView
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}
@end
