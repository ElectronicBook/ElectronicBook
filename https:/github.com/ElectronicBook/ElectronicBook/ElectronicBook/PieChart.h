//
//  PieChart.h
//  AnimationTest
//
//  Created by 你 on 15-7-6.
//  Copyright (c) 2015年 wonder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Histogram.h"

@interface PieChart : Histogram

- (void)Transforming:(BOOL)isForward;
- (NSString *)SelectedObejct;

@end
