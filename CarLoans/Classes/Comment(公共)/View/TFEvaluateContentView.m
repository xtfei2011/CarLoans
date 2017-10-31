//
//  TFEvaluateContentView.m
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/12.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFEvaluateContentView.h"
#import "TFAlertView.h"
#import "UILabel+TFExtension.h"

@interface TFEvaluateContentView ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomMargin;
/*** 输入框点击 ***/
@property (nonatomic, assign, getter = isSelected) BOOL selected;
@end

@implementation TFEvaluateContentView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setupInterface];
}

- (void)setupInterface
{
    self.autoresizingMask = UIViewAutoresizingNone;
    
    _toolView.hidden = YES;
    _appraisementView.hidden = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (IBAction)promptButtonClick:(UIButton *)sender
{
    [TFAlertView showPromptTitle:@"非营运车辆且无大事故说明" message:@"Ⅰ.非营运车辆：指机动车行驶证上使用性质栏为“非营运”。\n\nⅡ.无大事故是指车辆无以下情况：\n① 纵梁，元宝梁，后桥焊接，切割，整形，变形；\n② 减振器座焊接，切割，整形，变形；\n③ 后备箱底板焊接，切割，整形，变形；\n④ ABC柱焊接，切割，整形，变形；\n⑤ 因撞击造成汽车安全气囊弹出；\n⑥ 水淹；\n⑦ 火烧。"];
}

- (IBAction)evaluateContentButtonClick:(UIButton *)sender
{
    if ([_delegate respondsToSelector:@selector(evaluateContentBtn:)]) {
        [_delegate evaluateContentBtn:sender];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.xtf_width = TFMainScreen_Width;
    self.xtf_height = TFMainScreen_Height - 64;
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
        [self layoutIfNeeded];
    }];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    [self endEditing:YES];
}
@end
