//
//  TFPersonalController.m
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/27.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFPersonalController.h"
#import "TFCommentGroup.h"
#import "TFCommentItem.h"
#import "TFCommentArrowItem.h"
#import "TFCommonLabelItem.h"

@interface TFPersonalController ()

@end

@implementation TFPersonalController

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
    TFAccount *account = [TFAccountTool account];
    
    TFCommentGroup *group = [TFCommentGroup group];
    [self.groups addObject:group];
    
    TFCommonLabelItem *name = [TFCommonLabelItem itemWithTitle:@"姓名"];
    name.text = account.realname;
    TFCommonLabelItem *phone = [TFCommonLabelItem itemWithTitle:@"手机号"];
    phone.text = account.phone;
    TFCommonLabelItem *rank = [TFCommonLabelItem itemWithTitle:@"身份证号"];
    rank.text = account.idcard;
    group.items = @[name, phone, rank];
}

- (void)setupGroup1
{
    TFCommentGroup *group = [TFCommentGroup group];
    [self.groups addObject:group];
    
    TFCommentArrowItem *bank = [TFCommentArrowItem itemWithTitle:@"授权银行卡"];
//    bank.destClass = [TFPersonalController class];
    group.items = @[bank];
}
@end
