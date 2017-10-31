//
//  NSString+TFExtension.h
//  Treasure
//
//  Created by 谢腾飞 on 2017/6/18.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TFExtension)
/**
 *  手机号码验证
 */
- (BOOL)isValidateMobile;

/**
 *  返回字符串所占用的尺寸
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
@end
