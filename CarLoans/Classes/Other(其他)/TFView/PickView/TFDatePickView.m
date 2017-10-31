//
//  TFDatePickView.m
//  CarLoans
//
//  Created by 谢腾飞 on 2017/8/1.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFDatePickView.h"

@interface TFDatePickView ()
@property (nonatomic ,strong) NSString *dateStr;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePick;
@property (weak, nonatomic) IBOutlet UIView *pickView;
@end

@implementation TFDatePickView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.autoresizingMask = UIViewAutoresizingNone;
    self.frame = TFScreeFrame;
}

- (void)configuration
{
    _datePick.datePickerMode = UIDatePickerModeDate;
    _datePick.date = [NSDate date];
    
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd"];
    
    _dateStr = [formater stringFromDate:[NSDate date]];
    
    NSString *tempStr = [formater stringFromDate:[NSDate date]];
    NSArray *dateArray = [tempStr componentsSeparatedByString:@"-"];
    
    //设置日期选择器最大可选日期
    NSInteger maxYear = [dateArray[0] integerValue];
    NSString *maxStr = [NSString stringWithFormat:@"%ld-%@-%@",maxYear,dateArray[1],dateArray[2]];
    NSDate *maxDate = [formater dateFromString:maxStr];
    _datePick.maximumDate = maxDate;
    
    //设置日期选择器最小可选日期
    NSInteger minYear = [dateArray[0] integerValue] - 4;
    NSString *minStr = [NSString stringWithFormat:@"%ld-%@-%@",minYear,dateArray[1],dateArray[2]];
    NSDate* minDate = [formater dateFromString:minStr];
    _datePick.minimumDate = minDate;
   
}
- (IBAction)datePickView:(UIDatePicker *)sender
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyy-MM-dd"];
    _dateStr =[outputFormatter stringFromDate:_datePick.date];
}

- (IBAction)pickViewButton:(UIButton *)sender
{
    if (sender.tag == 901) {
       
        self.completeBlock(_dateStr);
    }
    [self hiddenPickView];
}

- (void)showPickView
{
    self.pickView.frame = CGRectMake(0, TFMainScreen_Height, TFMainScreen_Width, 240);
    
    [UIView animateWithDuration:0.3 animations:^{
        self.pickView.frame = CGRectMake(0, TFMainScreen_Height - 240, TFMainScreen_Width, 240);
        
    } completion:^(BOOL finished) {
        [self configuration];
    }];
    
    [TFkeyWindowView addSubview:self];
}

- (void)hiddenPickView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.pickView.frame = CGRectMake(0, TFMainScreen_Height, TFMainScreen_Width, 240);
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


@end
