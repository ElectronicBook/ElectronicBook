//
//  PieChartController.m
//  ElectronicBook
//
//  Created by 你 on 15-7-9.
//  Copyright (c) 2015年 wonder. All rights reserved.
//

#import "PieChartController.h"
#import "PieChart.h"
#import "CountData.h"
#import "MySehmented.h"

@interface PieChartController ()<ButtonClickDeledate>

@property (weak, nonatomic) IBOutlet UITextField *txtMessage;
@property (strong, nonatomic) PieChart *pieChart;
@property (strong, nonatomic) MySehmented *sehmented;


@end

@implementation PieChartController

//前进后退的点击事件
- (IBAction)buttonClick:(UIButton *)sender {
    [UIView beginAnimations:@"transform" context:nil];
    [UIView setAnimationDuration:1.0];
    if(sender.tag == 100) {
        [self.pieChart Transforming:NO];
    } else {
        [self.pieChart Transforming:YES];
    }
    [self.txtMessage setText:[self.pieChart SelectedObejct]];
    [UIView commitAnimations];
}

//segmented的点击事件
- (IBAction)click {
    BOOL flag = [self.sehmented isEnabledForSegmentAtIndex:0];
    [self drawPieChart:flag];
    [self.sehmented setEnabled:!flag forSegmentAtIndex:0];
    [self.sehmented setEnabled:flag forSegmentAtIndex:1];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //设置背景色为透明
    [self.view setBackgroundColor:[UIColor clearColor]];
    //设置文本不可编辑
    [self.txtMessage setEnabled:NO];
    //设置UISegmentedControl
    self.sehmented = [[MySehmented alloc] initWithMyframe:CGRectMake((self.view.frame.size.width-235)/2, 50, 235, 50)];
    self.sehmented.deledate = self;
    [self.view addSubview:self.sehmented];
    //绘制圆饼图
    [self drawPieChart:YES];

}

- (void)drawPieChart:(BOOL) isIncome{
    //绘制圆饼图
    PieChart *chart = [[PieChart alloc] init];
    [chart setFrame:CGRectMake(0, 100, self.view.frame.size.width,self.view.frame.size.height - 200)];
    chart.backgroundColor = [UIColor clearColor];
    chart.array = [CountData countPieChart:self.time andIsIncome:isIncome];;
    [self.view addSubview:chart];
    self.pieChart = chart;
    //设置文本信息
    [self.txtMessage setText:[self.pieChart SelectedObejct]];
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
