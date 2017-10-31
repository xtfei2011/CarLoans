//
//  TFSeriesName.m
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/28.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFSeriesName.h"

@implementation TFSeriesName
+ (void)load
{
    [TFSeriesName mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"series" : @"id"
                 };    }];
}
@end

