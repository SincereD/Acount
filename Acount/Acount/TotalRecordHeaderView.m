//
//  TotalRecordHeaderView.m
//  Acount
//
//  Created by Sincere on 16/7/12.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import "TotalRecordHeaderView.h"

@interface TotalRecordHeaderView ()
{
    UILabel * _mainTitle;
    UILabel * _subTitle;
    UIView  * _lineView;
}

@end

@implementation TotalRecordHeaderView

- (instancetype)initWithRecord:(Record*)record
{
    if (self = [super init])
    {
        [self initSelf];
        [self mainTitle];
        [self subTitle];
        [self lineView];
    }
    return self;
}

- (void)initSelf
{
    [self setBackgroundColor:[UIColor whiteColor]];
    [self setFrame:CGRectMake(0, 0, kScreenWidth-40, 115)];
}

- (void)mainTitle
{
    _mainTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, CGRectGetWidth(self.frame), 40)];
    [_mainTitle setText:@"MainTitle"];
    [_mainTitle setTextColor:[UIColor colorWithHexString:@"333333"]];
    [_mainTitle setFont:[UIFont systemFontOfSize:25.0f]];
    [_mainTitle setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_mainTitle];
}

- (void)subTitle
{
    _subTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, CGRectGetWidth(self.frame), 20)];
    [_subTitle setText:@"SubTitle"];
    [_subTitle setTextColor:[UIColor grayColor]];
    [_subTitle setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_subTitle];
}

- (void)lineView
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.bounds];
    [shapeLayer setPosition:self.center];
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    [shapeLayer setStrokeColor:[[UIColor blackColor] CGColor]];
    [shapeLayer setLineWidth:1.0f];
    [shapeLayer setLineJoin:kCALineJoinRound];
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:@3,@1,nil]];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 36, 95);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(self.frame)-36,95);
    [shapeLayer setPath:path]; 
    CGPathRelease(path);
    [self.layer addSublayer:shapeLayer];
    
    UIView * leftRoundView = [[UIView alloc] initWithFrame:CGRectMake(-18, 79, 36, 36)];
    [leftRoundView.layer setCornerRadius:18.0f];
    [leftRoundView setBackgroundColor:RGB(27, 27, 26)];
    [leftRoundView.layer setMasksToBounds:YES];
    [self addSubview:leftRoundView];
    
    UIView * rightRoundView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.frame)-18, 79, 36, 36)];
    [rightRoundView setBackgroundColor:RGB(27, 27, 26)];
    [rightRoundView.layer setCornerRadius:18.0f];
    [rightRoundView.layer setMasksToBounds:YES];
    [self addSubview:rightRoundView];
}



@end
