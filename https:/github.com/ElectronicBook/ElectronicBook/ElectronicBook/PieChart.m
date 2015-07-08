//
//  PieChart.m
//  AnimationTest
//
//  Created by 你 on 15-7-6.
//  Copyright (c) 2015年 wonder. All rights reserved.
//

#import "PieChart.h"

@interface PieChart()

@property (strong, nonatomic)NSArray *percent;
@property (assign, nonatomic)NSInteger selected;

@end

@implementation PieChart

- (NSArray *)percent {
    if(_percent == nil) {
        NSMutableArray *per = [[NSMutableArray alloc] init];
        for(int i = 0; i<self.array.count; i++) {
            double p = [self.array[i] doubleValue] / [[self.array valueForKeyPath:@"@sum.doubleValue"] doubleValue];
            [per addObject:[NSNumber numberWithDouble:p]];
        }
        _percent = per;
    }
    return _percent;
}

- (void)drawRect:(CGRect)rect{
    
    self.rect = rect;
    [self drawPieChart];
    
}

//绘制圆饼
- (void)drawPieChart {
    
    double startAngle = 0;
    double endAngle = 0;
    for (int i=0; i<self.array.count; i++) {
        CAShapeLayer *shapeLayer;
        shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = CGRectMake(0, 0, self.rect.size.width, self.rect.size.height);
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        shapeLayer.position = self.center;
        shapeLayer.lineWidth = 100;
        shapeLayer.strokeColor = [UIColor colorWithRed:0 green:i%2 blue:1 alpha:1].CGColor;
        
        endAngle = startAngle + [self.percent[i] doubleValue];
        UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:self.center radius:50 startAngle:2*M_PI*(startAngle+0.25-[self.percent[0] doubleValue]/2) endAngle:2*M_PI*(endAngle+0.25-[self.percent[0] doubleValue]/2) clockwise:YES];
        shapeLayer.path = circlePath.CGPath;
        [self.layer  performSelector:@selector(addSublayer:) withObject:shapeLayer afterDelay:1 * startAngle];
        [self performSelector:@selector(setAnimation:) withObject:@[shapeLayer, [NSNumber numberWithInt:i]] afterDelay:1 * startAngle];
        startAngle = endAngle;
    };
    
}

//设置动画
- (void)setAnimation:(NSArray *)messages{
    CAShapeLayer *layer = [messages objectAtIndex:0];
    int index = [[messages objectAtIndex:1] intValue];
    
    CABasicAnimation *anima = [CABasicAnimation animation];
    anima.keyPath = @"strokeEnd";
//    //设置延迟两秒播放动画
//    anima.beginTime = 2 + CACurrentMediaTime();
    anima.duration = 1 * [self.percent[index] doubleValue];
    anima.fromValue = [NSNumber numberWithInteger:0];
    anima.toValue = [NSNumber numberWithInteger:1];
    [layer addAnimation:anima forKey:nil];
}

//设置旋转角度
- (void)Transforming:(BOOL)isForward {
    //offset 表示selected的前一个(顺时针滚动)或后一个(逆时针滚动)元素
    NSInteger offset = isForward ? (_selected+1)%self.percent.count : (_selected-1+self.percent.count)%self.percent.count;
    //旋转，旋转值为selected和offset所占总角度的一半
    self.transform = CGAffineTransformRotate(self.transform,(isForward? -1:1) * M_PI * ([self.percent[_selected] doubleValue] + [self.percent[offset] doubleValue]));
    //完成偏移
    _selected = offset;
}

//返回被选中元素的信息
- (NSString *)SelectedObejct {
    NSString *str = [NSString stringWithFormat:@"%.2lf  %.2lf%%",[self.array[_selected] doubleValue],[self.percent[_selected] doubleValue] *100];
    return str;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
