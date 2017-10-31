//
//  TFCommentCell.m
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/10.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFCommentCell.h"
#import "TFCommentItem.h"
#import "TFCommonLabelItem.h"

@interface TFCommentCell ()
@property (nonatomic ,strong) UIImageView *rightArrow;
@property (nonatomic ,strong) UILabel *rightLabel;
@end

@implementation TFCommentCell
NSString * const TFCommentID = @"TFCommentCell";

- (UIImageView *)rightArrow
{
    if (_rightArrow == nil) {
        
        _rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_arrow"]];
    }
    return _rightArrow;
}

- (UILabel *)rightLabel {
    
    if (_rightLabel == nil) {
        
        self.rightLabel = [[UILabel alloc] init];
        
        self.rightLabel.textColor = [UIColor lightGrayColor];
        self.rightLabel.font = TFCommentTitleFont;
    }
    return _rightLabel;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    TFCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:TFCommentID];
    if (cell == nil) {
        cell = [[TFCommentCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TFCommentID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.font = TFMoreTitleFont;
        self.detailTextLabel.font = TFCommentSubTitleFont;
        self.backgroundView = [[UIImageView alloc] init];
        self.selectedBackgroundView = [[UIImageView alloc] init];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.detailTextLabel.xtf_x = CGRectGetMaxX(self.textLabel.frame) + 5;
}

- (void)setIndexPath:(NSIndexPath *)indexPath rowsInSection:(int)rows
{
    UIImageView *backgroundView = (UIImageView *)self.backgroundView;
    UIImageView *selectedBackground = (UIImageView *)self.selectedBackgroundView;
    
    if (indexPath.row == 0) {
        backgroundView.image = [UIImage initImageWithName:@"common_card_top_background"];
        selectedBackground.image = [UIImage initImageWithName:@"common_card_top_background_highlighted"];
        
    } else if (indexPath.row == rows - 1) {
        backgroundView.image = [UIImage initImageWithName:@"common_card_bottom_background"];
        selectedBackground.image = [UIImage initImageWithName:@"common_card_bottom_background_highlighted"];
        
    } else {
        backgroundView.image = [UIImage initImageWithName:@"common_card_middle_background"];
        selectedBackground.image = [UIImage initImageWithName:@"common_card_middle_background_highlighted"];
    }
}

- (void)setItem:(TFCommentItem *)item
{
    _item = item;
    
    self.imageView.image = [UIImage imageWithName:item.icon];
    self.textLabel.text = item.title;
    self.detailTextLabel.text = item.subTitle;
    
    if ([item isKindOfClass:[TFCommonLabelItem class]]) {
        
        TFCommonLabelItem *labelItem = (TFCommonLabelItem *)item;
        self.rightLabel.text = labelItem.text;
        self.rightLabel.xtf_size = [labelItem.text sizeWithFont:self.rightLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        self.accessoryView = self.rightLabel;
        
    } else {
        self.accessoryView = self.rightArrow;
    }
}
@end
