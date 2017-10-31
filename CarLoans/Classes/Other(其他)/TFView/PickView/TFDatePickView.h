//
//  TFDatePickView.h
//  CarLoans
//
//  Created by 谢腾飞 on 2017/8/1.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TFPickViewBlock)(NSString *selectDate);

@interface TFDatePickView : UIView
/*** 日期回调 ***/
@property (nonatomic ,copy) TFPickViewBlock completeBlock;
/*** 出现 ***/
- (void)showPickView;
@end
