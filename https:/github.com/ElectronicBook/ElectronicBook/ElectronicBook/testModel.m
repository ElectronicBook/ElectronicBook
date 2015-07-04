//
//  testModel.m
//  ElectronicBook
//
//  Created by 你 on 15-7-4.
//  Copyright (c) 2015年 wonder. All rights reserved.
//

#import "testModel.h"

@implementation testModel

- (instancetype)initWithDate:(NSDate *)date andIncome:(double)income andExpenditure:(double)expenditure {
    self = [super init];
    self.date = date;
    self.income = income;
    self.expenditure = expenditure;
    return self;
}

+ (instancetype)testWithDate:(NSDate *)date andIncome:(double)income andExpenditure:(double)expenditure {
    return [[testModel alloc] initWithDate:date andIncome:income andExpenditure:expenditure];
}

+ (NSMutableArray *)testModelList {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"testModelList" ofType:@"plist"];
    NSArray *file = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *results = [NSMutableArray array];
    for (NSDictionary *dic in file) {
        NSDate *date = [dic valueForKey:@"date"];
        double income = [[dic valueForKey:@"income"] doubleValue];
        double expenditure = [[dic valueForKey:@"expenditure"] doubleValue];
        testModel *test = [testModel testWithDate:date andIncome:income andExpenditure:expenditure];
        [results addObject:test];
    }
    return results;
}

@end
