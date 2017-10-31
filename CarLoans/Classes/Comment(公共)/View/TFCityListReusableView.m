//
//  TFCityListReusableView.m
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/13.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFCityListReusableView.h"

@implementation TFCityListReusableView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.sectionTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, self.xtf_width, self.xtf_height)];
        self.sectionTitleLabel.font = TFSetPromptTitleFont;
        [self addSubview:self.sectionTitleLabel];
    }
    return self;
}

@end
