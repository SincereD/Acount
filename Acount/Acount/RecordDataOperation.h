//
//  RecordDataOperation.h
//  Acount
//
//  Created by Sincere on 16/6/16.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecordDataOperation : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

/**
 *  数据处理单例
 *
 *  @return Instance
 */
+ (instancetype)sharedDataOperation;

/**
 *  插入数据
 *
 *  @param record Record
 */
- (BOOL)insertCoreDataWithRecord:(NSManagedObject*)record;

/**
 *  删除数据
 *
 *  @param record Record
 *
 *  @return BOOL
 */
- (BOOL)deleteCoreDataWithRecord:(NSManagedObject*)record;

/**
 *  获取全部数据
 *
 *  @return NSArray
 */
- (NSArray*)getTotalDataSource;

/**
 *  获取年份数据
 *
 *  @param year 年
 *
 *  @return NSArray
 */
- (NSArray*)getYearDataSourceWithYear:(NSString*)year;

/**
 *  根据年份数据获取对应的月份数据
 *
 *  @param year     年份
 *  @param month    月份
 *
 *  @return NSArray
 */
- (NSArray*)getMonthDataSourceWithYear:(NSString*)year
                                 month:(NSString*)month;

/**
 *  获取月份当周数据
 *
 *  @param year  年
 *  @param month 月
 *  @param week  周
 *
 *  @return NSArray
 */
- (NSArray*)getWeekDataSourceWithYear:(NSString*)year
                                month:(NSString*)month
                                 week:(NSString*)week;

/**
 *  对周数据按天进行划分
 *
 *  @param weekData 周数据
 *
 *  @return NSArray    
 *  JSON:[[],[],[]]; 
 */
- (NSArray*)seprateWeekDataToDay:(NSArray*)weekData;


/**
 *  对没有数据划分到天 （这里方法名写错了）
 *
 *  @param monthData 月数据
 *
 *  @return NSArray
 */
- (NSArray*)seprateMonthDataToWeek:(NSArray*)monthData;

/**
 *  获取今天数据
 *
 *  @return NSArray
 */
- (NSArray*)getTotadyData;


@end
