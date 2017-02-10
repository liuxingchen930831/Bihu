//
//  XCLoginTextField.m
//  百思不得姐
//
//  Created by liuxingchen on 17/1/18.
//  Copyright © 2017年 liuxingchen. All rights reserved.
//

#import "XCLoginTextField.h"

@implementation XCLoginTextField
-(void)awakeFromNib
{
    [super awakeFromNib];
    //设置光标的颜色为白色
    self.tintColor = [UIColor whiteColor];
    [self addTarget:self action:@selector(textBegin) forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(textEnd) forControlEvents:UIControlEventEditingDidEnd];
    self.placeholderColor = [UIColor lightGrayColor];
}
-(void)textBegin
{
    self.placeholderColor = [UIColor whiteColor];
}
-(void)textEnd
{
    self.placeholderColor = [UIColor lightGrayColor];
}
@end
