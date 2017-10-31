//
//  TFCommentViewController.m
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/10.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFCommentViewController.h"
#import "TFCommentCell.h"
#import "TFCommentArrowItem.h"
#import "TFCommentItem.h"
#import "TFCommentGroup.h"

@interface TFCommentViewController ()
@property (nonatomic ,strong) NSMutableArray *groups;
@end

@implementation TFCommentViewController

- (NSMutableArray *)groups
{
    if (_groups == nil) {
        self.groups = [NSMutableArray array];
    }
    return _groups;
}

- (instancetype) init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.backgroundColor = TFGlobalBg;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.sectionFooterHeight = 10;
    self.tableView.sectionHeaderHeight = 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    TFCommentGroup *group = self.groups[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TFCommentCell *cell = [TFCommentCell cellWithTableView:tableView];
    TFCommentGroup *group = self.groups[indexPath.section];
    cell.item = group.items[indexPath.row];
    
    [cell setIndexPath:indexPath rowsInSection:(int)group.items.count];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    TFCommentGroup *group = self.groups[indexPath.section];
    TFCommentItem *item = group.items[indexPath.row];
    
    if (item.destClass) {
        
        UIViewController *destVC = [[item.destClass alloc] init];
        destVC.title = item.title;
        [self.navigationController pushViewController:destVC animated:YES];
    }
    
    if (item.operation) {
        item.operation();
    }
}
@end
