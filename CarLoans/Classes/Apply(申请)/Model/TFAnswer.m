//
//  TFAnswer.m
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/14.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFAnswer.h"

@implementation TFAnswer

+ (instancetype)answerWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
@end
