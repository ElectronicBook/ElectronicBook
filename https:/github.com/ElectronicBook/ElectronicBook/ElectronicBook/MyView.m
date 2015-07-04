//
//  MyView.m
//  chartTest
//
//  Created by 你 on 15-7-1.
//  Copyright (c) 2015年 wonder. All rights reserved.
//

#import "MyView.h"
#define PI 3.1415926                    //圆周率
#define ARC4RANDOM_MAX 0x100000000      //arc4random()随机数的最大值，是rand()最大值的两倍
#define BeginPosition 25                //x轴开始位置
#define Interval 100                    //间隔

@interface MyView()

@property(assign, nonatomic) int total;                //总数值，用于计算柱状图高度和圆饼图百分比
@property(assign, nonatomic) CGContextRef ctx;         //设备上下文
@property(assign, nonatomic) CGRect rect;              //画板(view)大小

@end

@implementation MyView

- (void)drawRect:(CGRect)rect {
    
    if(self.array==nil) {
        return;
    }
    
    self.rect = rect;
    
    self.ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(self.ctx, kCGLineCapRound);       //线段头尾部样式
    CGContextSetLineJoin(self.ctx, kCGLineJoinRound);     //线段转折点样式
    
    self.total = 0;
    for (int i=0; i<self.array.count; i++) {
        self.total += [[self.array[i] valueForKey:@"expenditure" ] intValue];
    }
    
    switch (self.type) {
        case EBHistogram:
            [self drawHistogram]; break;
        case EBLineChart:
            [self drawLineChart]; break;
        case EBPieChart:
            [self drawPieChart]; break;
        default:
            break;
    }
}

//计算柱状图和折线图的高度
- (CGFloat)height:(int) i{
    double max = [[self.array valueForKeyPath:@"@max.expenditure.doubleValue"] doubleValue];
    double min = [[self.array valueForKeyPath:@"@min.expenditure.doubleValue"] doubleValue];
    CGFloat middle = (double)(max+min)/2;
    CGFloat height = [[self.array[i] valueForKey:@"expenditure"] doubleValue] * (self.rect.size.height-150) / (2 * middle);
    return height;
}

//绘制柱状图
- (void)drawHistogram {
    //绘制图形
    CGContextSetRGBFillColor(self.ctx, 1, 0, 0, 1);
    for(int i=0; i<self.array.count; i++) {
        CGRect iRect = CGRectMake(BeginPosition+i*Interval, self.rect.size.height - [self height:i]-100, 50, [self height:i]);
        CGContextFillRect(self.ctx, iRect);
    }
    //绘制文本
    for (int i=0; i<self.array.count; i++) {
        [self drawChartText:CGRectMake(BeginPosition+i*Interval, self.rect.size.height - [self height:i]-125, 50, 20) andAlignment:NSTextAlignmentCenter andString:[[self.array[i] valueForKey:@"expenditure"] stringValue]];
    }
    //绘制坐标
    [self drawHorizontalCoordinates];
}

//绘制折线图
- (void)drawLineChart {
    //绘制横坐标
    [self drawHorizontalCoordinates];
    //绘制折线
    CGContextSetLineWidth(self.ctx, 3);
    CGContextSetRGBStrokeColor(self.ctx, 1, 0, 0, 1);
    CGContextMoveToPoint(self.ctx, BeginPosition+0.25*Interval, self.rect.size.height - [self height:0]-100);
    for (int i=1; i<self.array.count; i++) {
        CGContextAddLineToPoint(self.ctx, BeginPosition+(i+0.25)*Interval, self.rect.size.height - [self height:i]-100);
    }
    CGContextStrokePath(self.ctx);
    //绘制点
    CGContextSetLineWidth(self.ctx, 10);
    CGContextSetRGBStrokeColor(self.ctx, 0, 1, 0, 1);
    for (int i=0; i<self.array.count; i++) {
        CGFloat height = self.rect.size.height - [self height:i]-100;
        CGContextMoveToPoint(self.ctx, BeginPosition+(i+0.25)*Interval, height);
        CGContextAddLineToPoint(self.ctx, BeginPosition+(i+0.25)*Interval, height);
    }
    CGContextStrokePath(self.ctx);
    //绘制文本
    for (int i=0; i<self.array.count; i++) {
        [self drawChartText:CGRectMake(BeginPosition+i*Interval, self.rect.size.height - [self height:i]-125, 50, 20) andAlignment:NSTextAlignmentCenter andString:[[self.array[i] valueForKey:@"expenditure"] stringValue]];
    }
}

//绘制圆饼图
- (void)drawPieChart {
    //绘制图形
    CGContextSetLineWidth(self.ctx, 5);
    CGContextMoveToPoint(self.ctx, 110, 150);
    double lastAngle = 0;
    for (int i=0; i<self.array.count; i++) {
        CGContextSetRGBFillColor(self.ctx, (CGFloat)arc4random()/ARC4RANDOM_MAX, (CGFloat)arc4random()/ARC4RANDOM_MAX, (CGFloat)arc4random()/ARC4RANDOM_MAX, 1);
        CGContextAddArc(self.ctx, 110, 150, 100, lastAngle, lastAngle-2*PI*[[self.array[i] valueForKey:@"expenditure"] doubleValue]/self.total, 1);
        lastAngle = lastAngle-2*PI*[[self.array[i] valueForKey:@"expenditure"] doubleValue]/self.total;
        CGContextClosePath(self.ctx);
        CGRect iRect = CGRectMake(250, 5+i*30, 20, 20);
        CGContextAddRect(self.ctx, iRect);
        CGContextFillPath(self.ctx);
        CGContextMoveToPoint(self.ctx, 110, 150);
    }
    //绘制文本
    for (int i=0; i<self.array.count; i++) {
        CGRect iRect = CGRectMake(280, 5+i*30, 50, 20);
        [self drawChartText:iRect andAlignment:NSTextAlignmentLeft andString:[[self.array[i] valueForKey:@"expenditure"] stringValue]];
    }
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
    //画线
    CGContextSetLineWidth(self.ctx, 5);
    CGContextSetRGBStrokeColor(self.ctx, 1, 1, 1, 1);
    CGContextMoveToPoint(self.ctx, 0, self.rect.size.height-100);
    CGContextAddLineToPoint(self.ctx, self.rect.size.width, self.rect.size.height-100);
    CGContextStrokePath(self.ctx);
    //写文本
    for (int i=0; i<self.array.count; i++) {
        NSDate *date = [self.array[i] valueForKey:@"date"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"dd日\n"];
        NSString *str = [formatter stringFromDate:date];
        [self drawChartText:CGRectMake(BeginPosition+i*Interval, self.rect.size.height-75, 50, 100) andAlignment:NSTextAlignmentCenter andString:str];
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
