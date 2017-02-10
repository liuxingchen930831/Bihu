//
//  EssenceViewController.m
//  百思不得姐
//
//  Created by liuxingchen on 17/1/11.
//  Copyright © 2017年 liuxingchen. All rights reserved.
//

#import "EssenceViewController.h"
#import "XCTitleButton.h"
#import "XCAllViewController.h"
#import "XCVideoViewController.h"
#import "XCVoiceViewController.h"
#import "XCPictureViewController.h"
#import "XCWordViewController.h"
@interface EssenceViewController ()<UIScrollViewDelegate>
/** titlView*/
@property(nonatomic,weak)UIView  * titleView ;
/** 上次点击的标题按钮*/
@property(nonatomic,weak)XCTitleButton  * previousClickedTitleButton ;
/** 标题下划线*/
@property(nonatomic,weak)UIView  * titleUnderLine ;
/** 存放子View的scrollView*/
@property(nonatomic,strong)UIScrollView * scrollView ;
@end

@implementation EssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupAddChildViewController];
    [self setupScrollView];
    [self setupTitleView];
    [self settingNav];
    [self addChildVcViewIntoScrollView:0];
   
}

/**
 添加子控制器
 */
- (void)setupAddChildViewController
{
    [self addChildViewController:[[XCAllViewController alloc]init]];
    [self addChildViewController:[[XCVideoViewController alloc]init]];
    [self addChildViewController:[[XCVoiceViewController alloc]init]];
    [self addChildViewController:[[XCPictureViewController alloc]init]];
    [self addChildViewController:[[XCWordViewController alloc]init]];
}
-(void)setupScrollView
{
    // 不允许自动修改UIScrollView的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = ({
      UIScrollView *scrollView = [[UIScrollView alloc]init];
        scrollView.frame = self.view.bounds;
        scrollView.backgroundColor = [UIColor orangeColor];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        scrollView;
    });
    NSInteger count = self.childViewControllers.count;
    scrollView.contentSize = CGSizeMake(count * scrollView.XC_width, 0);
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
}

/**
 添加顶部的titleView
 */
-(void)setupTitleView
{
    UIView *titleView = ({
        UIView *titleView = [[UIView alloc]init];
        //设置背景颜色透明0.5
        titleView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
        titleView.frame = CGRectMake(0, NavMaxY, self.view.XC_width, titleViewH);
        titleView;
    });
    [self.view addSubview:titleView];
    _titleView = titleView;
    
    [self setupTitleViewButton];
    [self setupTitleUnderLine];
}
/**
 添加顶部titleView中的button
 */
-(void)setupTitleViewButton
{
    NSArray *buttonTitles = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    NSInteger count = buttonTitles.count;
    
    CGFloat titleButtonW = self.titleView.XC_width / count;
    CGFloat titleButtonH = self.titleView.XC_height;
    
    for (NSInteger i = 0 ; i <count; i++) {
        XCTitleButton *titleButton = ({
           XCTitleButton *titleButton = [[XCTitleButton alloc]init];
            titleButton.tag = i;
            [titleButton setTitle:buttonTitles[i] forState:UIControlStateNormal];
            
            titleButton.frame = CGRectMake(i * titleButtonW, 0, titleButtonW, titleButtonH);
            [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            titleButton;
        });
    
        [self.titleView addSubview:titleButton];
    }
}
/**
 添加button下划线
 */
-(void)setupTitleUnderLine
{
    XCTitleButton *firstTitleButton = self.titleView.subviews.firstObject;
    
    //下划线
    UIView *titleUnderLine = ({
        UIView *titleUnderLine =[[UIView alloc]init];
        titleUnderLine.XC_height = 2;
        titleUnderLine.XC_y = self.titleView.XC_height - titleUnderLine.XC_height;
        //下划线的颜色和button的文字颜色保持一致
        titleUnderLine.backgroundColor = [firstTitleButton titleColorForState:UIControlStateSelected];
        // 切换按钮状态
        firstTitleButton.selected = YES;
        self.previousClickedTitleButton = firstTitleButton;
        [firstTitleButton.titleLabel sizeToFit]; // 让label根据文字内容计算尺寸
        //设置下划线的宽度== button的label + 10
        titleUnderLine.XC_width = firstTitleButton.titleLabel.XC_width + XCMargin;
        titleUnderLine.XC_CenterX = firstTitleButton.XC_CenterX ;
        titleUnderLine;
    });
    self.titleUnderLine = titleUnderLine;
    [self.titleView addSubview:titleUnderLine];
}
/**
 点击标题按钮
 */
-(void)titleButtonClick:(XCTitleButton *)titleButton
{
    // 重复点击了标题按钮
    if (self.previousClickedTitleButton == titleButton) {
        [[NSNotificationCenter defaultCenter]postNotificationName:XCtitleButtonDidRepeatClickNotification object:self];
    }
    [self dealTitleButtonClick:titleButton];
}
/**
 *  处理标题按钮点击
 */
- (void)dealTitleButtonClick:(XCTitleButton *)titleButton
{
    //在这个里面需要重写sethighlighted不然长按按钮的时候回变成Normal状态
    self.previousClickedTitleButton.selected = NO;
    titleButton.selected = YES;
    self.previousClickedTitleButton = titleButton;
    
    NSInteger index =titleButton.tag;
    //做下划线滚动动画
    [UIView animateWithDuration:0.25 animations:^{
        //处理下划线
        self.titleUnderLine.XC_width = titleButton.titleLabel.XC_width + XCMargin;
        self.titleUnderLine.XC_CenterX = titleButton.XC_CenterX;
        
        CGFloat offsetX = index * self.scrollView.XC_width;
        //每次点击标题按钮
        self.scrollView.contentOffset = CGPointMake(offsetX, self.scrollView.contentOffset.y);
    } completion:^(BOOL finished) {
        [self addChildVcViewIntoScrollView:index];
    }];
    
    for (NSInteger i = 0; i <self.childViewControllers.count; i++) {
        UIViewController *childVC = self.childViewControllers[i];
        //如果view还没有创建，就不用处理
        if (!childVC.isViewLoaded) continue;
        UIScrollView *scrollView = (UIScrollView *)childVC.view;
        if (![scrollView isKindOfClass:[UIScrollView class]]) continue;
        
        if (i == index) {
            scrollView.scrollsToTop = YES;
        }else{
            scrollView.scrollsToTop = NO;
        }
    }
}
/**
 添加子控制器的View到ScrollView上
 */
- (void)addChildVcViewIntoScrollView:(NSInteger)index
{
    UIViewController *childVC = self.childViewControllers[index];
    //如果view已经被加载过，直接返回
    if (childVC.isViewLoaded) return;
    UIView *childView = childVC.view;
    childView.frame = CGRectMake(index * self.scrollView.XC_width, 0, self.scrollView.XC_width, self.scrollView.XC_height);
    [self.scrollView addSubview:childView];
}

#pragma mark - ScrollViewDelegate

/**
 scrollView结束滚动时调用
 */
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.XC_width;
    //点击对应的标题按钮
    XCTitleButton *titleButton = self.titleView.subviews[index];
    [self dealTitleButtonClick:titleButton];
}


-(void)settingNav
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem navItemWithImage:[UIImage imageNamed:@"nav_item_game_icon"] hlghImage:[UIImage imageNamed:@"nav_item_game_click_icon"] target:self action:@selector(game)];
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem navItemWithImage:[UIImage imageNamed:@"navigationButtonRandom"] hlghImage:[UIImage imageNamed:@"navigationButtonRandomClick"] target:nil action:nil];
}
-(void)game
{
    XCLog(@"game");
}
@end
