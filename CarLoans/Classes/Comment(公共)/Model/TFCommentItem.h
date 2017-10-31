//
//  TFCommentItem.h
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/10.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TFCommentItem : NSObject
/*** 图标 ***/
@property (nonatomic ,strong) NSString *icon;
/*** 标题 ***/
@property (nonatomic ,strong) NSString *title;
/*** 副标题 ***/
@property (nonatomic ,strong) NSString *subTitle;
/*** 右边数字标记 ***/
@property (nonatomic ,strong) NSString *badge;
/*** 跳转界面 ***/
@property (nonatomic ,assign) Class destClass;

@property (nonatomic ,copy) void (^operation)();

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon;
+ (instancetype)itemWithTitle:(NSString *)title;
@end
