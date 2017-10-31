//
//  TFHotCityListCell.m
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/13.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFHotCityListCell.h"

@implementation TFHotCityListCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.layer.borderColor = TFGlobalBg.CGColor;
        self.layer.borderWidth = 1;
        self.backgroundColor = [UIColor whiteColor];
        
        [self setupContentView];
    }
    return self;
}

- (void)setupContentView
{
    _locationView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 20, 20)];
    NSMutableArray *imageArr = [NSMutableArray array];
    for (int i = 1; i<= 3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"city_locating_frame%d",i]];
        [imageArr addObject:image];
    }
    
    _locationView.animationImages = imageArr;
    _locationView.animationDuration = 1;
    _locationView.animationRepeatCount = INT_MAX;
    
    _cityNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.xtf_width, self.xtf_height)];
    _cityNameLabel.font = TFMoreTitleFont;
    _cityNameLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.contentView addSubview:_locationView];
    [self.contentView addSubview:_cityNameLabel];
}

- (void)isShowGPSStatus:(BOOL)isShow withLocationCityName:(NSString *)cityName
{
    [_locationView stopAnimating];
    
    CGRectSetX(_cityNameLabel.frame, _locationView.xtf_width + 10);
    self.cityNameLabel.textAlignment = NSTextAlignmentLeft;
    
    if (isShow) {
//        CGRectSetW(self.cityNameLabel.xtf_width, TFMainScreen_Width);
        self.layer.borderWidth = 0;
        _locationView.image = [UIImage imageNamed:@"city_locate_failed"];
        _cityNameLabel.textColor = [UIColor lightGrayColor];
        _cityNameLabel.text = @"无法获取您的定位,请手动选择您所在的城市";
        
    } else {
        
//        CGRectSetW(_cityNameLabel.frame, _locationView.xtf_width + 10);
        self.layer.borderWidth = 1;
        _locationView.image = [UIImage imageNamed:@"city_locate_success"];
        _cityNameLabel.text = cityName;
    }
}
@end
