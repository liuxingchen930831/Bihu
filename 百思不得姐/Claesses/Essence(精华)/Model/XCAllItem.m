//
//  XCAllItem.m
//  百思不得姐
//
//  Created by liuxingchen on 17/1/23.
//  Copyright © 2017年 liuxingchen. All rights reserved.
//

#import "XCAllItem.h"

@implementation XCAllItem
-(CGFloat)cellHeight
{
    // 如果已经计算过，就直接返回
    if (_cellHeight !=0 ) return _cellHeight;   
    //文字内容y值
    _cellHeight += 55;
    
    //文字的高度
    CGSize textMaxSize = CGSizeMake(XCScreenW - 2 * XCMargin, MAXFLOAT);
    _cellHeight += [self.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height + XCMargin;
    //中间控件的frame
    if (self.type != XCTopicTypeWord) {// 中间有内容（图片、声音、视频）
        /*
         self.width     middleW
         ----------- == -------
         self.height    middleH
         
         self.width * middleH == middleW * self.height
         */
        CGFloat middleW = textMaxSize.width - XCMargin;
        CGFloat middleH = middleW * self.height / self.width;
        if (middleH >= XCScreenH) { // 显示的图片高度超过一个屏幕，就是超长图片
            middleH = 200;
            self.bigPicture = YES;
        }
        CGFloat middleY = _cellHeight;
        CGFloat middleX = XCMargin;
        self.middleFrame = CGRectMake(middleX, middleY, middleW, middleH);
        _cellHeight += middleH + XCMargin;
    }
    if (self.top_cmt.count ==1 ) {//有最热评论
        // 最热评论标题
        _cellHeight += 20;
        //最热评论内容
        NSDictionary *cmt = self.top_cmt.firstObject;
        NSString *content = cmt[@"content"];
        if (content.length ==0) {
            content = @"[语音评论]";
        }
        NSString *username = cmt[@"user"][@"username"];
        NSString *cmtText = [NSString stringWithFormat:@"%@:%@",username,content];
        
        _cellHeight += [cmtText boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil].size.height + XCMargin;
    }
    //底部工具条
    _cellHeight += 35 + XCMargin;
    
    return _cellHeight;
}
-(NSString *)passtime
{
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    // NSString -> NSDate
    NSDate *createdAtDate = [fmt dateFromString:_passtime];
    
    // 比较【发帖时间】和【手机当前时间】的差值
    NSDateComponents *cmps = [createdAtDate intervalToNow];
    
    if (createdAtDate.isThisYear) {
        if (createdAtDate.isToday) { // 今天
            if (cmps.hour >= 1) { // 时间差距 >= 1小时
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1) { // 1分钟 =< 时间差距 <= 59分钟
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else {
                return @"刚刚";
            }
        } else if (createdAtDate.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:createdAtDate];
        } else { // 今年的其他时间
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:createdAtDate];
        }
    } else { // 非今年
        return _passtime;
    }
}
@end
