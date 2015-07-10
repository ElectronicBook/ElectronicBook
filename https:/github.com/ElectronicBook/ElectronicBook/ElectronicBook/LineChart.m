//
//  LineChart.m
//  AnimationTest
//
//  Created by 你 on 15-7-7.
//  Copyright (c) 2015年 wonder. All rights reserved.
//

#import "LineChart.h"
#import "Histogram.h"
#define BeginPositionX 25
#define BeginPositionY 100
#define Interval 100

@interface LineChart()

@property (assign, nonatomic)double total;

@end

@implementation LineChart

- (void)drawRect:(CGRect)rect {
    self.rect = rect;
    [self drawLineChart];
    [self drawHorizontalCoordinates];
    for (int i=0; i<self.array.count; i++) {
        [self drawChartText:CGRectMake(BeginPositionX  + (i + 0.25) * Interval - 25, self.rect.size.height - [self height:i] - BeginPositionY - 20, 50, 20) andAlignment:NSTextAlignmentCenter andString:[[self.array[i] valueForKey:@"value" ] stringValue]];
    }
}

//绘制折线图
- (void)drawLineChart {
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, self.rect.size.height - BeginPositionY)];
    for (int i=0; i<self.array.count; i++) {
        [path addLineToPoint:CGPointMake(BeginPositionX + (i + 0.25) * Interval, self.rect.size.height - [self height:i] - BeginPositionY)];
    }
    shapeLayer.path = path.CGPath;
    
    [self.layer addSublayer:shapeLayer];
    [self setAnimation:shapeLayer];
}

//设置动画
- (void)setAnimation:(CAShapeLayer *)layer{
    
    CABasicAnimation *anima = [CABasicAnimation animation];
    anima.keyPath = @"strokeEnd";
    //    //设置延迟两秒播放动画
    //    anima.beginTime = 2 + CACurrentMediaTime();
    anima.duration = 1;
    anima.fromValue = [NSNumber numberWithInteger:0];
    anima.toValue = [NSNumber numberWithInteger:1];
    [layer addAnimation:anima forKey:nil];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
