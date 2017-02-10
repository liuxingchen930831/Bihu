//
//  MeViewController.m
//  百思不得姐
//
//  Created by liuxingchen on 17/1/11.
//  Copyright © 2017年 liuxingchen. All rights reserved.
//

#import "MeViewController.h"
#import "XCSettingViewController.h"
#import "XCMeFootViewCell.h"
#import "XCMeFootItem.h"
#import "XCWebViewController.h"
@interface MeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

/** 存放模型数组 */
@property(nonatomic,strong)NSMutableArray * footItems ;
@property(nonatomic,weak)UICollectionView  * collectionView ;
@end
static NSString *const cellID = @"footViewCell";

static NSInteger  const cols = 4 ;
static CGFloat const margin = 1;
#define itemWH (XCScreenW - (cols - 1) * margin)/cols
@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settingNav];
    [self setupcollectionView];
    [self loadData];
    //tableView分组样式，有额外头部和尾部的间距
    self.tableView.sectionFooterHeight = 10;
    self.tableView.sectionHeaderHeight = 0;
    //解决tableView分组样式往下走了一段距离问题
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    
    
}
-(NSMutableArray *)footItems
{
    if (_footItems ==nil) {
        _footItems = [NSMutableArray array];
    }
    return _footItems;
}
#pragma mark - 加载数据
-(void)loadData
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters [@"a"] = @"square";
    parameters [@"c"] = @"topic";
    [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary*  _Nullable responseObject) {
        
        NSArray *dictArray = responseObject[@"square_list"];
        self.footItems = [XCMeFootItem mj_objectArrayWithKeyValuesArray:dictArray];
        [self resloveData];
        
        // Rows = (count - 1) / cols + 1 计算行的万能公式
        NSInteger count = self.footItems.count;
        NSInteger rows = (count - 1) / cols + 1;
        //算出一共有多少行在*每个模型的高度就是collectionView的总高度
        self.collectionView.XC_height = rows *itemWH;
        // 设置tableView滚动范围:自己计算
        self.tableView.tableFooterView = self.collectionView;
        
        [self.collectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        XCLog(@"error = %@",error);
    }];
}
#pragma mark - 处理完请求数据后看一行还缺几个item就补几个
-(void)resloveData
{
    // 判断下缺几个
    // 3 % 4 = 3 cols - 3 = 1
    NSInteger count = self.footItems.count;
    NSInteger extend = count % cols ;
    if (extend) {
        extend = cols -extend;
        for (int i = 0 ; i< extend; i++) {
            XCMeFootItem *item = [[XCMeFootItem alloc]init];
            [self.footItems addObject:item];
        }
    }
}
#pragma  mark - setupCollectionView
-(void)setupcollectionView
{
    UICollectionViewFlowLayout *layout = ({
      UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(itemWH, itemWH);
        layout.minimumLineSpacing = margin;
        layout.minimumInteritemSpacing = margin;
        layout;
    });
    UICollectionView *collectionView = ({
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 300) collectionViewLayout:layout];
        collectionView.backgroundColor = self.tableView.backgroundColor;
        self.tableView.tableFooterView = collectionView;
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.scrollEnabled = NO;
        collectionView;
    });
    self.collectionView = collectionView;
    [collectionView registerNib:[UINib nibWithNibName:@"XCMeFootViewCell" bundle:nil] forCellWithReuseIdentifier:cellID];
}
#pragma mark - collectionViewDataSourceAndDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.footItems.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XCMeFootViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.item = self.footItems[indexPath.row];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    XCMeFootItem *item = self.footItems[indexPath.row];
    //判断如果url不包含http
    if (![item.url containsString:@"http"]) return;
     NSURL *url = [NSURL URLWithString:item.url];
    XCWebViewController *webVC = [[XCWebViewController  alloc]init];
    webVC.url = url;
    [self.navigationController pushViewController:webVC animated:YES];
}
#pragma mark - settingNav
-(void)settingNav
{
    UIBarButtonItem *settingItew = [UIBarButtonItem navItemWithImage:[UIImage imageNamed:@"mine-setting-icon"] hlghImage:[UIImage imageNamed:@"setting-icon-click"] target:self action:@selector(setting)];
    UIBarButtonItem *nightItem = [UIBarButtonItem navItemWithImage:[UIImage imageNamed:@"mine-moon-icon"] selImage:[UIImage imageNamed:@"mine-moon-icon-click"] target:self action:@selector(night:)];
    self.navigationItem.rightBarButtonItems = @[settingItew,nightItem];
    self.navigationItem.title = @"我的";
}
-(void)setting
{
    XCSettingViewController *settingVC = [[XCSettingViewController alloc]init];
    //隐藏push效果下的tabbar,必须在跳转之前设置
    settingVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:settingVC animated:YES];
}
-(void)night:(UIButton *)nigthButton
{
    //按钮状态取反,夜间模式
    nigthButton.selected = !nigthButton.selected;
    
}
@end
