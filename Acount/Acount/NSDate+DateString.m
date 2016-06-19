//
//  NSDate+DateString.m
//  Acount
//
//  Created by Sincere on 16/6/17.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import "NSDate+DateString.h"

@implementation NSDate (DateString)

- (NSDictionary*)getMonthYearDay
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents * dd = [cal components:unitFlags fromDate:self];
    NSString * year = [NSString stringWithFormat:@"%d",(int)[dd year]];
    NSString * month = [NSString stringWithFormat:@"%d",(int)[dd month]];
    NSString * day = [NSString stringWithFormat:@"%d",(int)[dd day]];
    return @{@"year":year,@"month":month,@"day":day};
}

- (NSDictionary*)getMonthYearWeek
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfMonth | NSCalendarUnitYear;
    NSDateComponents * dd = [cal components:unitFlags fromDate:self];
    NSString * year = [NSString stringWithFormat:@"%d",(int)[dd year]];
    NSString * month = [NSString stringWithFormat:@"%d",(int)[dd month]];
    NSString * week = [NSString stringWithFormat:@"%d",(int)[dd weekOfMonth]];
    return @{@"year":year,@"month":month,@"week":week};
}

- (NSString*)getHourMinuteString
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents * dd = [cal components:unitFlags fromDate:self];
    NSInteger hour = [dd hour];
    NSInteger minute = [dd minute];
    NSString * dateString = [NSString stringWithFormat:@"%02d:%02d",(int)hour,(int)minute];
    return dateString;
}

- (NSString*)getMonthDayString
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents * dd = [cal components:unitFlags fromDate:self];
    NSInteger month = [dd month];
    NSInteger day = [dd day];
    NSString * dateString = [NSString stringWithFormat:@"%02d-%02d",(int)month,(int)day];
    return dateString;
}

@end
