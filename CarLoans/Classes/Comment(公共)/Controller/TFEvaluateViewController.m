//
//  TFEvaluateViewController.m
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/12.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFEvaluateViewController.h"
#import "TFEvaluateContentView.h"
#import "TFCityListViewController.h"
#import "TFInstallmentController.h"
#import "TFBrandViewController.h"
#import "TFDatePickView.h"
#import "TFEvaluate.h"
#import "UILabel+TFExtension.h"

@interface TFEvaluateViewController ()<TFEvaluateContentBtnDelegate>
@property (nonatomic ,strong) TFEvaluateContentView *evaluateView;

@property (nonatomic ,strong) TFEvaluate *evaluate;
/*** 价格 ***/
@property (nonatomic ,strong) NSString *price;
/*** ID ***/
@property (nonatomic ,strong) NSString *ID;

@end

@implementation TFEvaluateViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupEvaluateView];
}

- (void)setupEvaluateView
{
    _evaluateView = [TFEvaluateContentView viewFromXib];
   
    if ([self.title isEqualToString:@"月供计算器"]) {
        _evaluateView.topImageView.image = [UIImage imageNamed:@"installment"];
    }
    _evaluateView.delegate = self;
    [self.view addSubview:_evaluateView];
}

/*** 选择按钮 ***/
- (void)evaluateContentBtn:(UIButton *)sender
{
    switch (sender.tag) {
        case 802:{
            
            TFCityListViewController *cityList = [TFCityListViewController alloc];
            cityList.selectCity = ^(NSString *cityName) {
                _evaluateView.addressLabel.text = cityName;
            };
            [self.navigationController pushViewController:cityList animated:YES];
        }
            break;
            
        case 803:{
            
            TFBrandViewController *brand = [[TFBrandViewController alloc] init];
            brand.selectBrand = ^(NSString *brandName, NSString *brandPrice, NSString *brandID) {
                _evaluateView.seriesLabel.text = brandName;
                self.price = brandPrice;
                self.ID = brandID;
            };
            [self.navigationController pushViewController:brand animated:YES];
        }
            break;
            
        case 804:{
            
            if (_evaluateView.seriesLabel.text.length < 10) {
                [TFProgressHUD showMessage:@"请先选择车型"];
            } else {
                
                TFDatePickView *datePickView = [TFDatePickView viewFromXib];
                datePickView.completeBlock = ^(NSString *selectDate) {
                    
                    _evaluateView.dateLabel.text = selectDate;
                };
                [datePickView showPickView];
            }
        }
            break;
            
        case 805:{
            
            [self loadData];
        }
            break;
            
        case 806:{
            
            [self setupInstalmentView];
        }
            break;
            
        default:
            break;
    }
}

- (void)loadData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"carstatus"] = @"1";
    params[@"purpose"] = @"1";
    params[@"city"] = _evaluateView.addressLabel.text;
    params[@"car"] = self.ID;
    params[@"useddate"] = @"2016";
    params[@"useddateMonth"] = @"04";
    params[@"mileage"] = @"0.1";
    params[@"price"] = self.price;
    params[@"cxname"] = _evaluateView.seriesLabel.text;
    
    TFLog(@"---->%@",params);
    
    __weak typeof(self) weakSelf = self;
    [TFNetworkTools postResultWithUrl:@"api/v1/usedcar/assess" params:params success:^(id responseObject) {
        [responseObject writeToFile:@"/Users/xietengfei/Desktop/CarLoans.plist" atomically:YES];
        TFLog(@"--->%@",responseObject);
        weakSelf.evaluate = [TFEvaluate mj_objectWithKeyValues:responseObject[@"data"]];
        
        [self setupNextView];
        
    } failure:^(NSError *error) { }];
}

- (void)setupNextView
{
    [self.title isEqualToString:@"月供计算器"] ? [self setupInstalmentView] : [self setupAssessmentView];
}

/*** 额度评估 ***/
- (void)setupAssessmentView
{
    _evaluateView.priceLabel.text = [NSString stringWithFormat:@"最高可贷 %@ 万元",self.evaluate.loan_max];
    _evaluateView.priceLabel.keywords = self.evaluate.loan_max;
    _evaluateView.priceLabel.keywordsColor = TFColor(36, 181, 232);
    _evaluateView.priceLabel.keywordsFont = [UIFont systemFontOfSize:60];
    
    CGSize investSize =  [_evaluateView.priceLabel getLableSizeWithMaxWidth:200];
    _evaluateView.priceLabel.frame = CGRectMake(0, 10, investSize.width, investSize.height);
    [_evaluateView.appraisementView addSubview:_evaluateView.priceLabel];
    
    _evaluateView.ascertainBtn.hidden = YES;
    _evaluateView.toolView.hidden = NO;
    _evaluateView.appraisementView.hidden = NO;
}

/*** 月供计算器 ***/
- (void)setupInstalmentView
{
    TFInstallmentController *installment = [[TFInstallmentController alloc] init];
    installment.evaluate = self.evaluate;
    [self.navigationController pushViewController:installment animated:YES];
}
@end
