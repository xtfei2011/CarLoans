//
//  TFEvaluateViewCell.h
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/11.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TFEvaluateViewCell;
@protocol TFEvaluateBtnDelegate <NSObject>

- (void)evaluateBtnClick:(UIButton *)sender;
@end

@interface TFEvaluateViewCell : UITableViewCell

@property (nonatomic ,weak) id<TFEvaluateBtnDelegate>delegate;
@end
