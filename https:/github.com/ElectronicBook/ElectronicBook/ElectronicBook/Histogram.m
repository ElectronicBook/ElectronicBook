//
//  Histogram.m
//  AnimationTest
//
//  Created by 你 on 15-7-7.
//  Copyright (c) 2015年 wonder. All rights reserved.
//

#import "Histogram.h"
#define BeginPositionX 25
#define BeginPositionY 100
#define Interval 100

@implementation Histogram

//计算柱状图和折线图的高度
- (CGFloat)height:(int) i{
    double max = [[self.array valueForKeyPath:@"@max.doubleValue"] doubleValue];
    double min = [[self.array valueForKeyPath:@"@min.doubleValue"] doubleValue];
    CGFloat middle = (double)(max+min)/2;
    CGFloat height = [self.array[i] doubleValue] * (self.rect.size.height - 20 - BeginPositionY) / (2 * middle);
    return height;
}

//绘制柱状图
- (void)drawHistogram {
    for (int i=0; i<self.array.count; i++) {
        CAShapeLayer *shapeLayer;
        shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = CGRectMake(BeginPositionX+i*Interval, 0, Interval/2, self.rect.size.height - BeginPositionY);
        shapeLayer.backgroundColor = [UIColor clearColor].CGColor;
        shapeLayer.strokeColor = [UIColor redColor].CGColor;
        shapeLayer.lineWidth = Interval/2;
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(Interval/4, self.rect.size.height - BeginPositionY)];
        [path addLineToPoint:CGPointMake(Interval/4, self.rect.size.height - [self height:i] - BeginPositionY)];
        shapeLayer.path = path.CGPath;
        
        [self.layer addSublayer:shapeLayer];
        [self setAnimation:shapeLayer];
    }
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

//绘制文本
- (void)drawChartText:(CGRect)rect andAlignment:(NSTextAlignment)alignment andString:(NSString *)str {
    //字体
    UIFont *font = [UIFont systemFontOfSize:16.0];
    //文本风格
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [paragraphStyle setAlignment:alignment];
    //文本颜色
    UIColor *color = [UIColor whiteColor];
    //打印文本
    [str drawInRect:rect withAttributes:@{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle,NSForegroundColorAttributeName:color}];
}

//绘制横坐标
- (void)drawHorizontalCoordinates {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //画线
    CGContextSetLineWidth(ctx, 5);
    CGContextSetRGBStrokeColor(ctx, 1, 1, 1, 1);
    CGContextMoveToPoint(ctx, 0, self.rect.size.height - BeginPositionY);
    CGContextAddLineToPoint(ctx, self.rect.size.width, self.rect.size.height - BeginPositionY);
    CGContextStrokePath(ctx);
    //写文本
    for (int i=0; i<self.array.count; i++) {
//        NSDate *date = [self.array[i] valueForKey:@"date"];
//        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//        [formatter setDateFormat:@"dd日\n"];
//        NSString *str = [formatter stringFromDate:date];
        NSString *str = [self.array[i] stringValue];
        [self drawChartText:CGRectMake(BeginPositionX+i*Interval, self.rect.size.height - BeginPositionY, 50, 100) andAlignment:NSTextAlignmentCenter andString:str];
    }
}

- (void)drawRect:(CGRect)rect {
    self.rect = rect;
    [self drawHistogram];
    [self drawHorizontalCoordinates];
    for (int i=0; i<self.array.count; i++) {
        [self drawChartText:CGRectMake(BeginPositionX+i*Interval, self.rect.size.height - [self height:i]-125, 50, 20) andAlignment:NSTextAlignmentCenter andString:[self.array[i] stringValue]];
    }
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
