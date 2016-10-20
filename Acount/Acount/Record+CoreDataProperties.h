//
//  Record+CoreDataProperties.h
//  Acount
//
//  Created by Sincere on 16/6/15.
//  Copyright © 2016年 Sincere. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Record.h"

NS_ASSUME_NONNULL_BEGIN

@interface Record (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *recordNum;
@property (nullable, nonatomic, retain) NSDate   *recordDate;
@property (nullable, nonatomic, retain) NSString *recordType;
@property (nullable, nonatomic, retain) NSString *year;
@property (nullable, nonatomic, retain) NSString *month;
@property (nullable, nonatomic, retain) NSString *day;
@property (nullable, nonatomic, retain) NSString *week;//week of month
@property (nullable, nonatomic, retain) NSString *detail;

@end

NS_ASSUME_NONNULL_END
