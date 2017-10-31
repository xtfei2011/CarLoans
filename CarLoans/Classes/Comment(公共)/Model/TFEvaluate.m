//
//  TFEvaluate.m
//  CarLoans
//
//  Created by 谢腾飞 on 2017/8/31.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFEvaluate.h"

@implementation TFEvaluate

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"loan_list":@"TFEvaluateList"
             };
}
@end


@implementation TFEvaluateList

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"repay_list":@"TFEvaluateItem"
             };
}
@end



@implementation TFEvaluateItem


@end
