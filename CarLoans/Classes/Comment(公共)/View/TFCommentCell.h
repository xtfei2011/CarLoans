//
//  TFCommentCell.h
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/10.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TFCommentItem;
@interface TFCommentCell : UITableViewCell

@property (nonatomic ,strong) TFCommentItem *item;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void)setIndexPath:(NSIndexPath *)indexPath rowsInSection:(int)rows;
@end
