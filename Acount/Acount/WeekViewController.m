//
//  WeekViewController.m
//  Acount
//
//  Created by Sincere on 16/6/16.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import "WeekViewController.h"
#import "RecordTableViewCell.h"
#import "RecordDataOperation.h"
#import "TotalRecordViewController.h"

#import "TotalRecordHeaderView.h"

@interface WeekViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,retain) TotalRecordHeaderView * headerView;
@property (nonatomic,retain) UITableView * table;
@property (nonatomic,retain) NSMutableArray * dataSource;

@end

@implementation WeekViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:RGB(27, 27, 26)];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    [self navgationView];
    [self tableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    NSDictionary * weekDict = [[NSDate date] getMonthYearWeek];
    
    _dataSource = [NSMutableArray arrayWithArray:[[RecordDataOperation sharedDataOperation] getWeekDataSourceWithYear:weekDict[@"year"] month:weekDict[@"month"] week:weekDict[@"week"]]];
    _dataSource = [NSMutableArray arrayWithArray:[[RecordDataOperation sharedDataOperation] seprateWeekDataToDay:_dataSource]];
    [self reloadTableView];
    [self initHeaderView];
    [UIApplication sharedApplication].applicationSupportsShakeToEdit = YES;
    [self becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)initHeaderView
{
    Record * firstRecord = [[_dataSource lastObject] lastObject];
    Record * lastRecord = [[_dataSource firstObject] firstObject];
    NSString * mainTitle = [NSString stringWithFormat:@"第%@周",[firstRecord.recordDate getWeekdayOrdinal]];
    NSString * subTitle = [firstRecord.recordDate getRangeStringWithDate:lastRecord.recordDate date:firstRecord.recordDate];
    _headerView = [[TotalRecordHeaderView alloc] initWithRecord:nil];
    [_headerView setFrame:CGRectMake(20, 64, kScreenWidth-40, 115)];
    [_headerView setSubTitle:subTitle];
    [_headerView setMainTitle:mainTitle];
    [self.view addSubview:_headerView];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (event.subtype == UIEventSubtypeMotionShake)
    {
        TotalRecordViewController * totalVC = [[TotalRecordViewController alloc] init];
        [totalVC setRecordArray:_dataSource];
        [self presentViewController:totalVC animated:YES completion:^{
            
        }];
    }
    return;
}

- (void)navgationView
{
    UILabel * titleLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 100, 44)];
    [titleLab setTextColor:[UIColor whiteColor]];
    [titleLab setText:@"本周收支"];
    [self.view addSubview:titleLab];
    
    UIButton * dismissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dismissBtn setTitle:@"×" forState:UIControlStateNormal];
    [dismissBtn.titleLabel setFont:[UIFont fontWithName:@"STHeitiSC-Light" size:33.0f]];
    [dismissBtn setFrame:CGRectMake(kScreenWidth - 50, 20, 44, 44)];
    [dismissBtn addTarget:self action:@selector(dismissAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dismissBtn];
}

- (void)dismissAction
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)tableView
{
    _table = [[UITableView alloc] initWithFrame:CGRectMake(20,64+115, kScreenWidth - 40, _dataSource.count*60 + 30) style:UITableViewStylePlain];
    [_table setDelegate:self];
    [_table setDataSource:self];
    [_table setSeparatorColor:[UIColor clearColor]];
    [self.view addSubview:_table];
}

- (CGFloat)tableHeight
{
    CGFloat height = 0;
    NSInteger index = 0;
    if (_dataSource && _dataSource.count != 0)
    {
        for (NSArray * rowData in _dataSource)
        {
            index += rowData.count;
        }
        height = index*20;
    }
    else
    {
        return 0;
    }
    
    if (height > (kScreenHeight-64-115))
    {
        height=kScreenHeight-64-115;
        [_table setScrollEnabled:YES];
    }
    else
    {
        [_table setScrollEnabled:NO];
    }
    return height;
}

- (void)resetTableHeight
{
    [UIView animateWithDuration:0.5 animations:^{
        [_table setFrame:CGRectMake(20, 64+115, kScreenWidth-40, [self tableHeight])];
    }];
}

- (void)reloadTableView
{
    CGFloat height = 0;
    NSInteger index = 0;
    if (_dataSource && _dataSource.count != 0)
    {
        for (NSArray * rowData in _dataSource)
        {
            index += rowData.count;
        }
        height = index*20 + _dataSource.count * 30;
    }
    else
    {
        [UIView animateWithDuration:0.5 animations:^{
            [_table setFrame:CGRectMake(20, 64+115, kScreenWidth-40, height)];
        } completion:^(BOOL finished) {
            [_table reloadData];
        }];
        return;
    }
    
    if (height > (kScreenHeight-64-115))
    {
        height = kScreenHeight-64-115;
        [_table setScrollEnabled:YES];
    }
    else
    {
        [_table setScrollEnabled:NO];
    }
    [_table setFrame:CGRectMake(20, 64+115, kScreenWidth-40, height)];
    [_table reloadData];
}

# pragma mark TableView Delegate

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    Record * record = [_dataSource[section] objectAtIndex:0];
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth-40, 40)];
    [headerView setBackgroundColor:[UIColor whiteColor]];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(36, 10, CGRectGetWidth(headerView.frame), 20)];
    [label setText:[record.recordDate getMonthDayStringWithContrastion]];
    [label setTextColor:[UIColor colorWithHexString:@"ce3330"]];
    [label setFont:[UIFont systemFontOfSize:19.0f]];
    [headerView addSubview:label];
    return headerView;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth-40, 30)];
    [footerView setBackgroundColor:[UIColor whiteColor]];
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(36, 18, kScreenWidth-40-72, 1)];
    [lineView setBackgroundColor:[UIColor colorWithHexString:@"C1C1C1" alpha:0.50f]];
    [footerView addSubview:lineView];
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 30.0f;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecordTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"RecordCell"];
    if (!cell)
    {
        cell= [[[NSBundle mainBundle]loadNibNamed:@"RecordTableViewCell" owner:nil options:nil] firstObject];
    }
    NSArray * rowData = _dataSource[indexPath.section];
    Record * record = rowData[indexPath.row];
    [cell setType:RecordTypeWeek];
    [cell setRecord:record];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 25.0f;
}

# pragma mark TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * rowData = _dataSource[section];
    return rowData.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[RecordDataOperation sharedDataOperation] deleteCoreDataWithRecord:_dataSource[indexPath.row]];
    [_dataSource removeObjectAtIndex:indexPath.row];
    [_table deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self resetTableHeight];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

@end
