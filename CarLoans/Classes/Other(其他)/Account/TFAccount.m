//
//  TFAccount.m
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/27.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFAccount.h"

@implementation TFAccount
/**
 *  当一个对象要归档进沙盒中时，就会调用这个方法
 *  目的：在这个方法中说明这个对象的哪些属性要存进沙盒
 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.access_token forKey:@"access_token"];
    [encoder encodeObject:self.phone forKey:@"phone"];
    [encoder encodeObject:self.realname forKey:@"realname"];
    [encoder encodeObject:self.idcard forKey:@"idcard"];
}

/**
 *  当从沙盒中解档一个对象时（从沙盒中加载一个对象时），就会调用这个方法
 *  目的：在这个方法中说明沙盒中的属性该怎么解析（需要取出哪些属性）
 */
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.access_token = [decoder decodeObjectForKey:@"access_token"];
        self.phone = [decoder decodeObjectForKey:@"phone"];
        self.realname = [decoder decodeObjectForKey:@"realname"];
        self.idcard = [decoder decodeObjectForKey:@"idcard"];
    }
    return self;
}
@end
