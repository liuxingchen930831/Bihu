//
//  NewViewController.m
//  百思不得姐
//
//  Created by liuxingchen on 17/1/11.
//  Copyright © 2017年 liuxingchen. All rights reserved.
//

#import "NewViewController.h"
#import "XCNewSubViewController.h"
@interface NewViewController ()

@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    [self settingNav];
}
#pragma mark - settingNav
-(void)settingNav
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem navItemWithImage:[UIImage imageNamed:@"MainTagSubIcon"] hlghImage:[UIImage imageNamed:@"MainTagSubIconClick"] target:self action:@selector(action)];
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
}
#pragma mark - 订阅
-(void)action
{
    XCNewSubViewController *subVC = [[XCNewSubViewController alloc]init];
    [self.navigationController pushViewController:subVC animated:YES];
}
@end
