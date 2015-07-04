//
//  MyView.h
//  chartTest
//
//  Created by 你 on 15-7-1.
//  Copyright (c) 2015年 wonder. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  NS_ENUM(NSInteger, EBChartType) {
    EBHistogram = 0,
    EBLineChart = 1,
    EBPieChart = 2,
};

@interface MyView : UIView

@property (strong, nonatomic) NSArray *array;
@property (assign, nonatomic) EBChartType type;

@end
