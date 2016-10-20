//
//  Baby_Animation.h
//  BabyT
//
//  Created by Sincere on 16/4/23.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DSAnimation : NSObject<UIViewControllerAnimatedTransitioning>

/**
 *  动画执行时间(默认值为0.5s)
 */
@property (nonatomic) NSTimeInterval  transitionDuration;

/**
 *  自定义动画效果重写此方法实现动画效果
 *
 *  动画事件
 */
- (void)animateTransitionEvent;

/**
 *  需要调用animateTransitionEvent方法
 *
 *  起点控制器
 */
@property (nonatomic, readonly, weak) UIViewController *fromViewController;
/**
 *  需要调用animateTransitionEvent方法
 *
 *  终点控制器
 */
@property (nonatomic, readonly, weak) UIViewController *toViewController;

/**
 *  需要调用animateTransitionEvent方法
 *
 *  containerView
 */
@property (nonatomic, readonly, weak) UIView           *containerView;

/**
 *  动画事件结束
 */
- (void)completeTransition;

@end
