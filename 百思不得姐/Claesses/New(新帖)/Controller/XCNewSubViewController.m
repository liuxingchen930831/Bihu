//
//  XCNewSubViewController.m
//  百思不得姐
//
//  Created by liuxingchen on 17/1/16.
//  Copyright © 2017年 liuxingchen. All rights reserved.
//

#import "XCNewSubViewController.h"
#import "XCSubItem.h"
#import "XCSubItemCell.h"
#define tuijianguanzhu @"推荐关注"
static NSString * const cellID = @"cell";
@interface XCNewSubViewController ()
@property(nonatomic,strong)NSArray * itemArray ;
@property(nonatomic,strong)AFHTTPSessionManager * mgr ;
@end

@implementation XCNewSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = tuijianguanzhu;
    [self.tableView registerNib:[UINib nibWithNibName:@"XCSubItemCell" bundle:nil]forCellReuseIdentifier:cellID];
    //隐藏分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [SVProgressHUD showWithStatus:@"加载数据ing....."];
    [self loadData];
}

-(void)loadData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    _mgr = manager;
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"tag_recommend";
    parameters[@"action"] = @"sub";
    parameters[@"c"] = @"topic";
    
    [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray * _Nullable responseObject) {
        
      self.itemArray = [XCSubItem mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
    }];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.itemArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XCSubItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    XCSubItem *item = self.itemArray[indexPath.row];
    cell.item = item;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
//页面即将结束的时候清除一些失败操作
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
    //取消之前的请求
    [_mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
}
@end
