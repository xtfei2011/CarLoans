//
//  TFComplaintsViewController.m
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/13.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFComplaintsViewController.h"
#import "TFTextView.h"
#import "TFTextField.h"

@interface TFComplaintsViewController ()<UITextViewDelegate>
/*** 文本框输入控件 ***/
@property (nonatomic, strong) TFTextView *textView;
/*** 文字个数提醒 ***/
@property (nonatomic, strong) UILabel *textNumLabel;

@property (nonatomic, strong) TFTextField *textField;
@end

@implementation TFComplaintsViewController
NSInteger const MaxTextCount = 200;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupTextView];
    [self setupOtherView];
}

/*** 文字输入控件 ***/
- (void)setupTextView
{
    self.textView = [[TFTextView alloc] init];
    self.textView.frame = CGRectMake(0, 10, TFMainScreen_Width, TFMainScreen_Height/3);
    self.textView.backgroundColor = [UIColor whiteColor];
    self.textView.delegate = self;
    self.textView.placehoder = @"您好，请描述您遇到的问题 ...";
    [self.view addSubview:self.textView];
}

/*** 其他控件 ***/
- (void)setupOtherView
{
    _textNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(TFMainScreen_Width *2/3, CGRectGetMaxY(self.textView.frame) + 5, TFMainScreen_Width/3 - 10, 15)];
    _textNumLabel.font = TFCommentTitleFont;
    _textNumLabel.textAlignment = NSTextAlignmentRight;
    _textNumLabel.text = [NSString stringWithFormat:@"0/%ld",MaxTextCount];
    _textNumLabel.textColor = TFColor(153, 153, 153);
    [self.view addSubview:_textNumLabel];
    
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_textNumLabel.frame) + 10, TFMainScreen_Width, 40)];
    baseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:baseView];
    
    _textField = [[TFTextField alloc]initWithFrame:CGRectMake(10, 0, TFMainScreen_Width - 20, 40)];
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.font = TFMoreTitleFont;
    _textField.textColor = [UIColor grayColor];
    _textField.borderStyle = UITextBorderStyleNone;
    _textField.placeholder = @"手机号码";
    _textField.keyboardType = UIKeyboardTypeNumberPad;
    [baseView addSubview:_textField];
    
    UIButton *submitButton = [UIButton createButtonFrame:CGRectMake(10, CGRectGetMaxY(baseView.frame) + 20, TFMainScreen_Width - 20, 40) title:@"提 交" titleColor:[UIColor whiteColor] font:[UIFont fontWithName:@"Heiti SC" size:19] target:self action:@selector(submitBtnClicked)];
    [self.view addSubview:submitButton];
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    _textNumLabel.text = [NSString stringWithFormat:@"%lu/%ld",(unsigned long)_textView.text.length, MaxTextCount];
    
    if (_textView.text.length > MaxTextCount) {
        _textNumLabel.textColor = [UIColor redColor];
    }else{
        _textNumLabel.textColor = TFColor(153, 153, 153);
    }
    return YES;
}

- (void)textViewDidChangeSelection:(UITextView *)textView
{
    _textNumLabel.text = [NSString stringWithFormat:@"%lu/%ld",(unsigned long)_textView.text.length, MaxTextCount];
    
    if (_textView.text.length > MaxTextCount) {
        _textNumLabel.textColor = [UIColor redColor];
    }else{
        _textNumLabel.textColor = TFColor(153, 153, 153);
    }
}

/*** 发布按钮点击事件 ***/
- (void)submitBtnClicked
{
    [self.view endEditing:YES];
    
    if (![self checkInput]) return;
    
    [self submitToServer];
}

#pragma maek - 检查输入
- (BOOL)checkInput
{
    if (_textView.text.length == 0)
    {
        [TFProgressHUD showInfoMsg:@"您还没有告诉我您的问题！"];
        return NO;
    }
    if (_textView.text.length > MaxTextCount)
    {
        [TFProgressHUD showInfoMsg:@"超出文字限制"];
        return NO;
    }
    if (_textField.text.length == 0)
    {
        [TFProgressHUD showInfoMsg:@"您的联系方式"];
        return NO;
    }
    return YES;
}

/*** 提交投诉 ***/
- (void)submitToServer
{
   [TFProgressHUD showLoading:@"正在提交···"];
}

- (void)touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
