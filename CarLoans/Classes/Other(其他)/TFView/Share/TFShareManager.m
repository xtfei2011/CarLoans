//
//  TFShareManager.m
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/12.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFShareManager.h"
#import "TFShareManager+TFShareView.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"

@interface TFShareManager ()

@property (nonatomic, strong) UIViewController *shareVC;
/*** 分享内容 ***/
@property (nonatomic, strong) NSString *shareTitle;
/*** 分享内容 ***/
@property (nonatomic, strong) NSString *shareContent;
/*** 分享内容 ***/
@property (nonatomic, strong) UIImage *shareIcon;
/*** 分享内容 ***/
@property (nonatomic, strong) NSString *shareUrl;
@end

@implementation TFShareManager

+ (void)setupShareAppKey
{
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"5965753865b6d6238d000dc3"];
    /*** 微信 ***/
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WXAPPID appSecret:WXSecret redirectURL:nil];
    /*** QQ ***/
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQAPPID appSecret:QQAPPKEY redirectURL:nil];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self creatShareView];
    }
    return self;
}

- (void)setupShareViewController:(UIViewController *)viewController shareTitle:(NSString *)shareTitle shareContent:(NSString *)shareContent shareIcon:(UIImage *)shareIcon shareUrl:(NSString *)shareUrl
{
    self.shareVC = viewController;
    self.shareTitle = shareTitle;
    self.shareContent = shareContent;
    self.shareIcon = shareIcon;
    self.shareUrl = shareUrl;
}

- (void)show
{
    self.maskView.hidden = NO;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        self.shareView.frame = CGRectMake(0, TFMainScreen_Height - 200, TFMainScreen_Width, 200);
    } completion:^(BOOL finished) { }];
}

- (void)hiddenShareView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
        self.shareView.frame = CGRectMake(0, TFMainScreen_Height, TFMainScreen_Width, 200);
    } completion:^(BOOL finished) {
        self.maskView.hidden = YES;
    }];
}

- (void)shareAction:(UIButton *)sender
{
    [self hiddenShareView];
    __weak typeof(self) weakSelf = self;
    
    switch (sender.tag) {
        case 0:
            [weakSelf shareWebPageToPlatformType:UMSocialPlatformType_WechatSession];
            
            break;
        case 1:
            [weakSelf shareWebPageToPlatformType:UMSocialPlatformType_WechatTimeLine];
            
            break;
        case 2:
            [weakSelf shareWebPageToPlatformType:UMSocialPlatformType_QQ];
            
            break;
        case 3:
            [weakSelf shareWebPageToPlatformType:UMSocialPlatformType_Qzone];
            
            break;
        default:
            break;
    }
}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    /*** 创建分享消息对象 ***/
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:self.shareTitle descr:self.shareContent thumImage:self.shareIcon];
    
    /*** 设置网页地址 ***/
    shareObject.webpageUrl = self.shareUrl;
    
    /*** 分享消息对象设置分享内容对象 ***/
    messageObject.shareObject = shareObject;
    
    /*** 调用分享接口 ***/
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:_shareVC completion:^(id data, NSError *error) {
        
        if (error) {
            TFLog(@"--->%@",error);
            [TFProgressHUD showFailure:@"分享失败！"];
            
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                
                [TFProgressHUD showSuccess:@"分享成功！"];
            }
        }
    }];
}
@end
