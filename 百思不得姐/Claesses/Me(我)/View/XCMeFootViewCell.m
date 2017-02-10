//
//  XCMeFootViewCell.m
//  百思不得姐
//
//  Created by liuxingchen on 17/1/18.
//  Copyright © 2017年 liuxingchen. All rights reserved.
//

#import "XCMeFootViewCell.h"
#import "XCMeFootItem.h"
@interface XCMeFootViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
@implementation XCMeFootViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
-(void)setItem:(XCMeFootItem *)item
{
    _item = item;
    [_iconView sd_setImageWithURL:[NSURL URLWithString:item.icon]];
    _nameLabel.text = item.name;
}
@end
