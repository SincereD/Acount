//
//  RecordView.h
//  Acount
//
//  Created by Sincere on 16/7/12.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Record.h"

@interface RecordView : UIView

- (instancetype)initWithRecord:(Record*)record
                         width:(CGFloat)width;

- (void)reloadRecord:(Record*)record;

- (void)recordRegulate;

@end
