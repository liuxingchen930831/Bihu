//
//  XCSubItemCell.m
//  百思不得姐
//
//  Created by liuxingchen on 17/1/16.
//  Copyright © 2017年 liuxingchen. All rights reserved.
//

#import "XCSubItemCell.h"
#import "UIImageView+WebCache.h"
#import "XCSubItem.h"
@interface XCSubItemCell ()
@property (weak, nonatomic) IBOutlet UIImageView *subImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

@end
@implementation XCSubItemCell
-(void)setItem:(XCSubItem *)item
{
    _item = item;
    [_subImageView sd_setImageWithURL:[NSURL URLWithString:item.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    _nameLabel.text = item.theme_name;
    [self resolveNumber];
}

-(void)resolveNumber
{
    NSString *numStr = [NSString stringWithFormat:@"%@人订阅",_item.sub_number];
    NSInteger number = _item.sub_number.integerValue;
    if (number > 10000) {
        CGFloat numFlot = number / 10000.0;
        numStr = [NSString stringWithFormat:@"%.1f万人订阅",numFlot];
        //把0替换掉成"空"
        numStr = [numStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    _numberLabel.text = numStr;

}
- (void)awakeFromNib {
    [super awakeFromNib];
    //设置头像圆角为width的一半
    self.subImageView.layer.cornerRadius = 30;
    //超出部分裁切
    self.subImageView.layer.masksToBounds = YES;
}

@end
