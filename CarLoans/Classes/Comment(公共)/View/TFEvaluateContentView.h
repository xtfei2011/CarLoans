//
//  TFEvaluateContentView.h
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/12.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TFEvaluateContentView;
@protocol TFEvaluateContentBtnDelegate <NSObject>
- (void)evaluateContentBtn:(UIButton *)sender;
@end

@interface TFEvaluateContentView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *seriesLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIButton *ascertainBtn;
@property (weak, nonatomic) IBOutlet UIView *toolView;
@property (weak, nonatomic) IBOutlet UIView *appraisementView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (nonatomic ,weak) id<TFEvaluateContentBtnDelegate>delegate;
@end
