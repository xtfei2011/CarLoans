//
//  TFEvaluate.h
//  CarLoans
//
//  Created by 谢腾飞 on 2017/8/31.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TFEvaluateList;
@interface TFEvaluate : NSObject
@property (nonatomic ,strong) NSString *loan_max;
@property (nonatomic ,strong) NSString *loan_min;
@property (nonatomic ,strong) NSString *loan_money;
@property (nonatomic ,strong) NSArray *loan_list;
@end


@class TFEvaluateItem;
@interface TFEvaluateList : NSObject
@property (nonatomic ,strong) NSString *loan_type;
@property (nonatomic ,strong) NSString *repayment_type;
@property (nonatomic ,strong) NSArray *repay_list;
@end



@interface TFEvaluateItem : NSObject
@property (nonatomic ,strong) NSString *bx_total;
@property (nonatomic ,strong) NSString *em_total;
@property (nonatomic ,strong) NSString *loan_product_id;
@property (nonatomic ,strong) NSString *repay_plan;
@end
