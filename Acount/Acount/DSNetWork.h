//
//  NetWork.h
//  Designer
//
//  Created by Sincere on 16/4/27.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSNetWork : NSObject

+ (instancetype)sharedNetWork;

- (void)configureReachManager;

- (BOOL)reachEnable;

@end
