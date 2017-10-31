//
//  TFSeriesViewController.m
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/27.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFSeriesViewController.h"
#import "TFVehicleViewCell.h"
#import "TFModelsViewController.h"
#import "TFSeries.h"

@interface TFSeriesViewController ()
@property (nonatomic ,strong) NSMutableArray<TFSeries *> *series;
@end

@implementation TFSeriesViewController
/** cell的重用标识 */
static NSString * const VehicleID = @"TFVehicleViewCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNavigationItem];
    
    [self setupTabelView];
    
    [self loadSeriesData];
}

/*** 导航栏设置 ***/
- (void)setupNavigationItem
{
    self.navigationItem.title = @"选车系";
}

- (void)setupTabelView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    /*** 注册 cell ***/
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TFVehicleViewCell class]) bundle:nil] forCellReuseIdentifier:VehicleID];
}

- (void)loadSeriesData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"brand"] = self.seriesName.series;
    
    __weak typeof(self) weakSelf = self;
    [TFNetworkTools postResultWithUrl:@"api/v1/usedcar/series" params:params success:^(id responseObject) {
        TFLog(@"--->%@",responseObject);
        weakSelf.series = [TFSeries mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [weakSelf.tableView reloadData];
        
    } failure:^(NSError *error) { }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.series.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    TFSeries *series = self.series[section];
    return series.xilie.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    TFSeries *series = self.series[section];
    return series.ppname;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TFSeries *series = self.series[indexPath.section];
    TFVehicleViewCell *cell = [tableView dequeueReusableCellWithIdentifier:VehicleID];
    cell.seriesName = series.xilie[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    TFSeries *series = self.series[indexPath.section];
    TFModelsViewController *models = [[TFModelsViewController alloc] init];
    models.seriesName = series.xilie[indexPath.row];
    models.selectModels = ^(NSString *modelsName, NSString *modelsPrice, NSString *modelsID) {
        self.selectSeries(modelsName, modelsPrice, modelsID);
    };
    [self.navigationController pushViewController:models animated:YES];
}

@end
