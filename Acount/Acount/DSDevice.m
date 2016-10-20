//
//  DSDevice.m
//  DSCommon
//
//  Created by Sincere on 16/3/15.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import "DSDevice.h"

@implementation DSDevice

- (NSDictionary*)deviceInfo
{
    return [[NSBundle mainBundle] infoDictionary];
}

- (NSString*)appVersion
{
    return [[self deviceInfo] objectForKey:@"CFBundleShortVersionString"];
}

- (NSString*)appName
{
    return [[self deviceInfo] objectForKey:@"CFBundleDisplayName"];
}

@end
