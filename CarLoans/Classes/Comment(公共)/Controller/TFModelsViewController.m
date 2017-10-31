//
//  TFModelsViewController.m
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/27.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFModelsViewController.h"
#import "TFVehicleViewCell.h"
#import "TFModels.h"
#import "TFEvaluateViewController.h"
#import "TFLoanApplicationController.h"

@interface TFModelsViewController ()
@property (nonatomic ,strong) NSMutableArray<TFModels *> *models;
@end

@implementation TFModelsViewController
/** cell的重用标识 */
static NSString * const VehicleID = @"TFVehicleViewCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNavigationItem];
    
    [self setupTabelView];
    
    [self loadModelsData];
}

/*** 导航栏设置 ***/
- (void)setupNavigationItem
{
    self.navigationItem.title = @"选车型";
}

- (void)setupTabelView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    /*** 注册 cell ***/
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TFVehicleViewCell class]) bundle:nil] forCellReuseIdentifier:VehicleID];
}

- (void)loadModelsData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"series"] = self.seriesName.xlid;
    
    __weak typeof(self) weakSelf = self;
    [TFNetworkTools postResultWithUrl:@"api/v1/usedcar/car" params:params success:^(id responseObject) {
        TFLog(@"--->%@",responseObject);
        weakSelf.models = [TFModels mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [weakSelf.tableView reloadData];
        
    } failure:^(NSError *error) { }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.models.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    TFModels *models = self.models[section];
    return models.chexing_list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    TFModels *models = self.models[section];
    return [NSString stringWithFormat:@"%@款",models.pyear];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TFModels *models = self.models[indexPath.section];
    TFVehicleViewCell *cell = [tableView dequeueReusableCellWithIdentifier:VehicleID];
    cell.seriesName = models.chexing_list[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    TFModels *models = self.models[indexPath.section];
    TFSeriesName *seriesName = models.chexing_list[indexPath.row];
    
    for (UIViewController *controller in self.navigationController.viewControllers) {
        
        if ([controller isKindOfClass:[TFEvaluateViewController class]]) {
            
            TFEvaluateViewController *evaluateVC = (TFEvaluateViewController *)controller;
            self.selectModels(seriesName.cxname ,seriesName.price ,seriesName.series);
            [self.navigationController popToViewController:evaluateVC animated:YES];
            
        } else if ([controller isKindOfClass:[TFLoanApplicationController class]]) {
            
            TFLoanApplicationController *loanApplication = (TFLoanApplicationController *)controller;
            self.selectModels(seriesName.cxname ,seriesName.price ,seriesName.series);
            [self.navigationController popToViewController:loanApplication animated:YES];
        }
    }
}
@end
