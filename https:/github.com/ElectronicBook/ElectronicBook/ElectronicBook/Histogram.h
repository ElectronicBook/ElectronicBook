//
//  Histogram.h
//  AnimationTest
//
//  Created by 你 on 15-7-7.
//  Copyright (c) 2015年 wonder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Histogram : UIView

@property (strong, nonatomic) NSArray *array;
@property (assign, nonatomic)CGRect rect;

@property (assign, nonatomic)int BeginPositionX;
@property (assign, nonatomic)int BeginPositionY;
@property (assign, nonatomic)int Interval;

//计算柱状图和折线图的高度
- (CGFloat)height:(int) i;
//绘制文本
- (void)drawChartText:(CGRect)rect andAlignment:(NSTextAlignment)alignment andString:(NSString *)str;
//绘制坐标轴
- (void)drawHorizontalCoordinates;

@end
