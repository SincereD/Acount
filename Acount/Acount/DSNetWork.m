//
//  NetWork.m
//  Designer
//
//  Created by Sincere on 16/4/27.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import "DSNetWork.h"

#import <AFNetworking.h>

@interface DSNetWork ()<NSCopying,NSMutableCopying>

@property (nonatomic,strong) AFNetworkReachabilityManager * reachManager;
@property (nonatomic,assign) BOOL netStatus;

@end

@implementation DSNetWork

# pragma mark - 单例方法

static DSNetWork * _netWork;

+ (instancetype)sharedNetWork
{
    if (!_netWork)
    {
        static dispatch_once_t onceToken ;
        dispatch_once(&onceToken, ^{
            _netWork = [[self alloc] init] ;
        }) ;
    }
    return _netWork;
}

- (id)copyWithZone:(nullable NSZone *)zone
{
    return [DSNetWork sharedNetWork] ;
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    return [DSNetWork sharedNetWork] ;
}

# pragma mark - 监听网络状态

- (void)configureReachManager
{
    self.reachManager = [AFNetworkReachabilityManager managerForDomain:@"www.baidu.com"];
    [self.reachManager startMonitoring];
    __weak DSNetWork * weakSelf = _netWork;
    [self.reachManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        weakSelf.netStatus = status==AFNetworkReachabilityStatusNotReachable?NO:YES;
    }];
}

- (BOOL)reachEnable
{
    return self.netStatus;
}


@end
