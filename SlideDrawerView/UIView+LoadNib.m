//
//  UIView+LoadNib.m
//  OneCard
//
//  Created by Siva Wang on 2014/3/20.
//  Copyright (c) 2014年 siva. All rights reserved.
//

#import "UIView+LoadNib.h"

@implementation UIView (LoadNib)

+ (id)loadFromNib
{
    NSString *nibName = NSStringFromClass([self class]);
    NSArray *elements = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
    for (NSObject *obj in elements){
        if ([obj isKindOfClass:[self class]]){
            return obj;
        }
    }
    return nil;
}

@end
