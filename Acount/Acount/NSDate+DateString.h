//
//  NSDate+DateString.h
//  Acount
//
//  Created by Sincere on 16/6/17.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (DateString)

- (NSDictionary*)getMonthYearWeek;

- (NSDictionary*)getMonthYearDay;

- (NSString*)getHourMinuteString;

- (NSString*)getMonthDayString;

- (NSString*)getMonthDayStringWithContrastion;

@end
