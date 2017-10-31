//
//  TFApplyHeaderView.m
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/11.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFApplyHeaderView.h"

@interface TFApplyHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *headerView;
@end

@implementation TFApplyHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    [self endEditing:YES];
}

- (void)layoutSubviews
{
    _headerView.xtf_height = _headerView.xtf_width / 2.63;
}
@end
