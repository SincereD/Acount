//
//  UIView+DSCapture.h
//  DSCommon
//
//  Created by Sincere on 16/3/11.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (DSCapture)

/**
 *  截取UIView完整图片
 *
 *  @return 图片返回值
 */
- (UIImage*)capture;

/**
 *  截取UIView对应区域图片
 *
 *  @param rect 图片位置
 *
 *  @return 图片返回值
 */
- (UIImage*)captureWithRect:(CGRect)rect;
@end
