//
//  RecordViewController.h
//  Acount
//
//  Created by Sincere on 16/6/16.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import "DSBaseViewController.h"

@interface RecordViewController : DSBaseViewController

@property (weak, nonatomic) IBOutlet UIButton *ensureBtn;
@property (weak, nonatomic) IBOutlet UISwitch *recordTypeSwitch;
@property (weak, nonatomic) IBOutlet UITextField *recordNumTF;
@property (weak, nonatomic) IBOutlet UITextField *detailTF;
@property (weak, nonatomic) IBOutlet UILabel *recordTypeLab;

- (IBAction)backAction:(id)sender;
- (IBAction)switchAction:(UISwitch *)sender;

@end
