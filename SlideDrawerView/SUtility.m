//
//  SUtility.m
//  FubonMStaff
//
//  Created by Systex on 2015/7/1.
//  Copyright (c) 2015年 Systex. All rights reserved.
//

#import "SUtility.h"
#import "AppDelegate.h"
@implementation SUtility

+ (UIViewController*)topMostController
{
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    
    return topController;
}

@end
