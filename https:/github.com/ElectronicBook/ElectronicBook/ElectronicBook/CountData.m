//
//  CountData.m
//  ElectronicBook
//
//  Created by 你 on 15-7-8.
//  Copyright (c) 2015年 wonder. All rights reserved.
//

#import "CountData.h"
#import "AppDelegate.h"
#import "TimeManager.h"

@implementation CountData

+ (NSArray *)countPieChart:(NSDictionary *)time andIsIncome:(BOOL)isIncome {
    //取出参数
    NSDate *beginDate = [time valueForKey:@"beginDate"];
    NSDate *endDate = [time valueForKey:@"endDate"];
    //第一次查询，按时间查询出需要的数据
    NSMutableArray *array = [NSMutableArray array];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date>=%@ and date<=%@",beginDate,endDate];
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSArray *result = [delegate.baseBillManager selectBills:predicate];
    //第二次查询，整理统计查询出来的数据
    NSArray *typeArray = isIncome ? delegate.incomeType : delegate.expenditureType;
    for(int i=0; i<typeArray.count; i++) {
        NSArray *iResult = [result filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"type = %@",typeArray[i]]];
        NSNumber *resultValue = [iResult valueForKeyPath:@"@sum.value.doubleValue"];
        if([resultValue doubleValue]!= 0) {
            [array addObject:[NSDictionary dictionaryWithObjectsAndKeys:typeArray[i],@"name",resultValue,@"value",nil]];
        }
    }
    return array;
}

+ (NSArray *)countHistogram:(NSDictionary *)time andType:(NSString *)type{
    //取出参数
    NSDate *beginDate = [time valueForKey:@"beginDate"];
    NSDate *endDate = [time valueForKey:@"endDate"];
    NSString *timeInterval = [time valueForKey:@"timeInterval"];
    //第一次查询，按时间查询出需要的数据
    NSMutableArray *array = [NSMutableArray array];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date>=%@ and date<=%@ and type=%@",beginDate,endDate,type];
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSArray *result = [delegate.baseBillManager selectBills:predicate];
    //第二次查询，整理统计查询出来的数据
    for(int i=0; [beginDate compare:endDate]==NSOrderedAscending; i++) {
        NSArray *iResult = [result filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"date>=%@ and date<=%@",beginDate,[beginDate dateByAddingTimeInterval:24*60*60]]];
        NSNumber *resultValue = [iResult valueForKeyPath:@"@sum.value.doubleValue"];
        [array addObject:[NSDictionary dictionaryWithObjectsAndKeys:[TimeManager stringFromDate:beginDate withTimeIntervalType:timeInterval],@"date",resultValue,@"value",nil]];
        beginDate = [TimeManager nextDate:beginDate AddTimeIntervalType:timeInterval];
    }
    return array;
}

+ (NSArray *)countLineChart:(NSDictionary *)time andIsIncome:(BOOL)isIncome {
    //取出参数
    NSDate *beginDate = [time valueForKey:@"beginDate"];
    NSDate *endDate = [time valueForKey:@"endDate"];
    NSString *timeInterval = [time valueForKey:@"timeInterval"];
    //第一次查询，按时间查询出需要的数据
    NSMutableArray *array = [NSMutableArray array];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date>=%@ and date<=%@ and isIncome==%@",beginDate,endDate,[NSNumber numberWithBool:isIncome]];
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSArray *result = [delegate.baseBillManager selectBills:predicate];
    //第二次查询，整理统计查询出来的数据
    for(int i=0; [beginDate compare:endDate]==NSOrderedAscending; i++) {
        NSArray *iResult = [result filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"date>=%@ and date<=%@",beginDate,[TimeManager nextDate:beginDate AddTimeIntervalType:timeInterval]]];
        NSNumber *resultValue = [iResult valueForKeyPath:@"@sum.value.doubleValue"];
        [array addObject:[NSDictionary dictionaryWithObjectsAndKeys:[TimeManager stringFromDate:beginDate withTimeIntervalType:timeInterval],@"date",resultValue,@"value",nil]];
        beginDate = [TimeManager nextDate:beginDate AddTimeIntervalType:timeInterval];
    }
    return array;
}

@end
