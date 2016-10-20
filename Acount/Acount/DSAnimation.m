//
//  Baby_Animation.m
//  BabyT
//
//  Created by Sincere on 16/4/23.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import "DSAnimation.h"

@interface DSAnimation ()

@property (nonatomic, weak) id <UIViewControllerContextTransitioning>  transitionContext;
@property (nonatomic, weak) UIViewController  *fromViewController;
@property (nonatomic, weak) UIViewController  *toViewController;
@property (nonatomic, weak) UIView            *containerView;
@end


@implementation DSAnimation

#pragma mark - 初始化
- (instancetype)init
{
    if (self = [super init])
    {
        [self deafultSet];
    }
    return self;
}
- (void)deafultSet
{
    
    _transitionDuration = 0.5f;
}

#pragma mark - 动画代理

- (NSTimeInterval)transitionDuration:(id )transitionContext
{
    return _transitionDuration;
}

- (void)animateTransition:(id )transitionContext
{
    self.fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    self.toViewController   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    self.containerView      = [transitionContext containerView];
    self.transitionContext  = transitionContext;
    
    [self animateTransitionEvent];
}

- (void)animateTransitionEvent
{
    [self.containerView addSubview:self.toViewController.view];
    
    self.toViewController.view.transform = CGAffineTransformIdentity;
    self.fromViewController.view.transform = CGAffineTransformIdentity;
    self.toViewController.view.transform = CGAffineTransformScale(self.toViewController.view.transform, 0.5, 0.5);
    
    [UIView animateWithDuration:self.transitionDuration
                          delay:0.0f
         usingSpringWithDamping:1 initialSpringVelocity:0.f options:0 animations:^{
             
             self.toViewController.view.transform = CGAffineTransformScale(self.toViewController.view.transform, 2.0f, 2.0f);
             
         } completion:^(BOOL finished) {
             [self completeTransition];
         }];
}

- (void)completeTransition
{
    [self.transitionContext completeTransition:!self.transitionContext.transitionWasCancelled];
}

@end
