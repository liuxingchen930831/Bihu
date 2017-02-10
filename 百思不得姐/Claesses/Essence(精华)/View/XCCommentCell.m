//
//  XCCommentCell.m
//  百思不得姐
//
//  Created by liuxingchen on 17/2/9.
//  Copyright © 2017年 liuxingchen. All rights reserved.
//

#import "XCCommentCell.h"
#import "XCComment.h"
#import "XCUser.h"
@interface XCCommentCell ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@end
@implementation XCCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}
- (void)setComment:(XCComment *)comment
{
    _comment = comment;
    if (comment.voiceuri.length != 0) {
        self.voiceButton.hidden = NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd''",comment.voicetime] forState:UIControlStateNormal];
    }else{
        self.voiceButton.hidden = YES;
    }
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:comment.user.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.contentLabel.text = comment.content;
    self.usernameLabel.text = comment.user.username;
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd",comment.like_count];
    if ([comment.user.sex isEqualToString:XCUserSexMale]) {
        self.sexView.image = [UIImage imageNamed:@"Profile_manIcon"];
    } else{
        self.sexView.image = [UIImage imageNamed:@"Profile_womanIcon"];
    }
}
@end
