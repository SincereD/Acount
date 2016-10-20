//
//  UIScreen+DSScreenSize.m
//  DSCommon
//
//  Created by Sincere on 16/3/11.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import "UIScreen+DSScreenSize.h"

@implementation UIScreen (DSScreenSize)

+ (CGFloat)screenWidth
{
    return [self mainScreen].bounds.size.width;
}

+ (CGFloat)screenHeight
{
    return [self mainScreen].bounds.size.height;
}

@end
