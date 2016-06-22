//
//  RecordTableViewCell.m
//  Acount
//
//  Created by Sincere on 16/6/17.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import "RecordTableViewCell.h"

@implementation RecordTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [_typeLabel.layer setCornerRadius:20.0f];
    [_typeLabel.layer setMasksToBounds:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)setRecord:(Record *)record
{
    _record =record;
    
    if (_type == RecordTypeDay)
    {
        _todayLabel.text = [record.recordDate  getHourMinuteString];
        _dateLabel.hidden = YES;
        _timeLabel.hidden = YES;
    }
    else if (_type == RecordTypeWeek)
    {
        _dateLabel.text = [record.recordDate getWeekDayWithContrastion];
        _timeLabel.text = [record.recordDate getHourMinuteString];
        _todayLabel.hidden = YES;
    }
    else if (_type == RecordTypeMonth)
    {
        _dateLabel.text = [record.recordDate getMonthDayStringWithContrastion];
        _timeLabel.text = [record.recordDate getWeekDay];
        _todayLabel.hidden = YES;
    }
    else
    {
        _dateLabel.text = [record.recordDate getHourMinuteString];
        _timeLabel.text = [record.recordDate getMonthDayString];
        _todayLabel.hidden = YES;
    }
    
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
