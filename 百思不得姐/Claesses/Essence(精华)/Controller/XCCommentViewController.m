//
//  XCCommentViewController.m
//  百思不得姐
//
//  Created by liuxingchen on 17/2/9.
//  Copyright © 2017年 liuxingchen. All rights reserved.
//

#import "XCCommentViewController.h"
#import "XCtopicCell.h"
#import "MJRefresh.h"
#import "XCAllItem.h"
#import "XCCommentCell.h"
#import "XCCommentHeaderView.h"
@interface XCCommentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) AFHTTPSessionManager *manager;

/** 暂时存储：最热评论 */
@property (nonatomic, strong) XCComment *topComment;

/** 最热评论 */
@property (nonatomic, strong) NSArray *hotComments;
/** 最新评论（所有的评论数据） */
@property (nonatomic, strong) NSMutableArray *latestComments;
@end

@implementation XCCommentViewController
static NSString * const XCCommentCellId = @"comment";
static NSString * const XCHeaderId = @"header";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评论";
    [self setupTableView];
    [self setupRefresh];
}
-(AFHTTPSessionManager *)manager
{
    if (_manager ==nil) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (void)setupTableView
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XCCommentCell class]) bundle:nil] forCellReuseIdentifier:XCCommentCellId];

    [self.tableView registerClass:[XCCommentHeaderView class] forHeaderFooterViewReuseIdentifier:XCHeaderId];
    
    self.tableView.estimatedRowHeight = 100;
    // 告诉tableView的真实高度是自动计算的，根据你的约束来计算
    self.tableView.rowHeight = UITableViewAutomaticDimension;

    XCtopicCell *cell = [XCtopicCell XC_viewForfXib];
    cell.topic = self.topic;
    cell.frame = CGRectMake(0, 0, XCScreenW, self.topic.cellHeight);
 
    UIView *header = [[UIView alloc]init];
    header.XC_height = cell.XC_height + 2 * XCMargin;
    [header addSubview:cell];
    
    self.tableView.tableHeaderView = header;
}
-(void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComment)];
}


-(void)loadNewComments
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"加载假数据" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self.tableView.mj_header endRefreshing];
    }];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)loadMoreComment
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"加载更多数据" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self.tableView.mj_footer endRefreshing];
    }];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}
#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XCCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:XCCommentCellId];
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    XCCommentHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:XCHeaderId];
    header.text = @"最新评论";
    return header;
}
@end
