//
//  XCCommentHeaderView.m
//  百思不得姐
//
//  Created by liuxingchen on 17/2/9.
//  Copyright © 2017年 liuxingchen. All rights reserved.
//

#import "XCCommentHeaderView.h"

@interface XCCommentHeaderView ()
/** 内部的label */
@property (nonatomic, weak) UILabel *label;
@end

@implementation XCCommentHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        UILabel *label = [[UILabel alloc] init];
        label.XC_x = XCMargin;
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:label];
        self.label = label;
    }
    return self;
}
-(void)setText:(NSString *)text
{
    _text = [text copy];
    self.label.text = text;
}
@end
