//
//  TotalRecordViewController.m
//  Acount
//
//  Created by Sincere on 16/6/21.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import "TotalRecordViewController.h"
#import "Record.h"

@interface TotalRecordViewController ()
{
    CGFloat    _inCome;
    CGFloat    _outCome;
    CGFloat    _total;
    NSInteger  _inComeCount;
    NSInteger  _outComeCount;
    NSArray  * _titleSource;
    NSArray  * _dataSource;
    NSArray  * _colorSource;
}
@end

@implementation TotalRecordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self configureNum];
    [self calculate];
    [UIApplication sharedApplication].applicationSupportsShakeToEdit = YES;
    [self becomeFirstResponder];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self configureView];
}

- (void)configureNum
{
    _inCome = 0.0f;
    _outCome = 0.0f;
    _inComeCount = 0;
    _outComeCount = 0;
    _titleSource = @[@"收入",@"支出",@"收入次数",@"支出次数",@"总计"];
}

- (void)calculate
{
    for (NSArray * sepratedArray in _recordArray)
    {
        for (Record * r in sepratedArray)
        {
            if ([r.recordType isEqualToString:@"收入"])
            {
                _inComeCount ++;
                _inCome += [r.recordNum floatValue];
            }
            else if ([r.recordType isEqualToString:@"支出"])
            {
                _outComeCount ++;
                _outCome += [r.recordNum floatValue];
            }
        }
    }
    _total = _inCome + _outCome;
    NSNumber * incomeNum = [NSNumber numberWithFloat:_inCome];
    NSNumber * outcomeNum = [NSNumber numberWithFloat:_outCome];
    NSNumber * incomeCount = [NSNumber numberWithInteger:_inComeCount];
    NSNumber * outcomeCount = [NSNumber numberWithInteger:_outComeCount];
    NSNumber * totalNum = [NSNumber numberWithFloat:_total];

    _dataSource = @[incomeNum,outcomeNum,incomeCount,outcomeCount,totalNum];
}

- (void)configureView
{
    for (int i = 0; i<5; i++)
    {
        NSString * count = @"";
        if (i == 2 || i ==3)
        {
            count = [NSString stringWithFormat:@"%d",[_dataSource[i] intValue]];
        }
        else
        {
            count = [NSString stringWithFormat:@"%.2f",[_dataSource[i] floatValue]];
        }
        NSString * title = [NSString stringWithFormat:@"%@\n%@",_titleSource[i],count];

        
        CGFloat x = 0;
        CGFloat y = 0;
        if (i == 0 || i == 2)
        {
            x = -1;
        }
        else if (i == 1 || i == 3)
        {
            x = 1;
        }
        else
        {
            x = 0;
        }
        
        if (i == 0 || i == 1)
        {
            y = -1;
        }
        else if (i == 2 || i == 3)
        {
            y = 1;
        }
        else
        {
            y = 0;
        }
        
        CGPoint aPoint = CGPointMake(kScreenWidth/2.0f + x * kScreenWidth/4.0f, kScreenHeight/2.0f + y * kScreenWidth/4.0f);
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/3.2f, kScreenWidth/3.2f)];
        [label setText:title];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setTextColor:[UIColor blackColor]];
        [label.layer setCornerRadius:kScreenWidth/6.4f];
        [label.layer setMasksToBounds:YES];
        [label setNumberOfLines:0];
        [label setBackgroundColor:[UIColor whiteColor]];
        [label setCenter:CGPointMake(kScreenWidth/2.0f, kScreenHeight/2.0f)];
        [self.view addSubview:label];
        
        [UIView animateWithDuration:0.80f delay:i * 0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [label setCenter:aPoint];
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (event.subtype == UIEventSubtypeMotionShake)
    {
        NSInteger i = -1;
        for (UIView * view in [self.view subviews])
        {
            if ([view isKindOfClass:[UILabel class]])
            {
                i++;
                
                [UIView animateWithDuration:0.80f delay:i*0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    [view setCenter:CGPointMake(kScreenWidth/2.0f, kScreenHeight/2.0f)];
                } completion:^(BOOL finished) {
                
                }];
            }
        }
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    });
}

- (void)dismissAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSInteger i = -1;
    for (UIView * view in [self.view subviews])
    {
        if ([view isKindOfClass:[UILabel class]])
        {
            i++;
            [UIView animateWithDuration:0.80f delay:i*0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [view setCenter:CGPointMake(kScreenWidth/2.0f, kScreenHeight/2.0f)];
            } completion:^(BOOL finished) {
                
            }];
        }
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    });
}
@end
