//
//  TFNavigationController.m
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/6.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFNavigationController.h"

@interface TFNavigationController ()

@end

@implementation TFNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackground"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[[UIImage alloc] init]];
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:18], NSFontAttributeName, nil]];
}

/**
 *  重写这个方法目的：能够拦截所有push进来的控制器
 *
 *  @param viewController 即将push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        
        /*** 自动显示和隐藏tabbar ***/
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.view.backgroundColor = TFGlobalBg;
        /*** 设置导航栏左边按钮 ***/
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationButtonReturn" highImage:nil target:self action:@selector(backButtonClick)];
    }
    [super pushViewController:viewController animated:animated];
}

- (void)backButtonClick
{
    [self.view endEditing:YES];
    [self popViewControllerAnimated:YES];
}
@end
