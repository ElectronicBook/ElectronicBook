//
//  ChartSet.h
//  ElectronicBook
//
//  Created by 你 on 15-7-4.
//  Copyright (c) 2015年 wonder. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  NS_ENUM(NSInteger, EBChartType) {
    EBHistogram = 1,
    EBLineChart = 2,
    EBPieChart = 3,
};

@protocol drawChartDelegate <NSObject>

@optional

- (void)drawChartWithChartType:(EBChartType)type andTime:(NSInteger)time;

@end

@interface ChartSet : UIViewController

@property (assign, nonatomic) id<drawChartDelegate> delegate;

@end
