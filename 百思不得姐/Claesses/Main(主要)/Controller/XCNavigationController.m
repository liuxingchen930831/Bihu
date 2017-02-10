//
//  XCNavigationController.m
//  百思不得姐
//
//  Created by liuxingchen on 17/1/13.
//  Copyright © 2017年 liuxingchen. All rights reserved.
//

#import "XCNavigationController.h"

@interface XCNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation XCNavigationController

+(void)load
{
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    // 用富文本设置导航条标题颜色
    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
    titleAttr[NSForegroundColorAttributeName] = [UIColor blackColor];
    titleAttr[NSFontAttributeName] = [UIFont boldSystemFontOfSize:18];
    [navBar setTitleTextAttributes:titleAttr];
    
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    /**
     自定导航控制的滑动手势 
     handleNavigationTransition:方法是通过打印 
     interactivePopGestureRecognizer导航卡滑动手势得到
     */
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    [self.view addGestureRecognizer:pan];
    //监控手势什么时候出发，只有非根控制器才需要触发手势
    pan.delegate = self;
    //禁止之前的手势
    self.interactivePopGestureRecognizer.enabled =NO;
};//决定是否触发手势
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return self.childViewControllers.count > 1;
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    /**
     统一设置返回按钮，只要用了XCNavigationController的push方法就会自动生成一个自定义的返回按钮，比单个页面去设置节省代码量
     */
    if (self.childViewControllers.count >0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWithImage:[UIImage imageNamed:@"navigationButtonReturn"] hlghImage:[UIImage imageNamed:@"navigationButtonReturnClick"] target:self action:@selector(back) title:@"返回"];
    }
    
    //真正跳转的方法是父类做的
    [super pushViewController:viewController animated:animated];
    
}
-(void)back
{
    [self popViewControllerAnimated:YES];
}
@end
