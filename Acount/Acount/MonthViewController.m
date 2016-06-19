//
//  MonthViewController.m
//  Acount
//
//  Created by Sincere on 16/6/16.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import "MonthViewController.h"
#import "RecordTableViewCell.h"
#import "RecordDataOperation.h"

@interface MonthViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,retain) UITableView * table;
@property (nonatomic,retain) NSMutableArray * dataSource;

@end

@implementation MonthViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"本月"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    [self tableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSDictionary * weekDict = [[NSDate date] getMonthYearWeek];
    _dataSource = [NSMutableArray arrayWithArray:[[RecordDataOperation sharedDataOperation] getMonthDataSourceWithYear:weekDict[@"year"] month:weekDict[@"month"]]];
    [self reloadTableView];
}

- (void)tableView
{

    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 60*7) style:UITableViewStylePlain];
    [_table setDelegate:self];
    [_table setDataSource:self];
    [self.view addSubview:_table];
    
}

- (void)reloadTableView
{
    CGFloat height = 0;
    if (_dataSource && _dataSource.count != 0)
    {
        height = _dataSource.count * 60;
    }
    else
    {
        [UIView animateWithDuration:0.5 animations:^{
            [_table setFrame:CGRectMake(0, 64, kScreenWidth, height)];
        } completion:^(BOOL finished) {
            [_table reloadData];
        }];
        return;
    }
    
    if (height > (kScreenHeight-64))
    {
        height=kScreenHeight-64;
        [_table setScrollEnabled:YES];
    }
    else
    {
        [_table setScrollEnabled:NO];
    }
    [_table setFrame:CGRectMake(0, 64, kScreenWidth, height)];
    [_table reloadData];
}

# pragma mark TableView Delegate

- (RecordTableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecordTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"RecordCell"];
    if (!cell)
    {
        cell= [[[NSBundle mainBundle]loadNibNamed:@"RecordTableViewCell" owner:nil options:nil] firstObject];
    }
    Record * record = _dataSource[indexPath.row];
    [cell setRecord:record];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

# pragma mark TableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[RecordDataOperation sharedDataOperation] deleteCoreDataWithRecord:_dataSource[indexPath.row]];
    [_dataSource removeObjectAtIndex:indexPath.row];
    [_table reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    [self reloadTableView];
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
