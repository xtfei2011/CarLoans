//
//  AppDelegate.m
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/6.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "AppDelegate.h"
#import "TFTabBarController.h"
#import "TFNavigationController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] init];
    self.window.frame = TFScreeFrame;
    self.window.backgroundColor = TFGlobalBg;
    self.window.rootViewController = [[TFTabBarController alloc] init];
    
    /*** 友盟分享 ***/
    [TFShareManager setupShareAppKey];
    [self.window makeKeyAndVisible];
    return YES;
}

/**
 *  分享回调方法
 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    
    return result;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}
@end
