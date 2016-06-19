//
//  RecordDataOperation.m
//  Acount
//
//  Created by Sincere on 16/6/16.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import "RecordDataOperation.h"

@interface RecordDataOperation ()<NSCopying,NSMutableCopying>

@end

@implementation RecordDataOperation

static RecordDataOperation * dataOperation;

+ (instancetype)sharedDataOperation
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!dataOperation) {
            dataOperation = [[self alloc] init];
        }
    });
    return dataOperation;
}

- (id)copyWithZone:(nullable NSZone *)zone
{
    return [RecordDataOperation sharedDataOperation] ;
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    return [RecordDataOperation sharedDataOperation] ;
}

#pragma mark - Core Data stack

- (BOOL)insertCoreDataWithRecord:(NSManagedObject*)record;
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSError *error;
    if(![context save:&error])
    {
        NSLog(@"不能保存：%@",[error localizedDescription]);
        return NO;
    }else
    {
        NSLog(@"保存成功");
        return YES;
    }
}

- (BOOL)deleteCoreDataWithRecord:(NSManagedObject*)record
{
    NSManagedObjectContext *context = [self managedObjectContext];
    [context deleteObject:record];
    NSError *error;
    if(![context save:&error])
    {
        NSLog(@"不能保存：%@",[error localizedDescription]);
        return NO;
    }else
    {
        NSLog(@"保存成功");
        return YES;
    }
}

- (NSArray*)dataFetchRequest
{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"recordDate" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor,nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Record" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    return fetchedObjects;
}

/**
 *  获取全部数据
 *
 *  @return NSArray
 */
- (NSArray*)getTotalDataSource
{
    return [self dataFetchRequest];
}

/**
 *  获取年份数据
 *
 *  @param year 年
 *
 *  @return NSArray
 */
- (NSArray*)getYearDataSourceWithYear:(NSString*)year
{
    NSPredicate * yearPredicate = [NSPredicate predicateWithBlock:^BOOL(id  _Nonnull evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [[evaluatedObject valueForKey:@"year"] isEqualToString:year];
    }];
    NSArray * data = [self getTotalDataSource];
    NSArray * needData = [data filteredArrayUsingPredicate:yearPredicate];
    return needData;
}

/**
 *  根据年份数据获取对应的月份数据
 *
 *  @param year     年份
 *  @param month    月份
 *
 *  @return NSArray
 */
- (NSArray*)getMonthDataSourceWithYear:(NSString*)year
                                 month:(NSString*)month
{
    NSPredicate * yearPredicate = [NSPredicate predicateWithBlock:^BOOL(id  _Nonnull evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [[evaluatedObject valueForKey:@"year"] isEqualToString:year] && [[evaluatedObject valueForKey:@"month"] isEqualToString:month];
    }];
    NSArray * data = [self getTotalDataSource];
    NSArray * needData = [data filteredArrayUsingPredicate:yearPredicate];
    return needData;
}

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
                                 week:(NSString*)week
{
    NSPredicate * yearPredicate = [NSPredicate predicateWithBlock:^BOOL(id  _Nonnull evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [[evaluatedObject valueForKey:@"year"] isEqualToString:year] && [[evaluatedObject valueForKey:@"month"] isEqualToString:month] && [[evaluatedObject valueForKey:@"week"] isEqualToString:week];
    }];
    NSArray * data = [self getTotalDataSource];
    NSArray * needData = [data filteredArrayUsingPredicate:yearPredicate];
    return needData;
}

/**
 *  获取今天数据
 *
 *  @return NSArray
 */
- (NSArray*)getTotadyData
{
    NSDate * date = [NSDate date];
    NSDictionary * dayDict = [date getMonthYearDay];
    NSString * year = dayDict[@"year"];
    NSString * month = dayDict[@"month"];
    NSString * day = dayDict[@"day"];
    NSPredicate * yearPredicate = [NSPredicate predicateWithBlock:^BOOL(id  _Nonnull evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [[evaluatedObject valueForKey:@"year"] isEqualToString:year] && [[evaluatedObject valueForKey:@"month"] isEqualToString:month] && [[evaluatedObject valueForKey:@"day"] isEqualToString:day];
    }];
    NSArray * data = [self getTotalDataSource];
    NSArray * needData = [data filteredArrayUsingPredicate:yearPredicate];
    return needData;
}

- (NSArray*)getDataSourceWithPredicate:(NSPredicate*)predicate
{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"recordDate" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor,nil];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setSortDescriptors:sortDescriptors];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Record" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    return fetchedObjects;
}

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Acount" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Acount.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil)
    {
        return _managedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator)
    {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            
            abort();
        }
    }
}

@end
