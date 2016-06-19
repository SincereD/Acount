//
//  RecordViewController.m
//  Acount
//
//  Created by Sincere on 16/6/16.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import "RecordViewController.h"
#import "RecordDataOperation.h"

@interface RecordViewController ()


@end

@implementation RecordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (IBAction)backAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)ensureAction:(id)sender
{
    if (![self checkInput])
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"😄你还有空没填哦、" delegate:nil cancelButtonTitle:@"😉" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    
    if ([[RecordDataOperation sharedDataOperation] insertCoreDataWithRecord:[self getRecord]])
    {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
    else
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"😱数据存储错误" delegate:nil cancelButtonTitle:@"😞" otherButtonTitles:nil, nil];
        [alert show];
    }

}

- (IBAction)switchAction:(UISwitch *)sender
{
    if (sender.isOn)
    {
        [_recordTypeLab setTextColor:[UIColor greenColor]];
        [_recordTypeLab setText:@"收入："];
        [sender setTintColor:[UIColor greenColor]];
    }
    else
    {
        [_recordTypeLab setTextColor:[UIColor redColor]];
        [_recordTypeLab setText:@"支出："];
        [sender setTintColor:[UIColor redColor]];
    }
}

- (NSManagedObject*)getRecord
{
 
    NSManagedObject * record = [NSEntityDescription insertNewObjectForEntityForName:@"Record" inManagedObjectContext:[[RecordDataOperation sharedDataOperation] managedObjectContext]];
    
    CGFloat cost =  fabsf([_recordNumTF.text floatValue]);
    if (!_recordTypeSwitch.isOn)
    {
        cost = -cost;
    }
    NSDate * date = [NSDate date];
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfMonth;
    NSDateComponents * dd = [cal components:unitFlags fromDate:date];
    NSInteger year = [dd year];
    NSInteger month = [dd month];
    NSInteger day = [dd day];
    NSInteger week = [dd weekOfMonth];
    
    [record setValue:[NSString stringWithFormat:@"%d",(int)year] forKey:@"year"];
    [record setValue:[NSString stringWithFormat:@"%d",(int)month] forKey:@"month"];
    [record setValue:[NSString stringWithFormat:@"%d",(int)week] forKey:@"week"];
    [record setValue:[NSString stringWithFormat:@"%d",(int)day] forKey:@"day"];
    [record setValue:[NSNumber numberWithFloat:cost] forKey:@"recordNum"];
    [record setValue:date forKey:@"recordDate"];
    [record setValue:_recordTypeSwitch.isOn?@"收入":@"支出" forKey:@"recordType"];
    [record setValue:_detailTF.text forKey:@"detail"];
    
    NSLog(@"%d",(int)year);
    
    return record;
}

- (BOOL)checkInput
{
    BOOL detail = _detailTF.text && ![_detailTF.text isEqualToString:@""];
    
    BOOL number = _recordNumTF.text && ![_recordNumTF.text isEqualToString:@""];
    return detail && number;
}

@end
