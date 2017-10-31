//
//  TFInstallmentController.m
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/14.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFInstallmentController.h"
#import "TFInstallmentView.h"
#import "TFTextField.h"
#import "TFInstallmentCell.h"
#import "TFInstallmentHeaderView.h"

@interface TFInstallmentController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *instalTableView;
@property (nonatomic ,strong) TFInstallmentView *installmentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomMargin;
/*** 输入框点击 ***/
@property (nonatomic, assign, getter = isSelected) BOOL selected;
@end

@implementation TFInstallmentController
static NSString * const InstallmentID = @"TFInstallmentCell";
static CGFloat sectionHeaderH = 80;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"月供计算器";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [self setupTabelView];
    [self setupHeaderView];
}

- (void)setupHeaderView
{
    _installmentView = [TFInstallmentView viewFromXib];
    _installmentView.evaluate = self.evaluate;
    self.instalTableView.tableHeaderView = _installmentView;
}

- (void)setupTabelView
{
    /*** 注册 cell ***/
    [self.instalTableView registerNib:[UINib nibWithNibName:NSStringFromClass([TFInstallmentCell class]) bundle:nil] forCellReuseIdentifier:InstallmentID];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.evaluate.loan_list.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    TFEvaluateList *list = self.evaluate.loan_list[section];
    return list.repay_list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TFInstallmentCell *cell = [tableView dequeueReusableCellWithIdentifier:InstallmentID];
    TFEvaluateList *list = self.evaluate.loan_list[indexPath.section];
    TFEvaluateItem *item = list.repay_list[indexPath.row];
    cell.item = item;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 80;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    TFInstallmentHeaderView *headerView = [TFInstallmentHeaderView viewFromXib];
    headerView.list = self.evaluate.loan_list[section];
    return headerView;
}

/*** 阻止 tableView 的 Header 悬浮 ***/
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scrollViewY = scrollView.contentOffset.y;
    
    if (scrollView == self.instalTableView) {
        if (scrollViewY <= sectionHeaderH && scrollViewY >= 0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollViewY, 0, 0, 0);
        } else if (scrollViewY >= sectionHeaderH) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderH, 0, 0, 0);
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    textField.delegate = self;
    return YES;
}

#pragma mark - 监听
- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    if (_selected == NO) {
        _selected = YES;
    }
    // 修改约束
    CGFloat keyboardY = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    CGFloat screenH = TFMainScreen_Height;
    self.bottomMargin.constant = screenH - keyboardY;
    
    // 执行动画
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
