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

//旋转圆饼
- (void)Transforming:(BOOL)isForward;
//返回被选中模块的信息
- (NSString *)SelectedObejct;

@end
