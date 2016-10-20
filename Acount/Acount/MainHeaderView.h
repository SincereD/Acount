//
//  MainHeaderView.h
//  Acount
//
//  Created by Sincere on 16/7/12.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainHeaderView : UIView

/**
 *  初始化
 *
 *  @param num 金额
 *
 *  @return Instance
 */
- (instancetype)initWithNum:(NSString*)num;

/**
 *  更新金额
 *
 *  @param num 金额
 */
- (void)updateNum:(NSString*)num;

@end
