//
//  testModel.h
//  ElectronicBook
//
//  Created by 你 on 15-7-4.
//  Copyright (c) 2015年 wonder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface testModel : NSObject

@property (strong, nonatomic) NSDate *date;
@property (assign, nonatomic) double income;
@property (assign, nonatomic) double expenditure;

- (instancetype)initWithDate:(NSDate *)date andIncome:(double)income andExpenditure:(double)expenditure;
+ (instancetype)testWithDate:(NSDate *)date andIncome:(double)income andExpenditure:(double)expenditure;
+ (NSMutableArray *)testModelList;

@end
