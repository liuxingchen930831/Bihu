//
//  XCFileCalculateTool.h
//  百思不得姐
//
//  Created by liuxingchen on 17/1/19.
//  Copyright © 2017年 liuxingchen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCFileCalculateTool : NSObject
/**
 *  获取文件夹尺寸
 *
 *  @param directoryPath 文件夹路径
 *
 *  @return 返回文件夹尺寸
 */
+ (void)getFileSize:(NSString *)directoryPath completion:(void(^)(NSInteger))completion;
/**
 *  删除文件夹所有文件
 *
 *  @param directoryPath 文件夹路径
 */
+ (void)removeDirectoryPath:(NSString *)directoryPath;


@end
