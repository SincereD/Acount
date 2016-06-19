//
//  NSString+Predicate.h
//  DSCommon
//
//  Created by Sincere on 16/3/23.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DSPredicate)

- (BOOL)isValidateEmail;

- (BOOL)isValidateMobile;

- (BOOL)isValidateWithRegex:(NSString *)regex;

- (BOOL)isValidateUrl;

- (BOOL)isValidateCarNo;

- (NSString *)stringByTrimmingBlank;

@end
