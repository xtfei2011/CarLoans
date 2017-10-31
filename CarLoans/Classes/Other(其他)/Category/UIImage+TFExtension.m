//
//  UIImage+TFExtension.m
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/10.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "UIImage+TFExtension.h"

@implementation UIImage (TFExtension)

+ (UIImage *)imageWithName:(NSString *)imageName
{
    UIImage *image = nil;
    if (image == nil) {
        image = [UIImage imageNamed:imageName];
    }
    return image;
}

+ (UIImage *)initImageWithName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    CGFloat W = image.size.width * 0.5;
    CGFloat H = image.size.height * 0.5;
    
    UIImage *newImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(H, W, H, W) resizingMode:UIImageResizingModeStretch];
    
    return newImage;
}

- (UIImage *)scaleImageWithSize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
