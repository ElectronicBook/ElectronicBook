//
//  TimeManager.m
//  ElectronicBook
//
//  Created by 你 on 15-7-9.
//  Copyright (c) 2015年 wonder. All rights reserved.
//

#import "TimeManager.h"

@implementation TimeManager

//将日期后的时间归零，归为当天(或当年，当月第一天)的零点
+ (NSDate *)dateClearTime:(NSDate *)date withTimeIntervalType:(NSString *)type {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if([type isEqualToString:@"年"]) {
        [formatter setDateFormat:@"yyyy"];
    } else if([type isEqualToString:@"月"]) {
        [formatter setDateFormat:@"yyyy-MM"];
    } else {
        [formatter setDateFormat:@"yyy-MM--dd"];
    }
    NSString *dateStr = [formatter stringFromDate:date];
    return [formatter dateFromString:dateStr];
}

//返回下一天，下一个月或下一年
+ (NSDate *)nextDate:(NSDate *)date AddTimeIntervalType:(NSString *)type {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    if([type isEqualToString:@"年"]) {
        [adcomps setYear:1];
    } else if([type isEqualToString:@"月"]) {
        [adcomps setMonth:1];
    } else {
        [adcomps setDay:1];
    }
    return [calendar dateByAddingComponents:adcomps toDate:date options:0];
}

//根据时间单位返回时间的字符串
+ (NSString *)stringFromDate:(NSDate *)date withTimeIntervalType:(NSString *)type {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if([type isEqualToString:@"年"]) {
        [formatter setDateFormat:@"yyyy年"];
    } else if([type isEqualToString:@"月"]) {
        [formatter setDateFormat:@"MM月"];
    } else {
        [formatter setDateFormat:@"dd日"];
    }
    return [formatter stringFromDate:date];
}

@end
