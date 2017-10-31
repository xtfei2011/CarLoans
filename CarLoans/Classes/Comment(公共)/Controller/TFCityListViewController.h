//
//  TFCityListViewController.h
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/13.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SelectCity)(NSString *cityName);

@interface TFCityListViewController : UIViewController
@property (nonatomic ,strong) SelectCity selectCity;
@end
