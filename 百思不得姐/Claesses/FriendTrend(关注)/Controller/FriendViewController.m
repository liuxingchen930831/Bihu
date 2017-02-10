//
//  FriendViewController.m
//  百思不得姐
//
//  Created by liuxingchen on 17/1/11.
//  Copyright © 2017年 liuxingchen. All rights reserved.
//

#import "FriendViewController.h"
#import "XCLoginViewController.h"
@interface FriendViewController ()


@end

@implementation FriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settingNav];
    
}
- (IBAction)loginButton:(UIButton *)sender
{
    XCLoginViewController *loginVC = [[XCLoginViewController alloc]init];
    [self presentViewController:loginVC animated:YES completion:nil];
}

#pragma mark - settingNav
-(void)settingNav
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem navItemWithImage:[UIImage imageNamed:@"friendsRecommentIcon"] hlghImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] target:self action:@selector(action)];
    self.navigationItem.title = @"我的关注";
    
}
-(void)action
{
    XCLog(@"关注");
}
@end
