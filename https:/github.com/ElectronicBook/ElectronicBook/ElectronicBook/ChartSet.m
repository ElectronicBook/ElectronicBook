//
//  ChartSet.m
//  ElectronicBook
//
//  Created by 你 on 15-7-4.
//  Copyright (c) 2015年 wonder. All rights reserved.
//

#import "ChartSet.h"
#import "Dropdown.h"
#import "TimeManager.h"

@interface ChartSet ()

@property (strong, nonatomic) NSArray *drawType;
@property (strong, nonatomic) NSArray *time;

@property (weak, nonatomic) IBOutlet UIDatePicker *beginDatePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *endDatePicker;
@property (strong, nonatomic) Dropdown *chartTypeMenu;
@property (strong, nonatomic) Dropdown *timeIntervalMenu;

@end

@implementation ChartSet



//返回按钮
- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//绘制按钮的点击事件
- (IBAction)draw {
    NSString *type = self.chartTypeMenu.textField.text;
    NSString *timeInterval = self.timeIntervalMenu.textField.text;
    
    NSDate *beginDate = [TimeManager dateClearTime:[self.beginDatePicker date]withTimeIntervalType:timeInterval];
    NSDate *endDate = [TimeManager dateClearTime:[self.endDatePicker date]withTimeIntervalType:timeInterval];
    endDate = [TimeManager nextDate:endDate AddTimeIntervalType:timeInterval];

    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:beginDate,@"beginDate",endDate,@"endDate",timeInterval,@"timeInterval", nil];
    if([type isEqualToString:@"圆饼图"]) {
        if([self.delegate respondsToSelector:@selector(drawPieChartWithTime:)]) {
            [self.delegate drawPieChartWithTime:dic];
        }
    } else if([type isEqualToString:@"柱状图"]) {
        if([self.delegate respondsToSelector:@selector(drawHistogramWithTime:andType:)]) {
            [self.delegate drawHistogramWithTime:dic andType:@""];
        }
    } else {
        if([self.delegate respondsToSelector:@selector(drawLineChartWithTime:)]) {
            [self.delegate drawLineChartWithTime:dic];
        }
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.timeIntervalMenu = [[Dropdown alloc] initWithFrame:CGRectMake(50, 160, self.view.frame.size.width-100, 30)];
    self.timeIntervalMenu.menuArray = @[@"年",@"月",@"日"];
    [self.view addSubview:self.timeIntervalMenu];
    self.chartTypeMenu = [[Dropdown alloc] initWithFrame:CGRectMake(50, 100, self.view.frame.size.width-100, 30)];
    self.chartTypeMenu.menuArray = @[@"柱状图", @"折线图", @"圆饼图"];
    [self.view addSubview:self.chartTypeMenu];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
