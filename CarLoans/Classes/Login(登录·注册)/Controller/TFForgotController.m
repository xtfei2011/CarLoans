//
//  TFForgotController.m
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/26.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFForgotController.h"

@interface TFForgotController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomMargin;
@property (weak, nonatomic) IBOutlet TFTextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
/*** 输入框选择状态 ***/
@property (nonatomic ,assign ,getter = isSelected) BOOL selected;
@end

@implementation TFForgotController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"找回密码(3/3)";
    
    _submitBtn.userInteractionEnabled = NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)textFieldDidChange :(UITextField *)theTextField
{
    if (_passwordField.text.length > 5) {
        
        [_submitBtn setBackgroundColor:TFColor(44, 159, 252)];
        _submitBtn.userInteractionEnabled = YES;
        
    } else {
        [_submitBtn setBackgroundColor:[UIColor lightGrayColor]];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == _passwordField) {
        
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

- (IBAction)submitButtonClick:(UIButton *)sender
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"phone"] = self.phone;
    params[@"idcard"] = self.rank;
    params[@"smscode"] = self.code;
    params[@"password"] = _passwordField.text;
    
    [TFNetworkTools postResultWithUrl:@"api/v1/forgetPasswd/check" params:params success:^(id responseObject) {
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
