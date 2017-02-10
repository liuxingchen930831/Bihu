//
//  XCTopicViewController.m
//  百思不得姐
//
//  Created by liuxingchen on 17/2/9.
//  Copyright © 2017年 liuxingchen. All rights reserved.
//

#import "XCTopicViewController.h"
#import "XCAllItem.h"
#import "XCtopicCell.h"
#import "MJRefresh.h"
#import "XCCommentViewController.h"
@interface XCTopicViewController ()

/**最后一条帖子数据的描述信息，用来加载下一页数据*/
@property(nonatomic,copy)NSString * maxtime;
/** 所有帖子数据 */
@property (nonatomic, strong) NSMutableArray<XCAllItem *> *topics;
@end

static NSString * const XCtopicCellID = @"XCtopicCellID";

@implementation XCTopicViewController
-(XCTopicType)type
{
    return 0;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XCtopicCell class]) bundle:nil] forCellReuseIdentifier:XCtopicCellID];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //设置tableView的内边距，解决上拉下拉有些cell不显示的问题
    self.tableView.contentInset = UIEdgeInsetsMake(NavMaxY + titleViewH, 0, tabbarH, 0);
    //tableView滚动条的位置
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tabbarButtonDidRepeatClick) name:XCTabbarButtonDidRepeatClickNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(titleButtonDidRepeatClick) name:XCtitleButtonDidRepeatClickNotification object:nil];
    [self setupRefresh];
}
-(void)dealloc
{
    NSLog(@"%@",self);
    [[NSNotificationCenter defaultCenter]removeObserver:self];
};
- (void)setupRefresh
{
//    // 广告条
//    UILabel *label = [[UILabel alloc] init];
//    label.backgroundColor = [UIColor blackColor];
//    label.frame = CGRectMake(0, 0, 0, 30);
//    label.textColor = [UIColor whiteColor];
//    label.text = @"广告";
//    label.textAlignment = NSTextAlignmentCenter;
//    self.tableView.tableHeaderView = label;
    
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    //自动切换透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    
}

-(void)tabbarButtonDidRepeatClick
{
    //重复点击的如果不是精华按钮
    if (self.view.window ==nil) return;
    //如果显示在正中间的tableView不是自己
    if (self.tableView.scrollsToTop ==NO)return;
    [self.tableView.mj_header beginRefreshing];
}

-(void)titleButtonDidRepeatClick
{
    [self tabbarButtonDidRepeatClick];
}
#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.tableView.mj_footer.hidden = (self.topics.count == 0);
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XCtopicCell *cell = [tableView dequeueReusableCellWithIdentifier:XCtopicCellID];
    cell.topic = self.topics[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XCCommentViewController *vc = [[XCCommentViewController alloc]init];
    vc.topic =self.topics[indexPath.row];

    [self.navigationController pushViewController:vc animated:YES];
}
/**
 这个方法特点：
 - 1.默认情况下(没有设置estimatedHeight)每次刷新表格时，这个方法就一次性调用多少次，每次reloadData时，这个方法就会调用
 - 2.每次有cell进入屏幕范围内，就会调用一次
 针对以上的特点思考：如果每次都要调用这个方法都要去计算cell的高度，这样写不严谨，所以就要考虑如果以前如果算过cell的高度，就直接返回
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.topics[indexPath.row].cellHeight;
}
/**
 估算高度的好处:用到哪个cell才会调用这个方法计算cell的高度,降低heightForRowAtIndexPath方法的调用频率
 缺点:滚动条的长度是假的，不稳定，甚至卡顿
 */
//-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 200;
//}
#pragma mark - 数据处理
/**
 *  发送请求给服务器，下拉刷新数据
 */
- (void)loadNewData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary  dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    [manager GET:basicUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //储存maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 字典数组 -> 模型数据
        self.topics =  [XCAllItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.tableView reloadData];
        
        //结束刷新
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
        
    }];
    //结束刷新
    [self.tableView.mj_header endRefreshing];
}

/**
 *  发送请求给服务器，上拉加载更多数据
 */
- (void)loadMoreData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary  dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    parameters[@"maxtime"] = self.maxtime;
    [manager GET:basicUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //储存maxtime
        self.maxtime = responseObject [@"info"][@"maxtime"];
        
        // 字典数组 -> 模型数据
        NSArray *moreAllItems =  [XCAllItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        // 累加到旧数组的后面
        [self.topics addObjectsFromArray:moreAllItems];
        
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
        // 结束刷新
    }];
    [self.tableView.mj_footer endRefreshing];
}
#pragma mark - scrollView代理方法

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [[SDImageCache sharedImageCache] clearMemory];
}
@end

