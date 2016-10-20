

//
//  MainHeaderView.m
//  Acount
//
//  Created by Sincere on 16/7/12.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import "MainHeaderView.h"
//#import "UILabel+BezierAnimation.h"

@interface MainHeaderView ()
{
    CGFloat   _height;
    CGFloat   _3rdHeight;
    CGFloat   _indexWidth;
    UILabel * _priceLab;
    UILabel * _subTitle;
    UIView  * _lineView;
    
    CGFloat  _currentNum;
    CGFloat  _targetNum;
}

@end

@implementation MainHeaderView

/**
 *  初始化
 *
 *  @param num 金额
 *
 *  @return Instance
 */
- (instancetype)initWithNum:(NSString*)num;
{
    if (self = [super init])
    {
        [self initSelf];
        [self priceLabWithNum:num];
        [self subTitle];
        [self lineView];
    }
    return self;
}

/**
 *  更新金额
 *
 *  @param num 金额
 */
- (void)updateNum:(NSString*)num
{
    _targetNum = [num floatValue];
    [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
}

- (void)timerFireMethod:(NSTimer *)theTimerP
{
    
    CGFloat index = 1.0f;
    if (_currentNum > _targetNum)
    {
        index = - 1.0f;
    }

    if (fabs(_currentNum - _targetNum)>0.001)
    {
        if (fabs(_currentNum - _targetNum)>5000)
        {
            _currentNum += 1000 * index;
        }
        else if (fabs(_currentNum - _targetNum)>1000)
        {
            _currentNum += 100 * index;
        }
        else if (fabs(_currentNum - _targetNum)>100)
        {
            _currentNum += 10 * index;
        }
        else if (fabs(_currentNum - _targetNum)>10)
        {
            _currentNum += 1 * index;
        }
        else
        {
            _currentNum += 0.1 * index;
        }
        _priceLab.text = [NSString stringWithFormat:@"%.2f",_currentNum];
    }else
    {
        _priceLab.text = [NSString stringWithFormat:@"%.2f",_targetNum];
        [theTimerP invalidate];
    }
}

- (CGFloat)calugateIndexWithCurrentNum:(CGFloat)currentNum
                             targetNum:(CGFloat)targetNum
{
    CGFloat index = fabs(currentNum - targetNum);
    if (index>500)
    {
        return 100;
    }
    else if(index>200)
    {
        return 10;
    }
    else{
        return 1;
    }
}

- (void)initSelf
{
    _currentNum = -1.00f;
    _targetNum = 0.00f;
    _height = 180.0f;
    _3rdHeight = _height/3.0f;
    _indexWidth = 20.0f;
    [self setFrame:CGRectMake(0, 0, kScreenWidth, _height)];

}

- (void)priceLabWithNum:(NSString*)num
{
    _priceLab = [[UILabel alloc] initWithFrame:CGRectMake(0, _3rdHeight/3*2, kScreenWidth, _3rdHeight)];
    [_priceLab setTextAlignment:NSTextAlignmentCenter];
    [_priceLab setText:num?num:@"0.00"];
    [_priceLab setFont:[UIFont fontWithName:@"STHeitiSC-Light" size:50.0f]];
    [_priceLab setTextColor:[UIColor colorWithHexString:@"ce3330"]];
    [self addSubview:_priceLab];
    
    _targetNum = [num floatValue];
    [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
}

- (void)subTitle
{
    _subTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_priceLab.frame), kScreenWidth, 20.0f)];
    [_subTitle setTextAlignment:NSTextAlignmentCenter];
    [_subTitle setText:@"今日总计"];
    [_subTitle setFont:[UIFont fontWithName:@"STHeitiSC-Light" size:15.0f]];
    [self addSubview:_subTitle];
}

- (void)lineView
{
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(_indexWidth, _height - 21, kScreenWidth - _indexWidth*2, 1)];
    [_lineView setBackgroundColor:[UIColor grayColor]];
    [self addSubview:_lineView];
}


@end
