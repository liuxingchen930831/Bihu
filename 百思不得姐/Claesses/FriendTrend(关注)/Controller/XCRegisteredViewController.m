//
//  XCRegisteredViewController.m
//  百思不得姐
//
//  Created by liuxingchen on 17/1/17.
//  Copyright © 2017年 liuxingchen. All rights reserved.
//

#import "XCRegisteredViewController.h"
#import "XCLoginRegisterView.h"
@interface XCRegisteredViewController ()
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation XCRegisteredViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    XCLoginRegisterView *registerView =[XCLoginRegisterView loadRegisterView];
    [self.contentView addSubview:registerView];
}
- (IBAction)dismiss:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
