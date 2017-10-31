//
//  TFLoginViewController.m
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/10.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFLoginViewController.h"
#import "TFTextField.h"
#import "TFRegisterViewController.h"
#import "TFForgotPasswordController.h"

@interface TFLoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomMargin;
@property (weak, nonatomic) IBOutlet TFTextField *accountField;
@property (weak, nonatomic) IBOutlet TFTextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

/*** 账号·密码 选择状态 ***/
@property (nonatomic, assign, getter = isSelected) BOOL selected;
@end

@implementation TFLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNavigationItem];
}

- (void)setupNavigationItem
{
    self.navigationItem.title = @"登 录";
    
    self.loginBtn.userInteractionEnabled = NO;
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationButtonReturn" highImage:nil target:self action:@selector(closeLoginClickBtn)];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)closeLoginClickBtn
{
    [self.view endEditing:YES];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)textFieldDidChange:(UITextField *)theTextField
{
    if (_accountField.text.isValidateMobile && _passwordField.text.length > 6) {
        
        [_loginBtn setBackgroundColor:TFColor(44, 159, 252)];
        _loginBtn.userInteractionEnabled = YES;
    } else {
        [_loginBtn setBackgroundColor:[UIColor lightGrayColor]];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.accountField) {
        
        if (string.length == 0) return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 11) {
            return NO;
        }
    } else if (textField == self.passwordField) {
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

/*** 注册 ***/
- (IBAction)registerButtonClick:(UIButton *)sender
{
    TFRegisterViewController *registerVC = [[TFRegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (IBAction)forgotPasswordBtnClick:(UIButton *)sender
{
    TFForgotPasswordController *forgotPassword = [[TFForgotPasswordController alloc] init];
    [self.navigationController pushViewController:forgotPassword animated:YES];
}

- (IBAction)loginButtonClick:(UIButton *)sender
{
    [self.view endEditing:YES];
    
    [TFProgressHUD showLoading:@"登录中···"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"phone"] = _accountField.text;
    params[@"password"] = _passwordField.text;
    
    [TFNetworkTools postResultWithUrl:@"api/v1/user/login/ios" params:params success:^(id responseObject) {
        TFLog(@"--->%@",responseObject);
        if ([responseObject[@"code"]isEqual:@200]) {
            
            [TFProgressHUD showSuccess:responseObject[@"msg"]];
            
            TFAccount *account = [TFAccount mj_objectWithKeyValues:responseObject[@"data"]];
//            TFAccount *account = [TFAccount mj_objectWithKeyValues:responseObject[@"userinfo"]];
            [TFAccountTool saveAccount:account];
            
            
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            [TFProgressHUD showInfoMsg:responseObject[@"msg"]];
        }
        
    } failure:^(NSError *error) { TFLog(@"--->%@",error);
        
        [TFProgressHUD showFailure:@"网络超时，稍后再试"];
    }];
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
