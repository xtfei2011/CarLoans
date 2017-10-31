//
//  TFQuestionHeaderView.m
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/14.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFQuestionHeaderView.h"
#import "TFProblem.h"

@interface TFQuestionHeaderView ()
@property (nonatomic ,strong) UIButton *clickBtn;
@property (nonatomic ,strong) UILabel *titleLabel;
@end

@implementation TFQuestionHeaderView

+ (instancetype)headViewWithTableView:(UITableView *)tableView
{
    static NSString *headerID = @"header";
    TFQuestionHeaderView *questionHeaderView;
    
    if (questionHeaderView == nil) {
        
        questionHeaderView = [[TFQuestionHeaderView alloc] initWithReuseIdentifier:headerID];
    }
    return questionHeaderView;
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        _clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _clickBtn.backgroundColor = [UIColor whiteColor];
        [_clickBtn setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
        [_clickBtn setTitleColor:TFrayColor(80) forState:UIControlStateNormal];
        _clickBtn.titleLabel.font = TFMoreTitleFont;
        _clickBtn.imageView.contentMode = UIViewContentModeCenter;
        _clickBtn.imageView.clipsToBounds = NO;
        _clickBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _clickBtn.contentEdgeInsets = UIEdgeInsetsMake(30, TFMainScreen_Width - 30, 30, 0);
        _clickBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -TFMainScreen_Width + 30, 0, 50);
        [_clickBtn addTarget:self action:@selector(headBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_clickBtn];
    }
    return self;
}

- (void)headBtnClick
{
    _problem.opened = !_problem.isOpened;
    if ([_delegate respondsToSelector:@selector(questionHeaderClick)]) {
        [_delegate questionHeaderClick];
    }
}

- (void)setProblem:(TFProblem *)problem
{
    _problem = problem;
    
    [_clickBtn setTitle:problem.title forState:UIControlStateNormal];
}

- (void)didMoveToSuperview
{
    _clickBtn.imageView.transform = _problem.isOpened ? CGAffineTransformMakeRotation(M_PI_2*2) : CGAffineTransformMakeRotation(0);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _clickBtn.frame = self.bounds;
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, self.xtf_height - 0.5, self.xtf_width, 1)];
    line.backgroundColor = TFrayColor(239);
    [self addSubview:line];
}

@end
