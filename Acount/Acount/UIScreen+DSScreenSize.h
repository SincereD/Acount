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

@interface UIScreen (DSScreenSize)

+ (CGFloat)screenWidth;

+ (CGFloat)screenHeight;

@end
