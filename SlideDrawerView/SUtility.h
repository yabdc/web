//
//  SUtility.h
//  FubonMStaff
//
//  Created by Systex on 2015/7/1.
//  Copyright (c) 2015年 Systex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

//---Debug Logger---
#ifdef DEBUG
#define SMLog( s, ... ) {NSLog((@"%s [Line %d] " s), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
#else
#define SMLog( s, ... )
#endif

//---MACRO---
#define PRINTFRAME(f) SMLog(@"(%.0f,%.0f,%.0f,%.0f)",f.origin.x,f.origin.y,f.size.width,f.size.height)
#define PRINTVIEW(v)  PRINTFRAME(v.frame)
#define RGB(r,g,b)    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define ROOTVIEW      [[[UIApplication sharedApplication] keyWindow] rootViewController]

#define IOSVERSION_EQUAL_TO(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define IOSVERSION_GREATER_THAN(v)             ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define IOSVERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define IOSVERSION_LESS_THAN(v)                ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define IOSVERSION_LESS_THAN_OR_EQUAL_TO(v)    ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

//---Date---
#define kSWDateFormatTypeNormal @"yyyy/MM/dd"
#define kSWDateFormatTypeInteger @"yyyyMMdd"
#define kSWDateFormatTypeDash @"yyyy-MM-dd"
#define kSWDateFormatTypeTime24 @"HH:mm"
#define kSWDateFormatTypeDateAndTime24 @"yyyy/MM/dd HH:mm"

#define kSWAlphaUppercase @"ABCDEFGHIJKLMNOPQRSTUVWXYZ"
#define kSWAlphaLowercase @"abcdefghijklmnopqrstuvwxyz"
#define kSWNumber @"1234567890"
#define kSWAlpha kSWAlphaUppercase kSWAlphaLowercase
#define kSWAlphaNum kSWAlpha kSWNumber
#define kSWAlphaNumSpace kSWAlphaNum @" "

//===Configs===
//---Default setting---
#define kSWFadeInAnimationDuration (0.15f)




@interface SUtility : NSObject

+ (UIViewController*)topMostController;

@end
