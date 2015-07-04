//
//  ChartSet.h
//  ElectronicBook
//
//  Created by 你 on 15-7-4.
//  Copyright (c) 2015年 wonder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyView.h"

@protocol drawChartDelegate <NSObject>

@optional
- (void)drawChartWithChartType:(EBChartType)type andTime:(NSInteger)time;

@end

@interface ChartSet : UIViewController

@property (assign, nonatomic) id<drawChartDelegate> delegate;

@end
