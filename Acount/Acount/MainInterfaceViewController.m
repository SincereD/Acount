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

@interface MainInterfaceViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,assign) CGFloat inCome;
@property (nonatomic,assign) CGFloat outCome;
@property (nonatomic,retain) UITableView * table;
@property (nonatomic,retain) NSMutableArray * dataSource;

@end

@implementation MainInterfaceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"今天"];
    
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor brownColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor brownColor]}];
    
    _dataSource = [NSMutableArray arrayWithArray:[[RecordDataOperation sharedDataOperation] getTotadyData]];
   
    [self leftItem];
    [self rightItem];
    [self tableView];
    [self configureFee];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
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
    [self.view addSubview:_table];
    [self tableHeight];
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
        height = _dataSource.count * 60;
    }
    else
    {
        return 0;
    }
    
    if (height > (kScreenHeight-64-100))
    {
        height=kScreenHeight-64-100;
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

- (void)configureFee
{
    _inCome = 0;
    _outCome = 0;
    for (Record * record in _dataSource)
    {
        CGFloat count = [record.recordNum floatValue];
        if (count>0)
        {
            _inCome += count;
        }
        else
        {
            _outCome += count;
        }
    }
    
    [_inComeLab setText:[NSString stringWithFormat:@"收入：%.2f",_inCome]];
    [_outComeLab setText:[NSString stringWithFormat:@"支出：%.2f",_outCome]];
}

- (void)leftItem
{
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setFrame:CGRectMake(0, 0, 44, 44)];
    [leftBtn setTitle:@"本周" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    [self setBaseLeftBarButtonItem:leftItem];
}

- (void)leftAction:(id)sender
{
    WeekViewController * weekVC = [[WeekViewController alloc] init];
    [self.navigationController pushViewController:weekVC animated:YES];}

- (void)rightItem
{
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setFrame:CGRectMake(0, 0, 44, 44)];
    [rightBtn setTitle:@"本月" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    [self setBaseRightBarButtonItem:rightItem];
}

- (void)rightAction:(id)sender
{
    MonthViewController * monthVC = [[MonthViewController alloc] init];
    [self.navigationController pushViewController:monthVC animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowMonth"])
    {
        MonthViewController * monthVC = segue.destinationViewController;
		[self.navigationController pushViewController:monthVC animated:YES];
    }
    else if ([segue.identifier isEqualToString:@"ShowWeek"])
    {
        WeekViewController * weekVC = segue.destinationViewController;
        [self.navigationController pushViewController:weekVC animated:YES];
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

- (RecordTableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecordTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"RecordCell"];
    if (!cell)
    {
        cell= [[[NSBundle mainBundle]loadNibNamed:@"RecordTableViewCell" owner:nil options:nil] firstObject];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
    }
    Record * record = _dataSource[indexPath.row];
    [cell setType:RecordTypeDay];
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
