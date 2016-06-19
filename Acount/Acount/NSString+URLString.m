//
//  NSString+URLString.m
//  YFMapKit
//
//  Created by Sincere on 16/4/5.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import "NSString+URLString.h"

@implementation NSString (URLString)

- (NSString*)URLTranslate
{
    NSString * newSelf = @"";
    NSArray * URLStr = @[@"+",@" ",@"/",@"?",@"%",@"#",@"&",@"="];
    NSArray * URL = @[@"%2B",@"%20",@"%2F",@"%3F",@"%25",@"%23",@"%26",@"3D"];
    for (int i = 0; i<self.length -1; i++)
    {
        NSString * s = [self substringWithRange:NSMakeRange(i, 1)];
        if ([URLStr containsObject:s])
        {
            NSInteger index = [URLStr indexOfObject:s];
            s = URL[index];
        }
        newSelf = [newSelf stringByAppendingString:s];
    }
    return newSelf;
}

@end
