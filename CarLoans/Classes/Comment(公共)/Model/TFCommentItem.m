//
//  TFCommentItem.m
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/10.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFCommentItem.h"

@implementation TFCommentItem
+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon
{
    TFCommentItem *item = [[self alloc] init];
    item.title = title;
    item.icon = icon;
    
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title
{
    return [self itemWithTitle:title icon:nil];
}
@end
