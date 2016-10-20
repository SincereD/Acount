//
//  RecordView.m
//  Acount
//
//  Created by Sincere on 16/7/12.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import "RecordView.h"

@interface RecordView ()
{
    Record  * _record;
    UILabel * _timeLab;
    UILabel * _detailLab;
    UILabel * _priceLab;
}
@end

@implementation RecordView

- (instancetype)initWithRecord:(Record*)record
                         width:(CGFloat)width
{
    if (self = [super init])
    {
        _record = record;
        [self initSelfWithWidth:width];
        [self time];
        [self price];
        [self detail];
    }
    return self;
}

- (void)reloadRecord:(Record*)record
{
    _record = record;
    [_timeLab setText:[_record.recordDate getHourMinuteString]];
    [_detailLab setText:_record.detail];
    [_priceLab setText:[NSString stringWithFormat:@"%.2f",[_record.recordNum floatValue]]];
    if ([_record.recordType isEqualToString:@"收入"])
    {
        [_priceLab setTextColor:[UIColor colorWithHexString:@"7ed321"]];
    }
    else
    {
        [_priceLab setTextColor:[UIColor colorWithHexString:@"ce3330"]];
    }
}


- (void)initSelfWithWidth:(CGFloat)width
{
    [self setFrame:CGRectMake(0, 0, width, 25)];
}

- (void)recordRegulate
{
    [_timeLab setFrame:CGRectMake(36, 0, 50, 25)];
    [_detailLab setFrame:CGRectMake(92, 0, CGRectGetWidth(self.frame)-180, 25)];
    [_priceLab setFrame:CGRectMake(CGRectGetWidth(self.frame)- 116, 0, 80, 25)];
}

- (void)time
{
    _timeLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 50, 25)];
    [_timeLab setTextColor:[UIColor grayColor]];
    [_timeLab setText:[_record.recordDate getHourMinuteString]];
    [self addSubview:_timeLab];
}

- (void)detail
{
    _detailLab = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, CGRectGetWidth(self.frame)-150, 25)];
    [_detailLab setText:_record.detail];
    [_detailLab setTextColor:[UIColor colorWithHexString:@"333333"]];
    [self addSubview:_detailLab];
}

- (void)price
{
    _priceLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame)- 100, 0, 80, 25)];
    [_priceLab setText:[NSString stringWithFormat:@"%.2f",[_record.recordNum floatValue]]];
    [_priceLab setTextAlignment:NSTextAlignmentRight];
    [self addSubview:_priceLab];
    
    if ([_record.recordType isEqualToString:@"收入"])
    {
        [_priceLab setTextColor:[UIColor colorWithHexString:@"7ed321"]];
    }
    else
    {
        [_priceLab setTextColor:[UIColor colorWithHexString:@"ce3330"]];
    }
}

@end
