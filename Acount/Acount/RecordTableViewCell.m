//
//  RecordTableViewCell.m
//  Acount
//
//  Created by Sincere on 16/6/17.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import "RecordTableViewCell.h"

@implementation RecordTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [_typeLabel.layer setCornerRadius:20.0f];
    [_typeLabel.layer setMasksToBounds:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setRecord:(Record *)record
{
    _record =record;
    
    _dateLabel.text = [record.recordDate getHourMinuteString];
    _timeLabel.text = [record.recordDate getMonthDayString];
    
    _numberLabel.text = [NSString stringWithFormat:@"%.2f",[record.recordNum floatValue]];
    _detailLabel.text = record.detail;
    
    if ([record.recordType isEqualToString:@"收入"])
    {
        [_typeLabel setText:@"收"];
        [_typeLabel setBackgroundColor:[UIColor greenColor]];
    }
    else if ([record.recordType isEqualToString:@"支出"])
    {
        [_typeLabel setText:@"支"];
        [_typeLabel setBackgroundColor:[UIColor redColor]];
    }
}

@end
