//
//  RecordViewController.m
//  Acount
//
//  Created by Sincere on 16/6/16.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import "RecordViewController.h"
#import "RecordDataOperation.h"

@interface RecordViewController ()<UITextFieldDelegate>

@end

@implementation RecordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_ensureBtn.layer setCornerRadius:40.0f];
    [_ensureBtn.layer setMasksToBounds:YES];
    [_recordTypeSwitch setTintColor:[UIColor colorWithHexString:@"ce3330"]];
    [self addGesture];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_recordNumTF becomeFirstResponder];
}

- (void)addGesture
{
    UISwipeGestureRecognizer * swip = [[UISwipeGestureRecognizer alloc] init];
    [swip setDirection:UISwipeGestureRecognizerDirectionDown];
    [swip addTarget:self action:@selector(swipAction:)];
    [self.view addGestureRecognizer:swip];
}

- (void)swipAction:(UISwipeGestureRecognizer*)swip
{
    if (swip.state == UIGestureRecognizerStateEnded)
    {
        [self backAction:nil];
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (IBAction)backAction:(id)sender
{
    [self.view endEditing:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    });
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
        [self.view endEditing:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        });
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
        [_recordTypeLab setTextColor:[UIColor colorWithHexString:@"7ed321"]];
        [_recordTypeLab setText:@"收入："];
        [sender setTintColor:[UIColor colorWithHexString:@"7ed321"]];
        [_recordNumTF setPlaceholder:@" િ😁ી "];
    }
    else
    {
        [_recordTypeLab setTextColor:[UIColor colorWithHexString:@"ce3330"]];
        [_recordTypeLab setText:@"支出："];
        [sender setTintColor:[UIColor colorWithHexString:@"ce3330"]];
        [_recordNumTF setPlaceholder:@"࿓😒࿐"];
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
    return record;
}

- (BOOL)checkInput
{
    BOOL detail = _detailTF.text && ![_detailTF.text isEqualToString:@""];
    
    BOOL number = _recordNumTF.text && ![_recordNumTF.text isEqualToString:@""];
    return detail && number;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (!_recordNumTF.text || [_recordNumTF.text isEqualToString:@""])
    {
        if (textField == _detailTF)
        {
            return NO;
        }
        [_recordNumTF becomeFirstResponder];
    }
    else if (!_detailTF.text || [_detailTF.text isEqualToString:@""])
    {
        if (textField == _detailTF) {
            return NO;
        }
        [_detailTF becomeFirstResponder];
    }
    else
    {
        [self ensureAction:nil];
    }
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (_detailTF.text && _recordNumTF.text && ![_detailTF.text isEqualToString:@""] && ![_recordNumTF.text isEqualToString:@""])
    {
        [UIView animateWithDuration:0.5 animations:^{
            _ensureBtn.alpha = 1.0f;
        }];
    }
    return YES;
}

@end
