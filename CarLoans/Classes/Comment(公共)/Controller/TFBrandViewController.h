//
//  TFBrandViewController.h
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/27.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SelectBrand)(NSString *brandName ,NSString *brandPrice,NSString *brandID);

@interface TFBrandViewController : UITableViewController
@property (nonatomic ,strong) SelectBrand selectBrand;
@end
