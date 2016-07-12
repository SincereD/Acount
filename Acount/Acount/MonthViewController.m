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
#import "TotalRecordViewController.h"
#import "UULineChart.h"
#import "XYPieChart.h"
#import "TotalRecordHeaderView.h"

@interface MonthViewController ()<UITableViewDelegate,UITableViewDataSource,XYPieChartDelegate, XYPieChartDataSource>
@property (nonatomic,retain) TotalRecordHeaderView * headerView;
@property (nonatomic,retain) UITableView * table;
@property (nonatomic,retain) NSMutableArray * dataSource;
@property (nonatomic,retain) XYPieChart * pieChart;
@property (nonatomic,retain) UIView * pieMask;
@property (nonatomic,retain) UULineChart * lineChart;
@property (nonatomic,retain) NSMutableArray * slices;
@property (nonatomic,retain) NSArray * sliceColors;

@end

@implementation MonthViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:RGB(27, 27, 26)];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    [self initHeaderView];
    [self tableView];
    [self navgationView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSDictionary * weekDict = [[NSDate date] getMonthYearWeek];
    _dataSource = [NSMutableArray arrayWithArray:[[RecordDataOperation sharedDataOperation] getMonthDataSourceWithYear:weekDict[@"year"] month:weekDict[@"month"]]];
    [self reloadTableView];
    
    [UIApplication sharedApplication].applicationSupportsShakeToEdit = YES;
    [self becomeFirstResponder];
}

- (void)navgationView
{
    UILabel * titleLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 100, 44)];
    [titleLab setTextColor:[UIColor whiteColor]];
    [titleLab setText:@"本月收支"];
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

- (void)initHeaderView
{
    _headerView = [[TotalRecordHeaderView alloc] initWithRecord:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
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
    _table = [[UITableView alloc] initWithFrame:CGRectMake(20, 64, kScreenWidth-40, 60*7) style:UITableViewStylePlain];
    [_table setDelegate:self];
    [_table setDataSource:self];
    [self.view addSubview:_table];
}

- (void)createLineChart
{
    
}

- (void)createPieChart
{
    self.sliceColors =[NSArray arrayWithObjects:
                       [UIColor colorWithRed:246/255.0 green:155/255.0 blue:0/255.0 alpha:1],
                       [UIColor colorWithRed:129/255.0 green:195/255.0 blue:29/255.0 alpha:1],
                       [UIColor colorWithRed:62/255.0 green:173/255.0 blue:219/255.0 alpha:1],
                       [UIColor colorWithRed:229/255.0 green:66/255.0 blue:115/255.0 alpha:1],
                       [UIColor colorWithRed:148/255.0 green:141/255.0 blue:139/255.0 alpha:1],nil];
    self.slices = [NSMutableArray arrayWithCapacity:10];
    
    for(int i = 0; i < 5; i ++)
    {
        NSNumber *one = [NSNumber numberWithInt:rand()%60+20];
        [_slices addObject:one];
    }
    
    _pieChart = [[XYPieChart alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth/2.0f, kScreenWidth/2.0f) Center:CGPointMake(kScreenWidth/2.0f, kScreenWidth/2.0f) Radius:120];
    [_pieChart setDataSource:self];
    [_pieChart setStartPieAngle:M_PI_2];
    [_pieChart setAnimationSpeed:1.0];
    [_pieChart setLabelFont:[UIFont systemFontOfSize:20.0f]];
    [_pieChart setLabelRadius:60];
    [_pieChart setShowPercentage:YES];
    [_pieChart setPieBackgroundColor:[UIColor colorWithWhite:0.95 alpha:1]];
    [_pieChart setUserInteractionEnabled:YES];
    [_pieChart setLabelShadowColor:[UIColor blackColor]];
    [self.view addSubview:_pieChart];
    
    _pieMask = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth/2.0f - kScreenWidth/12.0f, kScreenWidth/2.0f + 64.0f- kScreenWidth/12.0f, kScreenWidth/6.0f, kScreenWidth/6.0f)];
    [_pieMask.layer setCornerRadius:kScreenWidth/12.0f];
    [_pieMask.layer setMasksToBounds:YES];
    [_pieMask setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_pieMask];
    
    [_pieChart reloadData];
    NSLog(@"%.f",kScreenWidth);
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

- (void)clickView
{
    
}

# pragma mark - XYPieChartDataSource

- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart
{
    return self.slices.count;
}

- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index
{
    return [[self.slices objectAtIndex:index] intValue];
}

- (UIColor *)pieChart:(XYPieChart *)pieChart colorForSliceAtIndex:(NSUInteger)index
{
    return [self.sliceColors objectAtIndex:(index % self.sliceColors.count)];
}

- (void)reloadTableView
{
    [_table setFrame:CGRectMake(20, 64, kScreenWidth-40, [self tableHeight])];
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
    [cell setType:RecordTypeMonth];
    [cell setRecord:record];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return _headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 115.0f;
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
    [_table setFrame:CGRectMake(0, 64, kScreenWidth, [self tableHeight])];
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
