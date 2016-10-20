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

@interface WeekViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,retain) UITableView * table;
@property (nonatomic,retain) NSMutableArray * dataSource;

@end

@implementation WeekViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"本周"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    [self tableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSDictionary * weekDict = [[NSDate date] getMonthYearWeek];
    _dataSource = [NSMutableArray arrayWithArray:[[RecordDataOperation sharedDataOperation] getWeekDataSourceWithYear:weekDict[@"year"] month:weekDict[@"month"] week:weekDict[@"week"]]];
    [self reloadTableView];
    [UIApplication sharedApplication].applicationSupportsShakeToEdit = YES;
    [self becomeFirstResponder];
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

- (void)tableView
{
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, _dataSource.count*60 + 30) style:UITableViewStylePlain];
    [_table setDelegate:self];
    [_table setDataSource:self];
    [self.view addSubview:_table];
}

- (CGFloat)tableHeight
{
    CGFloat height = 0;
    if (_dataSource && _dataSource.count != 0)
    {
        height = _dataSource.count * 60;
    }
    else
    {
        return 0;
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
    return height;
}

- (void)resetTableHeight
{
    [UIView animateWithDuration:0.5 animations:^{
        [_table setFrame:CGRectMake(0, 64, kScreenWidth, [self tableHeight])];
    }];
}

- (void)reloadTableView
{
    CGFloat height = 0;
    if (_dataSource && _dataSource.count != 0)
    {
        height = _dataSource.count * 60 + 30;
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
        height = kScreenHeight-64;
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

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecordTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"RecordCell"];
    if (!cell)
    {
        cell= [[[NSBundle mainBundle]loadNibNamed:@"RecordTableViewCell" owner:nil options:nil] firstObject];
    }
    Record * record = _dataSource[indexPath.row];
    [cell setType:RecordTypeWeek];
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0f;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @" 😏 Shake It ？";
}


@end
