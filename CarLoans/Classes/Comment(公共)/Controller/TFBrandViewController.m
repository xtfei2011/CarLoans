//
//  TFBrandViewController.m
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/27.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFBrandViewController.h"
#import "TFVehicleViewCell.h"
#import "TFSeriesViewController.h"
#import "TFBrand.h"

@interface TFBrandViewController ()
@property (nonatomic ,strong) NSMutableArray<TFBrand *> *brand;
@end

@implementation TFBrandViewController
/** cell的重用标识 */
static NSString * const VehicleID = @"TFVehicleViewCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNavigationItem];
    
    [self setupTabelView];
    
    [self loadBrandData];
}

/*** 导航栏设置 ***/
- (void)setupNavigationItem
{
    self.navigationItem.title = @"选品牌";
}

- (void)setupTabelView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.rowHeight = 44;
    self.tableView.sectionIndexColor = [UIColor grayColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    /*** 注册 cell ***/
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TFVehicleViewCell class]) bundle:nil] forCellReuseIdentifier:VehicleID];
}

- (void)loadBrandData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"type"] = @"passenger";
    
    __weak typeof(self) weakSelf = self;
    [TFNetworkTools postResultWithUrl:@"api/v1/usedcar/brand" params:params success:^(id responseObject) {
        TFLog(@"--->%@",responseObject);
        weakSelf.brand = [TFBrand mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        [weakSelf.tableView reloadData];
        
    } failure:^(NSError *error) { }];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return [self.brand valueForKeyPath:@"pin"];
}

#pragma mark 索引列点击事件
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    [TFProgressHUD showMessage:title];
    return index;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.brand.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    TFBrand *brand = self.brand[section];
    return brand.brand_list.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    TFBrand *brand = self.brand[section];
    return brand.pin;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TFVehicleViewCell *cell = [tableView dequeueReusableCellWithIdentifier:VehicleID];
    cell.seriesName = self.brand[indexPath.section].brand_list[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    TFSeriesViewController *series = [[TFSeriesViewController alloc] init];
    series.seriesName = self.brand[indexPath.section].brand_list[indexPath.row];
    
    series.selectSeries = ^(NSString *seriesName, NSString *seriesPrice, NSString *seriesID) {
        self.selectBrand(seriesName, seriesPrice, seriesID);
    };
    [self.navigationController pushViewController:series animated:YES];
}
@end
