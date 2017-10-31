//
//  TFMineHeaderView.m
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/6.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFMineHeaderView.h"
#import "TFLoginViewController.h"
#import "TFNavigationController.h"
#import "TFTabBarController.h"
#import "TFLoginViewController.h"

@interface TFMineHeaderView ()
/*** 头像 ***/
@property (weak, nonatomic) IBOutlet UIImageView *headerView;
/*** 昵称 ***/
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *headerBtn;
@property (weak, nonatomic) IBOutlet UILabel *loginLabel;
@end

@implementation TFMineHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    TFAccount *account = [TFAccountTool account];

    if (account.access_token) {
        _headerBtn.userInteractionEnabled = NO;
        _loginLabel.hidden = YES;
    } else {
        _headerBtn.userInteractionEnabled = YES;
        _loginLabel.hidden = NO;
    }
    
    _nameLabel.text = account.realname;
}

- (IBAction)loginButtonClick:(UIButton *)sender
{
    TFTabBarController *tabBar = (TFTabBarController *)self.window.rootViewController;
    TFNavigationController *nav = tabBar.selectedViewController;
    
    TFLoginViewController *loginVC = [[TFLoginViewController alloc] init];
    TFNavigationController *loginNav = [[TFNavigationController alloc] initWithRootViewController:loginVC];
    [nav presentViewController:loginNav animated:YES completion:nil];
}

@end
