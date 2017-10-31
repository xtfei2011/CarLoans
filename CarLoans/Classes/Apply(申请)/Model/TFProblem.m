//
//  TFProblem.m
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/14.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFProblem.h"
#import "TFAnswer.h"

@implementation TFProblem

+ (instancetype)problemGroupWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
        
        NSMutableArray *tempArray = [NSMutableArray array];
        for (NSDictionary *dict in _infor) {
            
            TFAnswer *answer = [TFAnswer answerWithDict:dict];
            [tempArray addObject:answer];
        }
        _infor = tempArray;
    }
    return self;
}
@end
