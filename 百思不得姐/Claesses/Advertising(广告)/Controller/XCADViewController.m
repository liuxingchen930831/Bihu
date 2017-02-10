//
//  XCADViewController.m
//  百思不得姐
//
//  Created by liuxingchen on 17/1/15.
//  Copyright © 2017年 liuxingchen. All rights reserved.
//

#import "XCADViewController.h"
#import "AFNetworking.h"
#import "XCTabbarController.h"
#import "XCADItem.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#define code2 @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"

@interface XCADViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *adView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *jumpAD;
@property(nonatomic,strong)XCADItem * item ;
@property(nonatomic,weak)NSTimer  * timer;
@end

@implementation XCADViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadAdvertisingData];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
}
-(void)timeChange
{
    //倒计时
    static int i = 3;
    
    if ( i == 0) {
        [self jumAdvertising:nil];
    }
     i--;
    [self.jumpAD setTitle:[NSString stringWithFormat:@"跳过(%d)",i] forState:UIControlStateNormal];
}

//- (UIImageView *)adView
//{
//    if (_adView == nil) {
//        UIImageView *imageView = [[UIImageView alloc] init];
//        imageView.userInteractionEnabled = YES;
//        [self.contentView addSubview:imageView];
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
//        
//        [imageView addGestureRecognizer:tap];
//        _adView = imageView;
//    }
//    return _adView;
//}

// 点击广告界面调用
- (void)tap
{
    NSURL *url = [NSURL URLWithString:_item.ori_curl];
    UIApplication *app = [UIApplication sharedApplication];
    if ([app canOpenURL:url]) {
        [app openURL:url];
    }
}
- (IBAction)jumAdvertising:(UIButton *)sender
{
    XCTabbarController *tabbarVC = [[XCTabbarController alloc]init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabbarVC;
    //关闭定时器
    [self.timer invalidate];
}
#pragma mark - 加载广告数据
-(void)loadAdvertisingData
{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
     manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSMutableDictionary *parmeters = [NSMutableDictionary dictionary];
    parmeters[@"code2"] = code2;
    
    [manager GET:@"http://mobads.baidu.com/cpro/ui/mads.php" parameters:parmeters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        
        //获取字典
        NSDictionary *adDict = [responseObject[@"ad"] lastObject];
        
//        [adDict writeToFile:@"/Users/liuxingchen/Desktop/ad.plist" atomically:YES];
        self.item = [XCADItem mj_objectWithKeyValues:adDict];
        [self settingAdView];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        XCLog(@"error = %@",error);
    }];
}
-(void)settingAdView
{
//    CGFloat adH = XCScreenW / self.item.w * self.item.h;
//    self.adView.frame = CGRectMake(0, 0, XCScreenW, adH);
    [self.adView sd_setImageWithURL:[NSURL URLWithString:self.item.w_picurl]];
    self.adView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.adView addGestureRecognizer:tap];
}
@end
