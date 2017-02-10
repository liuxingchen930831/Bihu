//
//  XCSettingViewController.m
//  百思不得姐
//
//  Created by liuxingchen on 17/1/13.
//  Copyright © 2017年 liuxingchen. All rights reserved.
//

#import "XCSettingViewController.h"
#import "XCFileCalculateTool.h"
#import "SDImageCache.h"
#define CachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
static NSString *const cellID = @"cell";
@interface XCSettingViewController ()
@property (nonatomic, assign) NSInteger totalSize;
@end

@implementation XCSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    [SVProgressHUD showWithStatus:@"正在计算缓存大小...."];
    [XCFileCalculateTool getFileSize:CachePath completion:^(NSInteger totalSize) {
        _totalSize = totalSize;
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    }];
};
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.textLabel.text = [self siZeString];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [XCFileCalculateTool removeDirectoryPath:CachePath];
    //总大小清空
    _totalSize = 0;
    [self.tableView reloadData];
}
// 获取缓存尺寸字符串
-(NSString *)siZeString
{
    NSInteger totalSize = _totalSize;
    NSString *sizeStr = @"清除缓存";
    // MB KB B
    if (totalSize > 1000 * 1000) {
        // MB
        CGFloat sizeF = totalSize / 1000.0 / 1000.0;
        sizeStr = [NSString stringWithFormat:@"%@(%.1fMB)",sizeStr,sizeF];
    } else if (totalSize > 1000) {
        // KB
        CGFloat sizeF = totalSize / 1000.0;
        sizeStr = [NSString stringWithFormat:@"%@(%.1fKB)",sizeStr,sizeF];
    } else if (totalSize > 0) {
        // B
        sizeStr = [NSString stringWithFormat:@"%@(%.ldB)",sizeStr,totalSize];
    }
    
    return sizeStr;
}
@end
