//
//  TFSetViewController.m
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/20.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFSetViewController.h"
#import "TFCommentGroup.h"
#import "TFCommentItem.h"
#import "TFCommentArrowItem.h"
#import "TFPersonalController.h"

@interface TFSetViewController ()

@end

@implementation TFSetViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    
    [self setupGroups];
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
    
    TFCommentArrowItem *personal = [TFCommentArrowItem itemWithTitle:@"个人信息"];
    personal.destClass = [TFPersonalController class];
    group.items = @[personal];
}

- (void)setupGroup1
{
    TFCommentGroup *group = [TFCommentGroup group];
    [self.groups addObject:group];
    
    TFCommentArrowItem *modify = [TFCommentArrowItem itemWithTitle:@"修改密码"];
    TFCommentArrowItem *clean = [TFCommentArrowItem itemWithTitle:@"清理缓存"];
    
    group.items = @[modify, clean];
}
@end
