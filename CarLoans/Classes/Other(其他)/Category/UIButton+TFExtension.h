//
//  UIButton+TFExtension.h
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/13.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (TFExtension)
+ (UIButton *)createButtonFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)color font:(UIFont *)font target:(id)target action:(SEL)action;
@end
