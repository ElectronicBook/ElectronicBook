//
//  ChartSet.h
//  ElectronicBook
//
//  Created by 你 on 15-7-4.
//  Copyright (c) 2015年 wonder. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  NS_ENUM(NSInteger, EBChartType) {
    EBHistogram = 0,
    EBLineChart = 1,
    EBPieChart = 2,
};

@protocol drawChartDelegate <NSObject>

@optional

- (void)drawPieChartWithTime:(NSDictionary *)time;
- (void)drawHistogramWithTime:(NSDictionary *)time andType:(NSString *)type;
- (void)drawLineChartWithTime:(NSDictionary *)time;

@end

@interface ChartSet : UIViewController

@property (assign, nonatomic) id<drawChartDelegate> delegate;

@end
