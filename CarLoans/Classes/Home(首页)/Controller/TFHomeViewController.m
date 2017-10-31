//
//  TFHomeViewController.m
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/6.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFHomeViewController.h"
#import "TFTopScrollView.h"
#import "TFScrollViewModel.h"
#import "TFExhibitionViewCell.h"
#import "TFLoanViewCell.h"
#import "TFEvaluateViewCell.h"
#import "TFEvaluateViewController.h"
#import "TFLoanApplicationController.h"

@interface TFHomeViewController ()<ClickPushDelegate, TFEvaluateBtnDelegate>
/*** Top 滚动视图 ***/
@property (nonatomic ,strong) TFTopScrollView *topScrollView;
@property (nonatomic ,strong) NSMutableArray *array;
@end

@implementation TFHomeViewController
/** cell的重用标识 */
static NSString * const ExhibitionID = @"TFExhibitionViewCell";
static NSString * const LoanID = @"TFLoanViewCell";
static NSString * const EvaluateID = @"TFEvaluateViewCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNavigationItem];
    [self setupTabelView];
    [self loadDataSource];
}

- (void)setupNavigationItem
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 157.7, 25)];
    UIImageView *image = [[UIImageView alloc] initWithFrame:view.bounds];
    image.image = [UIImage imageNamed:@"home_navigationItem"];
    [view addSubview:image];
    self.navigationItem.titleView = view;
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"call" highImage:nil target:self action:@selector(phoneClickBtn)];
}

- (void)phoneClickBtn
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://400-027-1848"]];
}

- (void)loadDataSource
{
    [self setTopScrollView];
    [self loadTopScrollData];
}

- (void)setupTabelView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);

    /*** 注册 cell ***/
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TFExhibitionViewCell class]) bundle:nil] forCellReuseIdentifier:ExhibitionID];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TFLoanViewCell class]) bundle:nil] forCellReuseIdentifier:LoanID];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TFEvaluateViewCell class]) bundle:nil] forCellReuseIdentifier:EvaluateID];
}

/*** 轮播视图 ***/
- (void)setTopScrollView
{
    _topScrollView = [[TFTopScrollView alloc] initWithFrame:CGRectMake(0, 0, TFMainScreen_Width,ScrollViewHeight)];
    _topScrollView.delegate = self;
    self.tableView.tableHeaderView = _topScrollView;
}

/*** 加载滚动数据 ***/
- (void)loadTopScrollData
{
    __weak typeof(self) homeSelf = self;
    
    [TFNetworkTools getResultWithUrl:@"api/v1/home/banner" params:nil success:^(id responseObject) {
        TFLog(@"--->%@",responseObject);
        NSArray *topArray = responseObject[@"data"];
        self.array = [[NSMutableArray alloc] initWithCapacity:topArray.count];
        for (NSDictionary * dict in topArray) {
            [self.array addObject:[[TFScrollViewModel alloc] initWithDict:dict]];
        }
        homeSelf.topScrollView.dataSource = self.array;
        [homeSelf.topScrollView startScroll];
    } failure:^(NSError *error) { }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (indexPath.section == 0) ? 100 : (indexPath.section == 1) ? 130 : 150;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        TFExhibitionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ExhibitionID];
        return cell;
    } else if (indexPath.section == 1) {
        
        TFLoanViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LoanID];
        return cell;
    } else {
        TFEvaluateViewCell *cell = [tableView dequeueReusableCellWithIdentifier:EvaluateID];
        cell.delegate = self;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section == 1) {
        TFLoanApplicationController *loanApplication = [[TFLoanApplicationController alloc] init];
        [self.navigationController pushViewController:loanApplication animated:YES];
    }
}

- (void)evaluateBtnClick:(UIButton *)sender
{
    TFEvaluateViewController *evaluateVC = [[TFEvaluateViewController alloc] init];
    evaluateVC.title = (sender.tag == 800) ? @"额度评估" : @"月供计算器";
    [self.navigationController pushViewController:evaluateVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
