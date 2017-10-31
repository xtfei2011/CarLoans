//
//  TFHotCityListCell.h
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/13.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TFHotCityListCell : UICollectionViewCell
@property (nonatomic ,strong) UILabel *cityNameLabel;
@property (nonatomic ,strong) UIImageView *locationView;

- (void)isShowGPSStatus:(BOOL)isShow withLocationCityName:(NSString *)cityName;
@end
