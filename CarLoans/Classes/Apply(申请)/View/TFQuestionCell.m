//
//  TFQuestionCell.m
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/14.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFQuestionCell.h"

@interface TFQuestionCell ()
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@end

@implementation TFQuestionCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

- (void)setAnswer:(TFAnswer *)answer
{
    _answer = answer;
    
    _contentLabel.text = answer.answer;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.contentLabel.xtf_width = TFMainScreen_Width - 40;
}
@end
