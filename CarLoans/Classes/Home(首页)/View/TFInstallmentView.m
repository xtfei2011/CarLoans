//
//  TFInstallmentView.m
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/13.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFInstallmentView.h"

@interface TFInstallmentView ()
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *minLabel;
@property (weak, nonatomic) IBOutlet UILabel *maxLabel;
@end

@implementation TFInstallmentView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.autoresizingMask = UIViewAutoresizingNone;
    
    [self.slider setThumbImage:[UIImage imageNamed:@"knob"] forState:UIControlStateNormal];
    [self.slider setThumbImage:[UIImage imageNamed:@"knob"] forState:UIControlStateHighlighted];
}

- (IBAction)sliderMethod:(UISlider *)sender
{
    _moneyLabel.text = [NSString stringWithFormat:@"%.1f",sender.value];
    
}

- (void)setEvaluate:(TFEvaluate *)evaluate
{
    _evaluate = evaluate;
    
    self.moneyLabel.text = evaluate.loan_money;
    
    self.minLabel.text = [NSString stringWithFormat:@"最低%@万",evaluate.loan_min];
    self.maxLabel.text = [NSString stringWithFormat:@"最高%@万",evaluate.loan_max];
    self.slider.maximumValue = [evaluate.loan_max doubleValue];
    self.slider.minimumValue = [evaluate.loan_min doubleValue];
    self.slider.value = self.slider.maximumValue;
}

- (void)dealloc
{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
}
@end
