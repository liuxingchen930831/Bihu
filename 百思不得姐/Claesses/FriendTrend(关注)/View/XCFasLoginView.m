//
//  XCFasLoginView.m
//  百思不得姐
//
//  Created by liuxingchen on 17/1/17.
//  Copyright © 2017年 liuxingchen. All rights reserved.
//

#import "XCFasLoginView.h"

@implementation XCFasLoginView

+(instancetype)loadFastLoginView
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
@end
