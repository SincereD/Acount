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
 *  获取年月周
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

@end
