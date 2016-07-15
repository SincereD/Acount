//
//  MainInterfaceViewController.m
//  Acount
//
//  Created by Sincere on 16/6/16.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import "MainInterfaceViewController.h"
#import "MonthViewController.h"
#import "WeekViewController.h"
#import "RecordViewController.h"
#import "RecordDataOperation.h"
#import "RecordTableViewCell.h"

#import "MainHeaderView.h"
#import "RecordView.h"

@interface MainInterfaceViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView   * _bottomView;
    UIButton * _addBtn;
    UILabel  * _bottomCountLab;
    MainHeaderView   * _headerView;
}
@property (nonatomic,assign) CGFloat inCome;
@property (nonatomic,assign) CGFloat outCome;
@property (nonatomic,assign) NSInteger inComeCount;
@property (nonatomic,assign) NSInteger outComeCount;
@property (nonatomic,retain) UITableView * table;
@property (nonatomic,retain) NSMutableArray * dataSource;

@end

@implementation MainInterfaceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"今日收支"];
    
    _dataSource = [NSMutableArray arrayWithArray:[[RecordDataOperation sharedDataOperation] getTotadyData]];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"STHeitiSC-Medium" size:17.0f],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"333333"]}];
    [self headerView];
    [self configureFee];
    [self bottomView];
    [self addBtn];
    [self bottomCountLab];
    [self tableView];
    [self addGesture];
}

- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    UIImageView *navBarHairlineImageView;
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    navBarHairlineImageView.hidden = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UIImageView *navBarHairlineImageView;
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    navBarHairlineImageView.hidden = YES;
    
    NSArray * dataArry = [[RecordDataOperation sharedDataOperation] getTotadyData];
    if (!_dataSource)
    {
        _dataSource = [NSMutableArray arrayWithArray:dataArry];
    }
    else
    {
        if (_dataSource.count != dataArry.count)
        {
            _dataSource = [NSMutableArray arrayWithArray:dataArry];
            [_table reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
            [self resetTableHeight];
            [self configureFee];
        }
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSManagedObjectContextDidSaveNotification object:nil];
}

- (void)tableView
{
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, [self tableHeight]) style:UITableViewStylePlain];
    [_table setDelegate:self];
    [_table setDataSource:self];
    [_table setSeparatorColor:[UIColor clearColor]];
    [self.view addSubview:_table];
    [self tableHeight];
}

- (void)bottomView
{
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - kTabBarHeight, kScreenWidth, kTabBarHeight)];
    [_bottomView setBackgroundColor:[UIColor colorWithHexString:@"242731"]];
    [self.view addSubview:_bottomView];
    
    UIButton * weekBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [weekBtn setTitle:@"本周" forState:UIControlStateNormal];
    [weekBtn setFrame:CGRectMake(0, 0, kScreenWidth/2.0f, kTabBarHeight)];
    [weekBtn addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:weekBtn];
    
    UIButton * monthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [monthBtn setTitle:@"本月" forState:UIControlStateNormal];
    [monthBtn setFrame:CGRectMake(kScreenWidth/2.0f, 0, kScreenWidth/2.0f, kTabBarHeight)];
    [monthBtn addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:monthBtn];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth/2.0f - 1, 7, 1, kTabBarHeight-14)];
    [lineView setBackgroundColor:[UIColor lightGrayColor]];
    [_bottomView addSubview:lineView];
}

- (void)addBtn
{
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addBtn setFrame:CGRectMake(0, CGRectGetMinY(_bottomView.frame)-kTabBarHeight, kScreenWidth, kTabBarHeight)];
    [_addBtn setTitle:@"添加" forState:UIControlStateNormal];
    [_addBtn setBackgroundColor:[UIColor colorWithHexString:@"ce3330"]];
    [_addBtn addTarget:self action:@selector(recordAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addBtn];
}

- (void)bottomCountLab
{
    _bottomCountLab = [[UILabel alloc] initWithFrame:CGRectMake(0, kScreenHeight - kTabBarHeight*3, kScreenWidth-20, kTabBarHeight)];
    [_bottomCountLab setTextColor:[UIColor colorWithHexString:@"ce3330"]];
    [_bottomCountLab setTextAlignment:NSTextAlignmentRight];
    [self.view addSubview:_bottomCountLab];
    [self resetBottomCountText];
}

- (void)resetBottomCountText
{
    NSString * contentStr = [NSString stringWithFormat:@"收 %d 支 %d ",(int)_inComeCount,(int)_outComeCount];
    NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:contentStr];
    NSRange incomeRange = [contentStr rangeOfString:@"收"];
    NSRange outcomeRange = [contentStr rangeOfString:@"支"];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"333333"] range:incomeRange];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"333333"] range:outcomeRange];
    [_bottomCountLab setAttributedText:str];
}

- (void)headerView
{
    _headerView = [[MainHeaderView alloc] initWithNum:@"100.00"];
}

- (void)coreDataChange:(NSNotification*)notification
{
    _dataSource = [NSMutableArray arrayWithArray:[[RecordDataOperation sharedDataOperation] getTotadyData]];
    [self configureFee];
}

- (CGFloat)tableHeight
{
    CGFloat height = 0;
    if (_dataSource && _dataSource.count != 0)
    {
        height = _dataSource.count * 20;
    }
    else
    {
        return 0;
    }
    
    if (height > (kScreenHeight-64-20-49*2))
    {
        height = kScreenHeight-64-20-49*2;
        [_table setScrollEnabled:YES];
    }
    else
    {
        [_table setScrollEnabled:NO];
    }
    return height+180.0f;
}

- (void)resetTableHeight
{
    [UIView animateWithDuration:0.5 animations:^{
        [_table setFrame:CGRectMake(0, 64, kScreenWidth, [self tableHeight])];
    }];
}

- (void)configureFee
{
    _inComeCount = 0;
    _outComeCount = 0;
    _inCome = 0;
    _outCome = 0;
    for (Record * record in _dataSource)
    {
        CGFloat count = [record.recordNum floatValue];
        if (count>0)
        {
            _inCome += count;
            _inComeCount ++;
        }
        else
        {
            _outCome += count;
            _outComeCount ++;
        }
    }
    [_headerView updateNum:[NSString stringWithFormat:@"%.2f",_inCome+_outCome]];
    [self resetBottomCountText];
}

- (void)addGesture
{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] init];
    [tap setNumberOfTapsRequired:2];
    [tap addTarget:self action:@selector(doubleClickAction:)];
    [self.view addGestureRecognizer:tap];
    
    UISwipeGestureRecognizer * swip = [[UISwipeGestureRecognizer alloc] init];
    [swip setDirection:UISwipeGestureRecognizerDirectionUp];
    [swip addTarget:self action:@selector(swipAction:)];
    [self.view addGestureRecognizer:swip];
}

- (void)doubleClickAction:(UITapGestureRecognizer*)tap
{
    if (tap.state == UIGestureRecognizerStateEnded)
    {
        CGPoint aPoint = [tap locationInView:self.view];
        if (aPoint.x>kScreenWidth/2.0f)
        {
            [self rightAction:nil];
        }
        else
        {
            [self leftAction:nil];
        }
    }
}

- (void)swipAction:(UISwipeGestureRecognizer*)swip
{
    if (swip.state == UIGestureRecognizerStateEnded)
    {
        [self recordAction:nil];
    }
}

- (void)leftAction:(id)sender
{
    WeekViewController * weekVC = [[WeekViewController alloc] init];
    [self presentViewController:weekVC animated:YES completion:^{
        
    }];
}

- (void)rightAction:(id)sender
{
    MonthViewController * monthVC = [[MonthViewController alloc] init];
    [self presentViewController:monthVC animated:YES completion:^{
        
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowMonth"])
    {
        MonthViewController * monthVC = segue.destinationViewController;
        [self presentViewController:monthVC animated:YES completion:^{
            
        }];
    }
    else if ([segue.identifier isEqualToString:@"ShowWeek"])
    {
        WeekViewController * weekVC = segue.destinationViewController;
        [self presentViewController:weekVC animated:YES completion:^{
            
        }];
    }
}

- (void)performSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    
}

- (IBAction)recordAction:(id)sender
{
    RecordViewController * recordVC = [[RecordViewController alloc] init];
    [self presentViewController:recordVC animated:YES completion:^{
        
    }];
}

# pragma mark TableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 180.0f;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return _headerView;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"RecordCell"];
    if (!cell)
    {
//        cell = [[[NSBundle mainBundle]loadNibNamed:@"RecordTableViewCell" owner:nil options:nil] firstObject];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RecordCell"];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
    }
    else
    {
        for (UIView * view in [cell subviews])
        {
            if ([view isKindOfClass:[UIView class]])
            {
                [view removeFromSuperview];
            }
        }
    }
    
    Record * record = _dataSource[indexPath.row];
    RecordView * recordView = [[RecordView alloc] initWithRecord:record width:kScreenWidth];
    [cell addSubview:recordView];
//    [cell setType:RecordTypeDay];
//    [cell setRecord:record];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 20.0f;
}

# pragma mark TableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_dataSource && _dataSource.count!=0)
    {
        return _dataSource.count;
    }
    
    return 0;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[RecordDataOperation sharedDataOperation] deleteCoreDataWithRecord:_dataSource[indexPath.row]];
    [_dataSource removeObjectAtIndex:indexPath.row];
    [_table deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self resetTableHeight];
    [self configureFee];
}

- (NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

@end
