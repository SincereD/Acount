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

- (NSString*)getWeekDay
{
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    unsigned int unitFlags = NSCalendarUnitWeekday;
    NSDateComponents * dd = [cal components:unitFlags fromDate:self];
    NSInteger weekDay = [dd weekday];
    return [self getWeekDayStringWithInterger:weekDay];
}

- (NSString*)getWeekDayWithContrastion
{
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    unsigned int unitFlags = NSCalendarUnitWeekday;
    NSDateComponents * dd = [cal components:unitFlags fromDate:self];
    NSInteger weekDay = [dd weekday];
    NSString * weekDayStr = [self getWeekDayStringWithInterger:weekDay];
    if ([[self getMonthDayStringWithContrastion] isEqualToString:@"今天"])
    {
        return @"今天";
    }
    return weekDayStr;
}

- (NSString*)getWeekDayStringWithInterger:(NSInteger)interger
{
    NSArray * weekDayArray = @[[NSNull null],@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    return weekDayArray[interger];
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

- (NSString*)getMonthDayStringWithContrastion
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents * dd = [cal components:unitFlags fromDate:self];
    NSInteger month = [dd month];
    NSInteger day = [dd day];
    NSString * dateString = [NSString stringWithFormat:@"%02d-%02d",(int)month,(int)day];
    if ([dateString isEqualToString:[[NSDate date] getMonthDayString]])
    {
        dateString = @"今天";
    }
    return dateString;
}

/**
 *  获取是第几周
 *
 *  @return NSString
 */
- (NSString*)getWeekdayOrdinal
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitMonth | NSCalendarUnitDay | kCFCalendarUnitWeekOfYear;
    NSDateComponents * dd = [cal components:unitFlags fromDate:self];
    NSInteger ordinal = [dd weekOfYear];
    NSString * dateString = [NSString stringWithFormat:@"%d",(int)ordinal];
    return dateString;
}

/**
 *  获取范围字符串 如 2016/01/12/ - 02/20
 *
 *  @param newlyDate 截止日期
 *  @param olderDate 起始日期
 *
 *  @return NSString
 */
- (NSString*)getRangeStringWithDate:(NSDate*)newlyDate
                               date:(NSDate*)olderDate
{
    NSDictionary * olderDict = [olderDate getMonthYearDay];
    NSDictionary * newlyDict = [newlyDate getMonthYearDay];
    NSString * result = [NSString stringWithFormat:@"%@/%@/%@ - %@/%@",olderDict[@"year"],olderDict[@"month"],olderDict[@"day"],newlyDict[@"month"],newlyDict[@"day"]];
    return result;
}

@end
