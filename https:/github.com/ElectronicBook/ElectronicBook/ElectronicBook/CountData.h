//
//  CountData.h
//  ElectronicBook
//
//  Created by 你 on 15-7-8.
//  Copyright (c) 2015年 wonder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CountData : NSObject

+ (NSArray *)countPieChart:(NSDictionary *)time andIsIncome:(BOOL)isIncome;
+ (NSArray *)countHistogram:(NSDictionary *)time andType:(NSString *)type;
+ (NSArray *)countLineChart:(NSDictionary *)time andIsIncome:(BOOL)isIncome;

@end
