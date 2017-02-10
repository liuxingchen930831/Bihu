//
//  XCLoginViewController.m
//  百思不得姐
//
//  Created by liuxingchen on 17/1/17.
//  Copyright © 2017年 liuxingchen. All rights reserved.
//

#import "XCLoginViewController.h"
#import "XCLoginRegisterView.h"
#import "XCRegisteredViewController.h"
#import "XCFasLoginView.h"
@interface XCLoginViewController ()
@property (weak, nonatomic) IBOutlet UIView *loginAndRegisterView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leading;
@property (weak, nonatomic) IBOutlet UIView *bottomView;



@end

@implementation XCLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    XCLoginRegisterView *loginView = [XCLoginRegisterView loadloginView];
    [self.loginAndRegisterView addSubview:loginView];
    XCFasLoginView *fastloginView = [XCFasLoginView loadFastLoginView];
    [self.bottomView addSubview:fastloginView];
}
//设置选中按钮的title
- (IBAction)registeredState:(UIButton *)sender
{
    sender.selected = !sender.selected;
    XCRegisteredViewController *registerVC = [[XCRegisteredViewController alloc]init];
    [self presentViewController:registerVC animated:YES completion:nil];
}
- (IBAction)dimiss:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
