//
//  RecordTableViewCell.h
//  Acount
//
//  Created by Sincere on 16/6/17.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordTableViewCell : UITableViewCell

typedef NS_ENUM(NSInteger, RecordType) {
    RecordTypeDay = 0,//默认从0开始
    RecordTypeWeek = 1,
    RecordTypeMonth = 2,
};

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *todayLabel;

@property (nonatomic,retain) Record * record;
@property (nonatomic,assign) RecordType type;

@end
