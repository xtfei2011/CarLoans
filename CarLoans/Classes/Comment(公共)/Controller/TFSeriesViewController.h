//
//  TFSeriesViewController.h
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/27.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFSeriesName.h"

typedef void (^SelectSeries)(NSString *seriesName ,NSString *seriesPrice ,NSString *seriesID);

@interface TFSeriesViewController : UITableViewController
@property (nonatomic ,strong) TFSeriesName *seriesName;
@property (nonatomic ,strong) SelectSeries selectSeries;
@end
