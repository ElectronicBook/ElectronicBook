//
//  HistogramController.m
//  ElectronicBook
//
//  Created by 你 on 15-7-10.
//  Copyright (c) 2015年 wonder. All rights reserved.
//

#import "HistogramController.h"
#import "Dropdown.h"
#import "Histogram.h"
#import "CountData.h"
#import "AppDelegate.h"

@interface HistogramController ()

@property (strong, nonatomic) UIView *histogram;
@property (strong, nonatomic) Dropdown *typeMenu;

@end

@implementation HistogramController

- (void)drawHistogram:(NSString *)type {
    Histogram *chart = [[Histogram alloc] init];
    [chart setFrame:CGRectMake(0, 100, self.view.frame.size.width-20, self.view.frame.size.height - 200)];
    NSLog(@"%lf, %lf",self.view.frame.size.height, self.view.frame.size.width);
    chart.backgroundColor = [UIColor clearColor];
    chart.array = [CountData countHistogram:self.time andType:type];;
    [self.view addSubview:chart];
    self.histogram = chart;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //设置背景色为透明
    [self.view setBackgroundColor:[UIColor clearColor]];
    //设置Dropdown
    self.typeMenu = [[Dropdown alloc] initWithFrame:CGRectMake((self.view.frame.size.width-235)/2, 50, 235, 50)];
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObjectsFromArray:delegate.incomeType];
    [arr addObjectsFromArray:delegate.expenditureType];
    self.typeMenu.menuArray = arr;
    self.typeMenu.textField.text = arr[0];
    [self.view addSubview:self.typeMenu];
    //绘制柱状图
    [self drawHistogram:arr[0]];
    [self.view bringSubviewToFront:self.typeMenu];
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
