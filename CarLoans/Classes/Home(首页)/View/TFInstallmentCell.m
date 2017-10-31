//
//  TFInstallmentCell.m
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/14.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFInstallmentCell.h"

@interface TFInstallmentCell ()
@property (weak, nonatomic) IBOutlet UILabel *nperLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *stagLabel;
@property (weak, nonatomic) IBOutlet UILabel *interestLabel;
@end

@implementation TFInstallmentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setItem:(TFEvaluateItem *)item
{
    _item = item;
    
    TFLog(@"---->%@",item.bx_total);
    NSArray *array = [item.repay_plan componentsSeparatedByString:@"/"];
    self.nperLabel.text = [NSString stringWithFormat:@"%@/",array[0]];
    self.totalLabel.text = array[1];
    self.stagLabel.text = item.em_total;
    self.interestLabel.text = item.bx_total;
}

@end
