//
//  TFProblem.h
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/14.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TFProblem : NSObject

@property (nonatomic ,strong) NSArray *infor;
@property (nonatomic ,copy) NSString *title;
@property (nonatomic ,assign ,getter = isOpened) BOOL opened;

+ (instancetype)problemGroupWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
