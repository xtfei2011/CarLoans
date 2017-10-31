//
//  TFApplyViewController.m
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/6.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFApplyViewController.h"
#import "TFApplyHeaderView.h"
#import "TFApplyFlowCell.h"
#import "TFQuestionCell.h"
#import "TFQuestionHeaderView.h"
#import "TFProblem.h"
#import "TFAnswer.h"
#import "TFStatisticsCell.h"

@interface TFApplyViewController ()<TFQuestionHeaderDelegate>
@property (nonatomic ,strong) TFApplyHeaderView *applyHeaderView;

@property (nonatomic ,strong) NSMutableArray *answersArray;
@property (nonatomic ,assign) CGSize textSize;
@end

@implementation TFApplyViewController
/** cell的重用标识 */
static NSString * const ApplyFlowID = @"TFApplyFlowCell";
static NSString * const QuestionID = @"TFQuestionCell";
static NSString * const StatisticsID = @"TFStatisticsCell";

- (NSMutableArray *)answersArray
{
    if (_answersArray == nil) {
        self.answersArray = [NSMutableArray array];
    }
    return _answersArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"车贷申请";
    
    [self setupNavigationItem];
    [self setupTabelView];
    [self setupTopView];
    [self loadData];
}

- (void)setupNavigationItem
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"call" highImage:nil target:self action:@selector(phoneClickBtn)];
}

- (void)phoneClickBtn
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://400-027-1848"]];
}

- (void)setupTopView
{
    _applyHeaderView = [TFApplyHeaderView viewFromXib];
    
    self.tableView.tableHeaderView = _applyHeaderView;
}

- (void)setupTabelView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    
    /*** 注册 cell ***/
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TFApplyFlowCell class]) bundle:nil] forCellReuseIdentifier:ApplyFlowID];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TFQuestionCell class]) bundle:nil] forCellReuseIdentifier:QuestionID];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TFStatisticsCell class]) bundle:nil] forCellReuseIdentifier:StatisticsID];
}

- (void)loadData
{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"problemCenter.plist" withExtension:nil];
    NSArray *tempArray = [NSArray arrayWithContentsOfURL:url];
    
    self.answersArray = [NSMutableArray array];
    for (NSDictionary *dict in tempArray) {
        TFProblem *titleGroup = [TFProblem problemGroupWithDict:dict];
        [self.answersArray addObject:titleGroup];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.answersArray.count + 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section <= 1) {
        return 1;
    } else {
        TFProblem *problem = self.answersArray[section - 2];
        NSInteger count = problem.isOpened ? problem.infor.count : 0;
        return count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return (section <= 1) ? 0 : 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section <= 1) {
        return indexPath.section ? 299 : 280;
    } else {
        return self.textSize.height + 20;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section > 1) {
        TFQuestionHeaderView *header = [TFQuestionHeaderView headViewWithTableView:tableView];
        header.delegate = self;
        header.problem = self.answersArray[section - 2];
        return header;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TFApplyFlowCell *cell = [tableView dequeueReusableCellWithIdentifier:ApplyFlowID];
        return cell;
    }
    if (indexPath.section == 1) {
        TFStatisticsCell *cell = [tableView dequeueReusableCellWithIdentifier:StatisticsID];
        return cell;
        
    } else {
        TFQuestionCell *cell = [tableView dequeueReusableCellWithIdentifier:QuestionID];
        TFProblem *problem = self.answersArray[indexPath.section - 2];
        cell.answer = problem.infor[indexPath.row];
        self.textSize = [cell.answer.answer sizeWithFont:TFMoreTitleFont maxSize:CGSizeMake(TFMainScreen_Width - 40, MAXFLOAT)];
        
        return cell;
    }
}

- (void)questionHeaderClick
{
    [self.tableView reloadData];
}
@end
