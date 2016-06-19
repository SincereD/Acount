//
//  DSBaseViewController.m
//  DSCommon
//
//  Created by Sincere on 16/3/11.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import "DSBaseViewController.h"

@implementation DSBaseViewController

- (UIBarButtonItem*)rightBarButtonItem
{
    return self.navigationController.navigationItem.rightBarButtonItem;
}

- (UIBarButtonItem*)leftBarButtonItem
{
    return self.navigationController.navigationItem.leftBarButtonItem;
}

- (UITabBar*)tabBar
{
    return self.tabBarController.tabBar;
}

- (void)setBaseRightBarButtonItem:(UIBarButtonItem*)item
{
    [self.navigationItem setRightBarButtonItem:item];
}

- (void)setBaseLeftBarButtonItem:(UIBarButtonItem*)item
{
    [self.navigationItem setLeftBarButtonItem:item];
}

@end
