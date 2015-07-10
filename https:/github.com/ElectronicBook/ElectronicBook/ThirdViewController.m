//
//  ThirdViewController.m
//  ElectronicBook
//
//  Created by 你 on 15-6-30.
//  Copyright (c) 2015年 wonder. All rights reserved.
//

#import "ThirdViewController.h"
#import "AppDelegate.h"
#import "ChartSet.h"
#import "LineChart.h"
#import "CountData.h"
#import "PieChartController.h"
#import "HistogramController.h"

@interface ThirdViewController ()<drawChartDelegate>

@property (strong, nonatomic) NSMutableArray *chartList;
@property (strong, nonatomic) UIViewController *chartController;

@end

@implementation ThirdViewController

//绘制圆饼图界面(委托)
- (void)drawPieChartWithTime:(NSDictionary *)time {
    //删除已有视图
    [self deleteChartControllerView];
    //创建圆饼图界面并将界面添加到view中
    PieChartController *pieController = [[PieChartController alloc]initWithNibName:@"PieChartController" bundle:nil];
    //这里在调用完setFrame时就会执行pieController的viewDidLoad方法，所以要在setFrame之前对time进行赋值
    pieController.time = time;
    [pieController.view setFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height-120)];
    [self.view addSubview:pieController.view];
    [self addChildViewController:pieController];
    self.chartController = pieController;
}

//绘制柱状图界面(委托)
- (void)drawHistogramWithTime:(NSDictionary *)time andType:(NSString *)type {
    //删除已有视图
    [self deleteChartControllerView];
    //创建柱状图界面并将界面添加到view中
    HistogramController *hisController = [[HistogramController alloc]initWithNibName:@"HistogramController" bundle:nil];
    //这里在调用完setFrame时就会执行pieController的viewDidLoad方法，所以要在setFrame之前对time进行赋值
    hisController.time = time;
    [hisController.view setFrame:CGRectMake(10, 60, self.view.frame.size.width-20, self.view.frame.size.height-120)];
    [self.view addSubview:hisController.view];
    [self addChildViewController:hisController];
    self.chartController = hisController;
}

////绘制折线图界面(委托)
//- (void)drawLineChartWithTime:(NSDictionary *)time {
//    LineChart *chart = [[LineChart alloc] init];
//    chart.array = [CountData countLineChart:time andIsIncome:NO];
//    [chart setFrame:CGRectMake(0, 0, 375,self.chartScrollView.frame.size.height)];
//    [self viewSet:chart];
//}

//如果视图已存在，则删除已有视图
- (void)deleteChartControllerView {
    if(self.chartController != nil) {
        [self.chartController.view removeFromSuperview];
        [self.chartController removeFromParentViewController];
        self.chartController = nil;
    }
}

//跳转到设置界面
- (void)searchEdit {
    ChartSet *chartSet = [[ChartSet alloc] initWithNibName:@"ChartSet" bundle:nil];
    chartSet.delegate = self;
    [self presentViewController:chartSet animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置navigationBar的title
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationItem setTitle:@"图表绘制"];
    
    //设置navigationBar的rightBarButton
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 32, 32)];
    [button setImage:[UIImage imageNamed:@"editWhite"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"editBlack"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(searchEdit) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
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
