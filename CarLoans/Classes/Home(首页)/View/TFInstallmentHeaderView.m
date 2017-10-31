//
//  TFInstallmentHeaderView.m
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/14.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFInstallmentHeaderView.h"

@interface TFInstallmentHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation TFInstallmentHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setList:(TFEvaluateList *)list
{
    _list = list;
    
    TFLog(@"--->%@",list.loan_type);
    self.typeLabel.text = list.loan_type;
    self.titleLabel.text = list.repayment_type;
}

@end
