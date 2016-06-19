//
//  UIColor+DSHexColor.h
//  DSCommon
//
//  Created by Sincere on 16/3/11.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  UnSafe 方法，需要填写完整的16进制颜色信息<6位英文字母、数字>
 */
@interface UIColor (DSHexColor)
/**
 *  16进制色值
 *
 *  @param hexString 色值参数
 *
 *  @return 颜色返回值
 */
- (UIColor*)colorWithHexString:(NSString*)hexString;

/**
 *  16进制色值
 *
 *  @param hexString 色值参数
 *  @param alpha     透明度参数
 *
 *  @return 颜色返回值
 */
- (UIColor*)colorWithHexString:(NSString*)hexString alpha:(CGFloat)alpha;

/**
 *  获取颜色的透明度
 *
 *  @param color UIColor
 *
 *  @return Alpha
 */
- (CGFloat)alphaForColor;

/**
 *  判断颜色的深浅度
 *
 *  @param newColor UIColor
 *
 *  @return YES->深色 NO->浅色
 */
- (BOOL)isDarkColor;

@end
