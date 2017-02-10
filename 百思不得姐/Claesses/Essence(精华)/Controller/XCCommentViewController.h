//
//  XCCommentViewController.h
//  百思不得姐
//
//  Created by liuxingchen on 17/2/9.
//  Copyright © 2017年 liuxingchen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XCAllItem;
@interface XCCommentViewController : UITableViewController
/** 帖子模型 */
@property(nonatomic,strong)XCAllItem * topic ;
@end
