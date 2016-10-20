//
//  DSMacro.h
//  DSCommon
//
//  Created by Sincere on 16/7/6.
//  Copyright © 2016年 QiujunTech. All rights reserved.
//

#ifndef DSMacro_h
#define DSMacro_h

//格式化字符串
#define kString(...) [NSString stringWithFormat:__VA_ARGS__]

//格式化URL
#define kURLFromString(url) [NSURL URLWithString:url]

//图片名
#define kImage(name) [UIImage imageNamed:name]

//输出点、坐标、Rect
#define DSLogPoint(p)	NSLog(@"%.2f,%.2f", p.x, p.y);
#define DSLogSize(size)	NSLog(@"%.2f,%.2f", size.width, size.height);
#define DLogRecT(p)   	NSLog(@"%.2f,%.2f %.2f,%.2f", p.origin.x, p.origin.y, p.size.width, p.size.height);

//格式化数字
#define kDoubleToString(double) [NSString stringWithFormat:@"%.2f",double]
#define kIntToString(intValue)  [NSString stringWithFormat:@"%i",intValue]
#define kIntegerToString(value) [NSString stringWithFormat:@"%ld",(long)value]
#define kLongToString(value)    [NSString stringWithFormat:@"%lli",(long long)value]
#define kFloatToString(float)   [NSString stringWithFormat:@"%.0f",float]
#define kObjToString(obj)       [NSString stringWithFormat:@"%@",obj]

//RGB色值
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r, g, b) RGBA(r,g,b,1.0f)

//单例快捷操作
#define DEFINE_SINGLETON_FOR_HEADER(className) \
\
+ (className *)shared##className;

#define DEFINE_SINGLETON_FOR_CLASS(className) \
\
+ (className *)shared##className { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[self alloc] init]; \
}); \
return shared##className; \
}

/**
 *  判断一个对象是否为空
 *
 *  @param obj 对象
 *
 *  @return 返回结果
 */
static inline BOOL DSIsObjNull(id obj)
{
    return obj == nil ||
    ([obj isEqual:[NSNull null]]) ||
    ([obj respondsToSelector:@selector(length)] && [(NSData *)obj length] == 0) ||
    ([obj respondsToSelector:@selector(count)]  && [(NSArray *)obj count] == 0);
}

/**
 *  判断一个字符串是否为空
 *
 *  @param string 字符串
 *
 *  @return 返回结果
 */
static inline BOOL DSIsStringNull(NSString *string)
{
    
    if (string == nil)
    {
        return YES;
    }
    
    if (string.length == 0)
    {
        return YES;
    }
    
    if ([string isEqualToString:@"<null>"])
    {
        return YES;
    }
    
    if ([string isEqualToString:@"(null)"])
    {
        return YES;
    }
    
    return NO;
}

#endif /* DSMacro_h */
