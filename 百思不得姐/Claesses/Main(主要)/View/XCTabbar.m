//
//  XCTabbar.m
//  百思不得姐
//
//  Created by liuxingchen on 17/1/12.
//  Copyright © 2017年 liuxingchen. All rights reserved.
//

#import "XCTabbar.h"
@interface XCTabbar ()
@property(nonatomic,weak)UIButton  * plusButton ;
/** 上次点击的tabbar状态*/
@property(nonatomic,weak)UIControl *previousClickedTabBarButton ;
@end
@implementation XCTabbar

-(UIButton *)plusButton
{
    if (_plusButton ==nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [button sizeToFit];
        [self addSubview:button];
        _plusButton = button;
    }
   return  _plusButton;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    //索引
    NSInteger count = self.items.count;
    /**
     自定义tabbar第三个按钮的位置
     */
    CGFloat plusWidth = self.XC_width / (count +1);
    CGFloat plusHeight = self.XC_height;
    CGFloat x = 0;
    int i = 0 ;
    for (UIControl *tabBarButton in self.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            // 设置previousClickedTabBarButton默认值为最前面的按钮
            if (i == 0 && self.previousClickedTabBarButton == nil) {
                self.previousClickedTabBarButton = tabBarButton;
            }
            if (i ==2) {
                i += 1;
            }
            x = i * plusWidth;
            tabBarButton.frame = CGRectMake(x, 0, plusWidth, plusHeight);
            i++;
            
            [tabBarButton addTarget:self action:@selector(tabbarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        self.plusButton.center = CGPointMake(self.XC_width*0.5, self.XC_height *0.5);
    }
}
/**
 *  tabBarButton的点击
 */
-(void)tabbarButtonClick:(UIControl *)tabBarButton
{
    if (self.previousClickedTabBarButton ==tabBarButton) {
        [[NSNotificationCenter defaultCenter]postNotificationName:XCTabbarButtonDidRepeatClickNotification object:nil userInfo:nil];
    }
    self.previousClickedTabBarButton = tabBarButton;
}
@end
