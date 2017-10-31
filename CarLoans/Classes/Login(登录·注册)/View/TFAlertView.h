//
//  TFAlertView.h
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/11.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TFPromptAlertBlock)(NSInteger index);

@interface TFAlertView : UIView
@property (nonatomic ,copy) TFPromptAlertBlock block;

/*** 提示文字 **/
+ (void)showPromptTitle:(NSString *)title message:(NSString *)message;

/*** 选择提示 **/
+ (void)showPromptMessage:(NSString *)message clickedBlock:(TFPromptAlertBlock)clickedBlock;
@end
