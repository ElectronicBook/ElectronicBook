//
//  ThirdViewController.m
//  ElectronicBook
//
//  Created by 你 on 15-6-30.
//  Copyright (c) 2015年 wonder. All rights reserved.
//

#import "ThirdViewController.h"
#import "MyView.h"
#import "testModel.h"
#import "ChartSet.h"

@interface ThirdViewController ()<drawChartDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *chartScrollView;
@property (strong, nonatomic) NSMutableArray *lineChartList;
@property (strong, nonatomic) MyView *drawView;

@end

@implementation ThirdViewController

- (NSMutableArray *)lineChartList {
    _lineChartList = [testModel testModelList];
    return _lineChartList;
}

//实现ChartSet的代理方法，进行绘制
- (void)drawChartWithChartType:(EBChartType)type andTime:(NSInteger)time {
    
    if (self.drawView!=nil) {
        [self.drawView removeFromSuperview];
    }
    self.drawView = [[MyView alloc] init];
    if (type == EBPieChart) {
        [self.drawView setFrame:CGRectMake(0, 0, self.chartScrollView.frame.size.width, self.chartScrollView.frame.size.height)];
    } else {
        [self.drawView setFrame:CGRectMake(0, 0, 100*self.lineChartList.count, self.chartScrollView.frame.size.height)];
    }
    
    [self.drawView setBackgroundColor:[UIColor clearColor]];
    self.drawView.array = self.lineChartList;
    self.drawView.type = type;
    
    self.chartScrollView.contentSize = self.drawView.frame.size;
    self.chartScrollView.bounces = NO;
    
    [self.chartScrollView addSubview:self.drawView];
}

//跳转到设置界面
- (void)searchEdit {
    ChartSet *chartSet = [[ChartSet alloc] initWithNibName:@"ChartSet" bundle:nil];
    chartSet.delegate = self;
    [self presentViewController:chartSet animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
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
