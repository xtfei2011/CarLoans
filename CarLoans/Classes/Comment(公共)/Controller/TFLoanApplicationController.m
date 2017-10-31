//
//  TFLoanApplicationController.m
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/17.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFLoanApplicationController.h"
#import "TFCityListViewController.h"
#import "TFBrandViewController.h"
#import "TFDatePickView.h"
#import "TFLoanApplicatController.h"

@interface TFLoanApplicationController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomMargin;
@property (nonatomic, assign, getter = isSelected) BOOL selected;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *modelsLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet TFTextField *phoneField;
@property (weak, nonatomic) IBOutlet UIButton *nextStepBtn;

@end

@implementation TFLoanApplicationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"车主贷申请（1/3）";
    self.nextStepBtn.userInteractionEnabled = NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)textFieldDidChange:(UITextField *)theTextField
{
    if (_phoneField.text.isValidateMobile) {
        
        [_nextStepBtn setBackgroundColor:TFColor(44, 159, 252)];
        _nextStepBtn.userInteractionEnabled = YES;
    } else {
        [_nextStepBtn setBackgroundColor:[UIColor lightGrayColor]];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (textField == self.phoneField) {
        if (_modelsLabel.text.length < 10 || _dateLabel.text.length < 6) {
            [TFProgressHUD showMessage:@"请先选择车型和车辆登记日期!"];
            return NO;
        }
        if (string.length == 0) return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 11) {
            return NO;
        }
    }
    return YES;
}

- (IBAction)loanApplicationButtonClick:(UIButton *)sender
{
    [self.view endEditing:YES];
    
    switch (sender.tag) {
        case 805:{
            
            TFCityListViewController *cityList = [TFCityListViewController alloc];
            cityList.selectCity = ^(NSString *cityName) {
                _addressLabel.text = cityName;
            };
            [self.navigationController pushViewController:cityList animated:YES];
        }
            break;
            
        case 806:{
            
            TFBrandViewController *brand = [[TFBrandViewController alloc] init];
            brand.selectBrand = ^(NSString *brandName, NSString *brandPrice, NSString *brandID) {
                _modelsLabel.text = brandName;
            };
            [self.navigationController pushViewController:brand animated:YES];
        }
            break;
            
        case 807:{
            
            if (_modelsLabel.text.length < 10) {
                [TFProgressHUD showMessage:@"请先选择车型"];
            } else {
                
                TFDatePickView *datePickView = [TFDatePickView viewFromXib];
                datePickView.completeBlock = ^(NSString *selectDate) {
                    
                    _dateLabel.text = selectDate;
                };
                [datePickView showPickView];
            }
        }
            break;
            
        default:
            break;
    }
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
    [self.view endEditing:YES];
    
    TFLog(@"-->");
    TFLoanApplicatController *loanApplicat = [[TFLoanApplicatController alloc] init];
    [self.navigationController pushViewController:loanApplicat animated:YES];
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
