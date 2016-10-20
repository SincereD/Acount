//
//  MainInterfaceViewController.h
//  Acount
//
//  Created by Sincere on 16/6/16.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainInterfaceViewController : DSBaseViewController

@property (weak, nonatomic) IBOutlet UILabel *outComeLab;
@property (weak, nonatomic) IBOutlet UILabel *inComeLab;
- (IBAction)recordAction:(id)sender;

@end
