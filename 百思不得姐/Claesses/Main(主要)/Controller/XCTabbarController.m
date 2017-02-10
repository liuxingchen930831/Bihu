//
//  XCTabbarController.m
//  百思不得姐
//
//  Created by liuxingchen on 17/1/10.
//  Copyright © 2017年 liuxingchen. All rights reserved.
//

#import "XCTabbarController.h"
#import "EssenceViewController.h"
#import "FriendViewController.h"
#import "MeViewController.h"
#import "NewViewController.h"
#import "PublishViewController.h"
#import "XCNavigationController.h"
#import "XCTabbar.h"
@interface XCTabbarController ()

@end

@implementation XCTabbarController
+(void)load
{
    //获取哪个类中的UITabBarItem
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    //用富文本设置字体选中颜色
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName]  = [UIColor blackColor];
    [item setTitleTextAttributes:attrs forState:UIControlStateSelected];
    
    NSMutableDictionary *attrsFont = [NSMutableDictionary dictionary];
    attrsFont[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    [item setTitleTextAttributes:attrsFont forState:UIControlStateNormal];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupAllViewController];
    [self setupTabBar];
}
#pragma mark - 自定义tabBar
- (void)setupTabBar
{
    XCTabbar *tabBar = [[XCTabbar alloc] init];
    [self setValue:tabBar forKey:@"tabBar"];
}
-(void)setupAllViewController
{
    XCNavigationController *essenceNav = ({
        EssenceViewController *essenceVC =[[EssenceViewController alloc]init];
        XCNavigationController *essenceNav = [[XCNavigationController alloc]initWithRootViewController:essenceVC];
        [self setupNav:essenceNav TitleButton:@"精华" image:@"tabBar_essence_icon" selectImage:@"tabBar_essence_click_icon"];
        essenceNav;
    });
    [self addChildViewController:essenceNav];
    
    XCNavigationController *newNav =({
        NewViewController *newVC =[[NewViewController alloc]init];
        XCNavigationController *newNav = [[XCNavigationController alloc]initWithRootViewController:newVC];
        [self setupNav:newNav TitleButton:@"新帖" image:@"tabBar_new_icon" selectImage:@"tabBar_new_click_icon"];
        newNav;
    });
    [self addChildViewController:newNav];
    
//    PublishViewController *publishVC = ({
//        PublishViewController *publishVC = [[PublishViewController alloc]init];
//        publishVC.tabBarItem.image = [UIImage imageOriginalWithName:@"tabBar_publish_icon"];
//        publishVC.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_publish_click_icon"];
//        publishVC.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
//        publishVC;
//    });
//    [self addChildViewController:publishVC];
    
    
    XCNavigationController *friendNav = ({
        FriendViewController *friendVC =[[FriendViewController alloc]init];
        XCNavigationController *friendNav = [[XCNavigationController alloc]initWithRootViewController:friendVC];
        [self setupNav:friendNav TitleButton:@"关注" image:@"tabBar_friendTrends_icon" selectImage:@"tabBar_friendTrends_click_icon"];
        friendNav;
    });
    [self addChildViewController:friendNav];
    
    XCNavigationController *meNav = ({
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"MeViewController" bundle:nil];
        MeViewController *meVC = [storyBoard instantiateInitialViewController];
        XCNavigationController *meNav = [[XCNavigationController alloc]initWithRootViewController:meVC];
        [self setupNav:meNav TitleButton:@"我的" image:@"tabBar_me_icon" selectImage:@"tabBar_me_click_icon"];
        meNav;
    });
    [self addChildViewController:meNav];
    
}
-(void)setupNav:(XCNavigationController *)nav TitleButton:(NSString *)tabbartitle image:(NSString *)imageName selectImage:(NSString *)selectImageName
{
    nav.tabBarItem.title = tabbartitle;
    nav.tabBarItem.image = [UIImage imageNamed:imageName];
    nav.tabBarItem.selectedImage = [UIImage imageOriginalWithName:selectImageName];
}
@end

