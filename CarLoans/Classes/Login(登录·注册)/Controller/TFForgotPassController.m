//
//  TFForgotPassController.m
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/26.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFForgotPassController.h"
#import "TFForgotController.h"
#import "TFEncryption.h"

@interface TFForgotPassController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomMargin;
@property (weak, nonatomic) IBOutlet TFTextField *codeField;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UIButton *nextStepBtn;
@property (weak, nonatomic) IBOutlet UIButton *againBtn;

/*** 输入框选择状态 ***/
@property (nonatomic ,assign ,getter = isSelected) BOOL selected;
@end

@implementation TFForgotPassController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"找回密码(2/3)";
    
    /*** 初始化参数 ***/
    [self setupParameter];
    
    /*** 开始倒计时 ***/
    [self startCountdown];
}

- (void)setupParameter
{
    _nextStepBtn.userInteractionEnabled = NO;
    
    _phoneLabel.text = [NSString stringWithFormat:@"验证码已发送至%@****%@",[_phone substringToIndex:3],[_phone substringFromIndex:7]];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)startCountdown
{
    __block int timeout = 60;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeout <= 0){
            
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [_againBtn setTitle:@"重新发送" forState:UIControlStateNormal];
                _againBtn.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = timeout % 60;
            
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [_againBtn setTitle:[NSString stringWithFormat:@"%@",strTime] forState:UIControlStateNormal];
                _againBtn.userInteractionEnabled = NO;
            });
            
            timeout--;
        }
    });
    
    dispatch_resume(_timer);
}

- (void)textFieldDidChange :(UITextField *)theTextField
{
    if (theTextField.text.length == 6) {
        
        [_nextStepBtn setBackgroundColor:TFColor(44, 159, 252)];
        _nextStepBtn.userInteractionEnabled = YES;
        
    } else {
        [_nextStepBtn setBackgroundColor:[UIColor lightGrayColor]];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.codeField) {
        
        if (string.length == 0) return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 6) {
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

/*** 验证码获取失败 ***/
- (IBAction)failureButtonClick:(UIButton *)sender
{
    [TFAlertView showPromptTitle:@"收不到验证码？" message:@"① 手机号码输入有误\n② 请查看短信是否被安全软件拦截\n③ 由于网络原因，可能存在短信延迟，请耐心等待或稍后再试"];
}

/*** 重新获取验证码 ***/
- (IBAction)againButtonClick:(UIButton *)sender
{
    NSString *str = [@"d53x6w8df4" stringByAppendingString:self.phone];
    NSString *encryption = [TFEncryption xtf_Encryption:str];
    NSString *string = [@"5sdf6987f2" stringByAppendingString:encryption];
    NSString *secretKey = [TFEncryption xtf_Encryption:string];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"phone"] = self.phone;
    params[@"type"] = @"getpwd";
    params[@"code"] = secretKey;
    
    [TFNetworkTools postResultWithUrl:@"api/v1/requireSmsCode" params:params success:^(id responseObject) {
        TFLog(@"--->%@",responseObject);
        [TFProgressHUD showInfoMsg:@"验证码在路上，请注意查收！"];
        /*** 开始倒计时 ***/
        [self startCountdown];
        
    } failure:^(NSError *error) { TFLog(@"--->%@",error); }];
}

- (IBAction)nextStepButtonClick:(UIButton *)sender
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"phone"] = self.phone;
    params[@"smscode"] = _codeField.text;
    
    [TFNetworkTools postResultWithUrl:@"api/v1/registerCheckSmsCode" params:params success:^(id responseObject) {
        TFLog(@"--->%@",responseObject);
        if ([responseObject[@"code"] isEqual:@200]) {
            
            TFForgotController *forgot = [[TFForgotController alloc] init];
            forgot.phone = self.phone;
            forgot.code = self.codeField.text;
            forgot.rank = self.rank;
            [self.navigationController pushViewController:forgot animated:YES];
        }
        
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
