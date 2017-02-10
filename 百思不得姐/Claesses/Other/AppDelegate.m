//
//  AppDelegate.m
//  百思不得姐
//
//  Created by liuxingchen on 17/1/10.
//  Copyright © 2017年 liuxingchen. All rights reserved.
//

#import "AppDelegate.h"
#import "XCADViewController.h"
#import "XCTabbarController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //判断点击状态栏，状态栏和UIWindow是两个东西没有任何关系
    if ([[touches anyObject]locationInView:nil].y <=20 ) {
        XCLog(@"点击状态栏");
    }
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    XCADViewController *adVC =[[XCADViewController alloc]init];
//    self.window.rootViewController = adVC;
    XCTabbarController *tabbarVC = [[XCTabbarController alloc]init];
    self.window.rootViewController = tabbarVC;
    [self.window makeKeyAndVisible];
    //开始监控网络状况
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
