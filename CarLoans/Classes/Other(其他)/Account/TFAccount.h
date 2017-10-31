//
//  TFAccount.h
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/27.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TFAccount : NSObject<NSCoding>
/*** access_token ***/
@property (nonatomic ,strong) NSString *access_token;
/*** 手机号 ***/
@property (nonatomic ,strong) NSString *phone;
/*** 姓名 ***/
@property (nonatomic ,strong) NSString *realname;
/*** 身份证号 ***/
@property (nonatomic ,strong) NSString *idcard;
@end
