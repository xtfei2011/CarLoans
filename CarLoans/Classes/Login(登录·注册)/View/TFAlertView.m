//
//  TFAlertView.m
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/11.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFAlertView.h"

@interface TFAlertView ()

/*** 取消按钮 ***/
@property (nonatomic ,strong) UIButton *cancelBtn;
/*** 确认按钮 ***/
@property (nonatomic ,strong) UIButton *sureBtn;
/*** 标题 ***/
@property (nonatomic ,strong) UILabel *titleLabel;
/*** 提示文字 ***/
@property (nonatomic ,strong) UILabel *messageLabel;
/*** 提示View ***/
@property (nonatomic ,strong) UIView *promptView;
@end

@implementation TFAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        /*** 初始化参数 ***/
        [self setupParameter];
    }
    return self;
}

- (void)setupParameter
{
    _promptView = [[UIView alloc] init];
    _promptView.backgroundColor = [UIColor whiteColor];
    _promptView.layer.cornerRadius = 3;
    _promptView.layer.masksToBounds = YES;
    _promptView.autoresizingMask = (UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin);
    
    [self addSubview:_promptView];
    
    _titleLabel = [self setupLabelNumberOfLines:1 textPlace:NSTextAlignmentCenter textColor:[UIColor redColor] font:TFSetPromptTitleFont];
    [self.promptView addSubview:_titleLabel];
    
    _messageLabel = [self setupLabelNumberOfLines:0 textPlace:NSTextAlignmentLeft textColor:[UIColor darkGrayColor] font:TFMoreTitleFont];
    [self.promptView addSubview:_messageLabel];
    
    _sureBtn = [self setupButtonTarget:self action:@selector(doneBtnClicked:)];
    [self.promptView addSubview:_sureBtn];
    
    _cancelBtn = [self setupButtonTarget:self action:@selector(doneBtnClicked:)];
    [self.promptView addSubview:_cancelBtn];
}

+ (TFAlertView *)sharedAlert
{
    static TFAlertView *sharedAlert;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedAlert = [[TFAlertView alloc] initWithFrame:TFScreeFrame];
    });
    return sharedAlert;
}

+ (void)showPromptTitle:(NSString *)title message:(NSString *)message;
{
    TFAlertView *alert = [self sharedAlert];
    [alert showWithTitle:title message:message sureBtnTitle:@"我知道啦" cancelBtnTitle:nil btnClickBlock:nil coverCanClick:YES promptType:@"text"];
    [alert show];
}

/*** 单一文字提示 ***/
+ (void)showPromptMessage:(NSString *)message clickedBlock:(TFPromptAlertBlock)clickedBlock
{
    TFAlertView *alert = [self sharedAlert];
    
    alert.block = clickedBlock;
    [alert showWithTitle:@"温馨提示" message:message sureBtnTitle:@"确定" cancelBtnTitle:@"取消" btnClickBlock:clickedBlock coverCanClick:YES promptType:@"select"];
    [alert show];
}

/*** 带选择文字提示 ***/
- (void)showWithTitle:(NSString *)title message:(NSString *)message sureBtnTitle:(NSString *)sureBtnTitle cancelBtnTitle:(NSString *)cancelBtnTitle btnClickBlock:(TFPromptAlertBlock)btnClickedBlock coverCanClick:(BOOL)isCoverCanClick promptType:(NSString *)type
{
    self.titleLabel.text = title;
    self.messageLabel.text = message;
    
    [self.sureBtn setTitle:sureBtnTitle forState:UIControlStateNormal];
    [self.cancelBtn setTitle:cancelBtnTitle forState:UIControlStateNormal];
    
    if (btnClickedBlock) {
        self.block = btnClickedBlock;
        [self.sureBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self setupFrame:type];
}

- (void)setupFrame:(NSString *)type
{
    CGFloat marginToScreenLeft = 40;
    CGFloat marginToPromptViewLeft = 20;
    CGFloat marginToPromptViewTop = 20;
    CGFloat promptViewWidth = TFMainScreen_Width - 2 * marginToScreenLeft;
    CGFloat padding = 20;
    CGFloat subViewWidth = promptViewWidth - 2 * marginToPromptViewLeft;
    
    /** 提示 **/
    self.titleLabel.frame = CGRectMake(marginToPromptViewLeft, marginToPromptViewTop, subViewWidth, 20);
    
    /** 内容 **/
    NSString *messageStr = self.messageLabel.text;
    CGFloat messageStrHeight;
    
    if (messageStr) {
        
        CGSize constraintSize = CGSizeMake(subViewWidth, TFMainScreen_Height * 0.6);
        
        CGRect tipsStringRect = [messageStr boundingRectWithSize:constraintSize  options:(NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName: self.messageLabel.font} context:NULL];
        
        messageStrHeight = tipsStringRect.size.height;
    }else{
        messageStrHeight = 40;
    }
    
    self.messageLabel.frame = CGRectMake(marginToPromptViewLeft, CGRectGetMaxY(self.titleLabel.frame) + padding * 0.8, subViewWidth, messageStrHeight);
    
    /** 确定 **/
    CGFloat sureBtnW = (subViewWidth - 40)/2;
    CGFloat sureBtnH = 40;
    CGFloat sureBtnX = (promptViewWidth - sureBtnW * 2)/2;
    
    if ([type isEqualToString:@"text"]) {
        self.sureBtn.frame = CGRectMake(marginToPromptViewLeft, CGRectGetMaxY(self.messageLabel.frame) + padding, subViewWidth, sureBtnH);
        
    } else if([type isEqualToString:@"select"]){
        self.sureBtn.frame = CGRectMake(sureBtnX, CGRectGetMaxY(self.messageLabel.frame) + padding, sureBtnW, sureBtnH);
        self.sureBtn.tag = 1000;
        
        self.cancelBtn.frame = CGRectMake(CGRectGetMaxX(self.sureBtn.frame) + 10, CGRectGetMaxY(self.messageLabel.frame) + padding, sureBtnW, sureBtnH);
        self.cancelBtn.tag = 1001;
    }
    /** 内容 **/
    CGFloat promptViewHeight = CGRectGetMaxY(self.sureBtn.frame) + padding;
    CGFloat promptViewX = (self.xtf_width - promptViewWidth)/2;
    CGFloat promptViewY = (self.xtf_height - promptViewHeight)/2;
    self.promptView.frame = CGRectMake(promptViewX, promptViewY, promptViewWidth, promptViewHeight);
}

- (void)show
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        
        for (UIWindow *tmpWin in windows) {
            
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    
    [window.layer removeAllAnimations];
    [window addSubview:self];
    
    [self showBackground];
    [self showAlertAnimation];
}

- (void)lightColor
{
    self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.1];
    self.promptView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.1];
    self.titleLabel.alpha = 0.1;
    self.messageLabel.alpha = 0.1;
    self.sureBtn.alpha = 0.1;
    self.cancelBtn.alpha = 0.1;
}

- (void)darkColor
{
    self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
    self.promptView.backgroundColor = [UIColor whiteColor];
    self.titleLabel.alpha = 1.0;
    self.messageLabel.alpha = 1.0;
    self.sureBtn.alpha = 1.0;
    self.cancelBtn.alpha = 1.0;
}

- (void)showBackground
{
    [self lightColor];
    [UIView animateWithDuration:kAnimationDutation animations:^{
        [self darkColor];
    }];
}

/*** 出现动画 ***/
- (void)showAlertAnimation
{
    CAKeyframeAnimation *animation = [self setupMakeScaleSX:0.9 sy:0.9 sz:1.0 tosx:1.0 tosy:1.0 tosz:1.0];
    [self.promptView.layer addAnimation:animation forKey:nil];
}

/*** 消失动画 ***/
- (void)dismissAlertAnimation
{
    CAKeyframeAnimation *animation = [self setupMakeScaleSX:1.0 sy:1.0 sz:1.0 tosx:0.9 tosy:0.9 tosz:1.0];
    [self.promptView.layer addAnimation:animation forKey:nil];
}

- (void)dismiss
{
    [UIView animateWithDuration:kAnimationDutation animations:^{
        [self lightColor];
        [self dismissAlertAnimation];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - Button Actions
- (void)doneBtnClicked:(UIButton *)sender
{
    if (self.block) {
        self.block(sender.tag);
    }
    [self dismiss];
}

- (UILabel *)setupLabelNumberOfLines:(CGFloat)numberOfLines textPlace:(NSTextAlignment)textPlace textColor:(UIColor *)textColor font:(UIFont *)font
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    
    label.backgroundColor = [UIColor clearColor];
    label.adjustsFontSizeToFitWidth = YES;
    label.textAlignment = textPlace;
    label.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    label.numberOfLines = numberOfLines;
    label.minimumScaleFactor = 0.7;
    label.textColor = textColor;
    label.font = font;
    
    return label;
}

- (UIButton *)setupButtonTarget:(id)target action:(SEL)action
{
    UIButton *button = [[UIButton alloc] init];
    button.backgroundColor = TFColor(251, 99, 102);
    button.layer.cornerRadius = 3.0f;
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

/*** 动画位移 ***/
- (CAKeyframeAnimation *)setupMakeScaleSX:(CGFloat)sx sy:(CGFloat)sy sz:(CGFloat)sz tosx:(CGFloat)tosx tosy:(CGFloat)tosy tosz:(CGFloat)tosz
{
    CAKeyframeAnimation *animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = kAnimationDutation;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(sx, sy, sz)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(tosx, tosy, tosz)]];
    
    animation.values = values;
    
    return animation;
}
@end
