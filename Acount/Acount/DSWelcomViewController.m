//
//  DSWelcomViewController.m
//  Designer
//
//  Created by Sincere on 16/4/27.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import "DSWelcomViewController.h"
//#import "MainViewController.h"

@interface DSWelcomViewController ()

@end

@implementation DSWelcomViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initSences];
}

- (void)initSences
{
    UIButton * skipBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [skipBtn setFrame:CGRectMake(kScreenWidth - 60, 64, 40, 40)];
    [skipBtn addTarget:self action:@selector(skip) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:skipBtn];
}

- (void)skip
{
//    MainViewController * mainVC = [[MainViewController alloc] init];
//    [self.navigationController pushViewController:mainVC animated:YES];
}

@end
