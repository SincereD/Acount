//
//  UIScreen+DSScreenSize.h
//  DSCommon
//
//  Created by Sincere on 16/3/11.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import <UIKit/UIKit.h>

# define kScreenWidth  [UIScreen screenWidth]
# define kScreenHeight [UIScreen screenHeight]
# define kTabBarHeight 49.0f
# define kNavBarHeight 64.0f
# define kStatusBarHeight 20.0f

@interface UIScreen (DSScreenSize)

+ (CGFloat)screenWidth;

+ (CGFloat)screenHeight;

@end
