//
//  TFForgotPasswordController.m
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/26.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFForgotPasswordController.h"
#import "TFForgotPassController.h"
#import "TFEncryption.h"

@interface TFForgotPasswordController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomMargin;
@property (weak, nonatomic) IBOutlet TFTextField *phoneField;
@property (weak, nonatomic) IBOutlet TFTextField *rankField;
@property (weak, nonatomic) IBOutlet UIButton *nextStepBtn;

/*** 输入框选择状态 ***/
@property (nonatomic ,assign ,getter = isSelected) BOOL selected;
@end

@implementation TFForgotPasswordController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"找回密码(1/3)";
    
    _nextStepBtn.userInteractionEnabled = NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)textFieldDidChange:(UITextField *)theTextField
{
    if (_phoneField.text.isValidateMobile && _rankField.text.length == 18) {
        
        [_nextStepBtn setBackgroundColor:TFColor(44, 159, 252)];
        _nextStepBtn.userInteractionEnabled = YES;
    } else {
        [_nextStepBtn setBackgroundColor:[UIColor lightGrayColor]];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.phoneField) {
        
        if (string.length == 0) return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 11) {
            return NO;
        }
    } else if (textField == self.rankField) {
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

- (IBAction)nextStepButtonClick:(UIButton *)sender
{
    NSString *str = [@"d53x6w8df4" stringByAppendingString:_phoneField.text];
    NSString *encryption = [TFEncryption xtf_Encryption:str];
    NSString *string = [@"5sdf6987f2" stringByAppendingString:encryption];
    NSString *secretKey = [TFEncryption xtf_Encryption:string];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"phone"] = _phoneField.text;
    params[@"type"] = @"getpwd";
    params[@"code"] = secretKey;
    
    [TFNetworkTools postResultWithUrl:@"api/v1/requireSmsCode" params:params success:^(id responseObject) {
        TFLog(@"--->%@",responseObject);
        [TFProgressHUD showInfoMsg:@"验证码在路上，请注意查收！"];
        
        [self pushNextController];
        
    } failure:^(NSError *error) { TFLog(@"--->%@",error); }];
}

- (void)pushNextController
{
    TFForgotPassController *forgotPass = [[TFForgotPassController alloc] init];
    forgotPass.phone = _phoneField.text;
    forgotPass.rank = _rankField.text;
    [self.navigationController pushViewController:forgotPass animated:YES];
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
