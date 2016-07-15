//
//  NSDate+DateString.h
//  Acount
//
//  Created by Sincere on 16/6/17.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (DateString)

/**
 *  获取年月日
 *
 *  @return NSDictionary
 */
- (NSDictionary*)getMonthYearWeek;

/**
 *  获取年月日期
 *
 *  @return NSDictionary
 */
- (NSDictionary*)getMonthYearDay;

/**
 *  获取周几
 *
 *  @return NSString
 */
- (NSString*)getWeekDay;

/**
 *  获取今天是周几 如果是今天则返回今天
 *
 *  @return NSString
 */
- (NSString*)getWeekDayWithContrastion;

/**
 *  获取 小时:分钟
 *
 *  @return NSString
 */
- (NSString*)getHourMinuteString;

/**
 *  获取 月份:日期
 *
 *  @return NSString
 */
- (NSString*)getMonthDayString;

/**
 *  获取 月份:日期 如果是今天则返回今天
 *
 *  @return NSString
 */
- (NSString*)getMonthDayStringWithContrastion;

/**
 *  获取是第几周
 *
 *  @return NSString
 */
- (NSString*)getWeekdayOrdinal;

/**
 *  获取范围字符串 如 2016/01/12/ - 02/20
 *
 *  @param newlyDate 截止日期
 *  @param olderDate 起始日期
 *
 *  @return NSString
 */
- (NSString*)getRangeStringWithDate:(NSDate*)newlyDate
                               date:(NSDate*)olderDate;

@end
