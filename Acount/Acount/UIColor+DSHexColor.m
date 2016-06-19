//
//  UIColor+DSHexColor.m
//  DSCommon
//
//  Created by Sincere on 16/3/11.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import "UIColor+DSHexColor.h"

@implementation UIColor (DSHexColor)

- (UIColor*)colorWithHexString:(NSString*)hexString{
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    range.location = 0;
    [[NSScanner scannerWithString:[hexString substringWithRange:range]] scanHexInt:&red];
    range.location = 2;
    [[NSScanner scannerWithString:[hexString substringWithRange:range]] scanHexInt:&green];
    range.location = 4;
    [[NSScanner scannerWithString:[hexString substringWithRange:range]] scanHexInt:&blue];
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green/255.0f) blue:(float)(blue/255.0f) alpha:1.0f];
}

- (UIColor*)colorWithHexString:(NSString*)hexString alpha:(CGFloat)alpha
{
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    range.location = 0;
    [[NSScanner scannerWithString:[hexString substringWithRange:range]] scanHexInt:&red];
    range.location = 2;
    [[NSScanner scannerWithString:[hexString substringWithRange:range]] scanHexInt:&green];
    range.location = 4;
    [[NSScanner scannerWithString:[hexString substringWithRange:range]] scanHexInt:&blue];
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green/255.0f) blue:(float)(blue/255.0f) alpha:alpha];
}

-(BOOL)isDarkColor
{
    if ([self alphaForColor]<10e-5)
    {
        return YES;
    }
    const CGFloat *componentColors = CGColorGetComponents(self.CGColor);
    CGFloat colorBrightness = ((componentColors[0] * 299) + (componentColors[1] * 587) + (componentColors[2] * 114)) / 1000;
    
    if (colorBrightness < 0.5)
    {
        NSLog(@"Color is dark");
        return YES;
    }
    else
    {
        NSLog(@"Color is light");
        return NO;
    }
}

- (CGFloat) alphaForColor
{
    CGFloat r, g, b, a, w, h, s, l;
    BOOL compatible = [self getWhite:&w alpha:&a];
    if (compatible)
    {
        return a;
    }
    else
    {
        compatible = [self getRed:&r green:&g blue:&b alpha:&a];
        if (compatible)
        {
            return a;
        }
        else
        {
            [self getHue:&h saturation:&s brightness:&l alpha:&a];
            return a;
        }
    }
}

@end
