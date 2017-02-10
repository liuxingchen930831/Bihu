//
//  XCCommentCell.h
//  百思不得姐
//
//  Created by liuxingchen on 17/2/9.
//  Copyright © 2017年 liuxingchen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XCComment;
@interface XCCommentCell : UITableViewCell
/** 评论模型 */
@property(nonatomic,strong)XCComment * comment ;
@end
