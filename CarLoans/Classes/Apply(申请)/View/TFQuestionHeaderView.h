//
//  TFQuestionHeaderView.h
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/14.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TFProblem;
@protocol TFQuestionHeaderDelegate <NSObject>
@optional
- (void)questionHeaderClick;
@end

@interface TFQuestionHeaderView : UITableViewHeaderFooterView

@property (nonatomic ,strong) TFProblem *problem;
@property (nonatomic ,weak) id<TFQuestionHeaderDelegate>delegate;

+ (instancetype)headViewWithTableView:(UITableView *)tableView;
@end
