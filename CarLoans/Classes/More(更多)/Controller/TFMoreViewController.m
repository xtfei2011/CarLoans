//
//  TFMoreViewController.m
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/6.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFMoreViewController.h"
#import "TFCommentGroup.h"
#import "TFCommentItem.h"
#import "TFCommentArrowItem.h"
#import "TFMoreFooterView.h"
#import "TFShareManager.h"
#import "TFComplaintsViewController.h"

@interface TFMoreViewController ()
/*** 尾部视图 ***/
@property (nonatomic ,strong) TFMoreFooterView *moreFooterView;
@property (nonatomic, strong) TFShareManager *shareView;
@end

@implementation TFMoreViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    
    [self setupGroups];
    [self setupFooterView];
}

- (void)setupFooterView
{
    _moreFooterView = [TFMoreFooterView viewFromXib];
    
    self.tableView.tableFooterView = _moreFooterView;
}

- (void)setupGroups
{
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
}

- (void)setupGroup0
{
    TFCommentGroup *group = [TFCommentGroup group];
    [self.groups addObject:group];
    
    TFCommentArrowItem *guide = [TFCommentArrowItem itemWithTitle:@"车闪贷指南" icon:@"guide"];
    group.items = @[guide];
}

- (void)setupGroup1
{
    TFCommentGroup *group = [TFCommentGroup group];
    [self.groups addObject:group];
    
    TFCommentArrowItem *address = [TFCommentArrowItem itemWithTitle:@"门店地址" icon:@"address"];
    TFCommentArrowItem *about = [TFCommentArrowItem itemWithTitle:@"关于我们" icon:@"about"];
    TFCommentArrowItem *complain = [TFCommentArrowItem itemWithTitle:@"投诉建议" icon:@"complain"];
    complain.destClass = [TFComplaintsViewController class];
    
    group.items = @[address, about, complain];
}

- (void)setupGroup2
{
    TFCommentGroup *group = [TFCommentGroup group];
    [self.groups addObject:group];
    
    TFCommentArrowItem *evaluate = [TFCommentArrowItem itemWithTitle:@"去评分" icon:@"evaluate"];
    TFCommentArrowItem *share = [TFCommentArrowItem itemWithTitle:@"分享好友" icon:@"share"];
    share.operation = ^{
        [self shareButtonClicked];
    };
    group.items = @[evaluate, share];
}

- (void)shareButtonClicked
{
    _shareView = [[TFShareManager alloc] init];
    
    [_shareView setupShareViewController:self shareTitle:@"新纪元车闪贷" shareContent:@"有车就能贷，新纪元车贷解决用钱难题，不押车利息低，推荐给傻逼的你！" shareIcon:[UIImage imageNamed:@"header_cry_icon_190x190_"] shareUrl:@"https://www.xjycf.com"];
    
    [_shareView show];
}
@end
