//
//  TFRegistViewController.m
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/26.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFRegistViewController.h"

@interface TFRegistViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomMargin;
@property (weak, nonatomic) IBOutlet TFTextField *passwordField;
@property (weak, nonatomic) IBOutlet TFTextField *nameField;
@property (weak, nonatomic) IBOutlet TFTextField *rankField;
@property (weak, nonatomic) IBOutlet TFTextField *inviteField;
@property (weak, nonatomic) IBOutlet UIButton *registBtn;
/*** 输入框选择状态 ***/
@property (nonatomic ,assign ,getter = isSelected) BOOL selected;
@end

@implementation TFRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"注 册(3/3)";
    
    _registBtn.userInteractionEnabled = NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)textFieldDidChange :(UITextField *)theTextField
{
    if (_passwordField.text.length > 5 && _nameField.text.length > 0 && _rankField.text.length == 18) {
        
        [_registBtn setBackgroundColor:TFColor(44, 159, 252)];
        _registBtn.userInteractionEnabled = YES;
        
    } else {
        [_registBtn setBackgroundColor:[UIColor lightGrayColor]];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == _passwordField || textField == _rankField) {
        
        if (string.length == 0) return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 18) {
            return NO;
        }
    }
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

/*** 用户协议 ***/
- (IBAction)agreementButtonClick:(UIButton *)sender
{
    
}

/*** 注册 ***/
- (IBAction)registeredBtnClick:(UIButton *)sender
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"phone"] = _phone;
    params[@"smscode"] = _code;
    params[@"password"] = _passwordField.text;
    params[@"realname"] = _nameField.text;
    params[@"idcard"] = _rankField.text;
    params[@"invite"] = _inviteField.text.length ? _inviteField.text : @"";
    
    [TFNetworkTools postResultWithUrl:@"api/v1/user/register" params:params success:^(id responseObject) {
        TFLog(@"--->%@",responseObject);
        [TFProgressHUD showInfoMsg:responseObject[@"msg"]];
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    } failure:^(NSError *error) { TFLog(@"--->%@",error); }];
}

- (void)touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
