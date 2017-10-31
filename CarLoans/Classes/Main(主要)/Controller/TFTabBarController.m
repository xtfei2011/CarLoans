//
//  TFTabBarController.m
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/6.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFTabBarController.h"
#import "TFNavigationController.h"
#import "TFHomeViewController.h"
#import "TFApplyViewController.h"
#import "TFMoreViewController.h"
#import "TFMineViewController.h"

@interface TFTabBarController ()

@end

@implementation TFTabBarController

+ (void)initialize
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = TFColor(44, 159, 252);
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /**** 添加子控制器 ****/
    [self setupChildViewControllers];
}

/**** 添加子控制器 ****/
- (void)setupChildViewControllers
{
    TFHomeViewController *home = [[TFHomeViewController alloc] init];
    [self addChildVc:home title:@"首页" image:@"home_gray" selectedImage:@"home_blue"];
    
    TFApplyViewController *apply = [[TFApplyViewController alloc] init];
    [self addChildVc:apply title:@"申请" image:@"apply_gray" selectedImage:@"apply_blue"];
    
    TFMineViewController *mine = [[TFMineViewController alloc] init];
    [self addChildVc:mine title:@"我的" image:@"user_gray" selectedImage:@"user_blue"];
    
    TFMoreViewController *more = [[TFMoreViewController alloc] init];
    [self addChildVc:more title:@"更多" image:@"more_gray" selectedImage:@"more_blue"];
}

/**
 *  添加一个子控制器
 *
 *  @param childVc       子控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中的图片
 */
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.view.backgroundColor = TFGlobalBg;
    
    TFNavigationController *nav = [[TFNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}
@end
