//
//  DSBaseViewController.h
//  DSCommon
//
//  Created by Sincere on 16/3/11.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  ViewController基类
 */
@interface DSBaseViewController : UIViewController

- (UIBarButtonItem*)rightBarButtonItem;

- (UIBarButtonItem*)leftBarButtonItem;

- (UITabBar*)tabBar;

- (void)setBaseRightBarButtonItem:(UIBarButtonItem*)item;

- (void)setBaseLeftBarButtonItem:(UIBarButtonItem*)item;


@end
