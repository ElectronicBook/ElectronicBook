//
//  TimeManager.h
//  ElectronicBook
//
//  Created by 你 on 15-7-9.
//  Copyright (c) 2015年 wonder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeManager : NSObject

+ (NSDate *)dateClearTime:(NSDate *)date withTimeIntervalType:(NSString *)type;
+ (NSDate *)nextDate:(NSDate *)date AddTimeIntervalType:(NSString *)type;
+ (NSString *)stringFromDate:(NSDate *)date withTimeIntervalType:(NSString *)type;

@end
