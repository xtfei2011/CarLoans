//
//  TFEvaluateViewCell.m
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/11.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFEvaluateViewCell.h"

@implementation TFEvaluateViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

/*** 按钮代理 ***/
- (IBAction)evaluateButtonClick:(UIButton *)sender
{
    if ([_delegate respondsToSelector:@selector(evaluateBtnClick:)]){
        [_delegate evaluateBtnClick:sender];
    }
}
@end
