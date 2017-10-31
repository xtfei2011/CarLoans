//
//  UIButton+TFExtension.m
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/13.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "UIButton+TFExtension.h"

@implementation UIButton (TFExtension)
+ (UIButton *)createButtonFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)color font:(UIFont *)font target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = TFColor(251, 99, 102);
    btn.layer.cornerRadius = 3.0f;
    btn.frame = frame;
    btn.titleLabel.font = font;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
@end
