//
//  TFShareManager+TFShareView.m
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/12.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFShareManager+TFShareView.h"
#import "TFShareButton.h"

@implementation TFShareManager (TFShareView)

- (void)creatShareView
{
    self.maskView = [[UIView alloc] initWithFrame:TFScreeFrame];
    [TFkeyWindowView addSubview:self.maskView];
    [TFkeyWindowView bringSubviewToFront:self.maskView];
    
    UIImageView *topView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, TFMainScreen_Width, TFMainScreen_Height - 200)];
    topView.userInteractionEnabled = YES;
    [self.maskView addSubview:topView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenShareView)];
    [topView addGestureRecognizer:tap];
    
    self.shareView = [[UIView alloc] initWithFrame:CGRectMake(0, TFMainScreen_Height, TFMainScreen_Width, 200)];
    self.shareView.backgroundColor = [UIColor whiteColor];
    [self.maskView addSubview:self.shareView];
    
    UILabel *shareLeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, TFMainScreen_Width, 15)];
    shareLeLabel.text = NSLocalizedString(@"分享到", nil);
    shareLeLabel.textColor = [UIColor lightGrayColor];
    shareLeLabel.textAlignment = NSTextAlignmentCenter;
    [self.shareView addSubview:shareLeLabel];
    
    CGFloat itemWidth = (TFMainScreen_Width - 80)/4;
    UIView *shareBaseView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(shareLeLabel.frame) + 10, TFMainScreen_Width, itemWidth + 15)];
    [self.shareView addSubview:shareBaseView];
    
    for (int i = 0; i < shareNameArray.count; i++) {
        
        TFShareButton *shareBtn = [[TFShareButton alloc] initWithFrame:CGRectMake(10 + i%4*(itemWidth + 20), 10 + i/4 * (itemWidth + 10), itemWidth, itemWidth)];
        [shareBtn setImage:[UIImage imageNamed:shareImageArray[i]] forState:UIControlStateNormal];
        [shareBtn setTitle:shareNameArray[i] forState:UIControlStateNormal];
        shareBtn.tag = i;
        [shareBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
        [shareBaseView addSubview:shareBtn];
    }
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cancelBtn.frame = CGRectMake(10, CGRectGetMaxY(shareBaseView.frame) + 20, self.shareView.xtf_width - 20, 40);
    cancelBtn.layer.masksToBounds = YES;
    cancelBtn.layer.cornerRadius = 6.0f;
    cancelBtn.layer.borderColor = [[UIColor grayColor] CGColor];
    cancelBtn.layer.borderWidth = 0.8f;
    cancelBtn.tintColor = [UIColor grayColor];
    [cancelBtn setTitle:NSLocalizedString(@"取消", nil) forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(hiddenShareView) forControlEvents:UIControlEventTouchUpInside];
    [self.shareView addSubview:cancelBtn];
    self.maskView.hidden = YES;
}
@end
