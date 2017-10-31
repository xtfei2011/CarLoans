//
//  TFVehicleViewCell.m
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/27.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFVehicleViewCell.h"

@interface TFVehicleViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation TFVehicleViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSeriesName:(TFSeriesName *)seriesName
{
    _seriesName = seriesName;
    
    if (seriesName.xlname) {
        _titleLabel.text = seriesName.xlname;
    } else if (seriesName.big_ppname){
        _titleLabel.text = seriesName.big_ppname;
    } else {
        _titleLabel.text = seriesName.cxname;
    }
}
@end
