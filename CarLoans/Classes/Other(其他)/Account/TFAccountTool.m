//
//  TFAccountTool.m
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/27.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFAccountTool.h"

@implementation TFAccountTool
/**
 *  保存账户
 */
+(void)saveAccount:(TFAccount *)account
{
    [NSKeyedArchiver archiveRootObject:account toFile:TFCustomCacheFile];
}

/**
 *  返回账户 */
+ (TFAccount *)account
{
    // 加载模型
    TFAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:TFCustomCacheFile];
    return account;
}

/**
 *  销毁账户
 */
+ (void)logoutAccount
{
    NSFileManager *fileManeger=[NSFileManager defaultManager];
    if ([fileManeger isDeletableFileAtPath:TFCustomCacheFile]) {
        [fileManeger removeItemAtPath:TFCustomCacheFile error:nil];
        [TFProgressHUD showLoading:@"加载中..."];
        [TFProgressHUD dismiss];
    }
}
@end
