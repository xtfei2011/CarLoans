//
//  TFMineViewController.m
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/6.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFMineViewController.h"
#import "TFMineHeaderView.h"
#import "TFCommentGroup.h"
#import "TFCommentItem.h"
#import "TFCommentArrowItem.h"
#import "TFLoanApplicationController.h"
#import "TFSetViewController.h"

@interface TFMineViewController ()
/*** 我的Top部视图 ***/
@property (nonatomic ,strong) TFMineHeaderView *headerView;
@end

@implementation TFMineViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupTopView];
    [self setupGroups];
}

- (void)setupTopView
{
    _headerView = [TFMineHeaderView viewFromXib];
    self.tableView.tableHeaderView = _headerView;
}

- (void)setupGroups
{
    [self setupGroup0];
    [self setupGroup1];
}

- (void)setupGroup0
{
    TFCommentGroup *group = [TFCommentGroup group];
    [self.groups addObject:group];
    
    TFCommentArrowItem *repay = [TFCommentArrowItem itemWithTitle:@"还款管理" icon:@"repay"];
    TFCommentArrowItem *apply = [TFCommentArrowItem itemWithTitle:@"车闪贷申请" icon:@"apply"];
    apply.destClass = [TFLoanApplicationController class];
    TFCommentArrowItem *mine = [TFCommentArrowItem itemWithTitle:@"我的车闪贷" icon:@"mine"];
    
    group.items = @[repay, apply, mine];
}

- (void)setupGroup1
{
    TFCommentGroup *group = [TFCommentGroup group];
    [self.groups addObject:group];
    
    TFCommentArrowItem *set = [TFCommentArrowItem itemWithTitle:@"设置" icon:@"set"];
    set.destClass = [TFSetViewController class];
    group.items = @[set];
}
@end
