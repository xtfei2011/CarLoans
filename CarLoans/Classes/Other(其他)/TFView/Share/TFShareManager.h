//
//  TFShareManager.h
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/12.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TFShareManager : NSObject
/*** 分享视图背景 ***/
@property (nonatomic, strong) UIView *maskView;
/*** 分享视图 ***/
@property (nonatomic, strong) UIView *shareView;

/**
 *  设置分享的AppKey，Appdelegate中执行一次即可。
 */
+ (void)setupShareAppKey;

/**
 *  需要分享的内容
 *
 *  @param viewController      分享所在视图控制器
 *  @param shareContent        分享的内容
 *  @param shareIcon           分享的图片
 *  @param shareUrl            分享的urlString
 */
- (void)setupShareViewController:(UIViewController *)viewController shareTitle:(NSString *)shareTitle shareContent:(NSString *)shareContent shareIcon:(UIImage *)shareIcon shareUrl:(NSString *)shareUrl;
/**
 *  显示分享视图
 */
- (void)show;

/**
 *  隐藏分享视图
 */
- (void)hiddenShareView;

/**
 *  各个分享按钮点击事件
 *
 *  @param sender sender
 */
- (void)shareAction:(UIButton *)sender;
@end
