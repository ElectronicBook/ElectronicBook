//
//  ChartSet.m
//  ElectronicBook
//
//  Created by 你 on 15-7-4.
//  Copyright (c) 2015年 wonder. All rights reserved.
//

#import "ChartSet.h"

@interface ChartSet ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong, nonatomic) NSArray *drawType;
@property (strong, nonatomic) NSArray *time;

@end

@implementation ChartSet

- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if(condense == 0) {
        return self.drawType.count;
    } else {
        return self.time.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if(component == 0) {
        return [self.drawType objectAtIndex:row];
    } else {
        return [self.time objectAtIndex:row];
    }
}

- (IBAction)draw {
    NSInteger drawType = [self.pickerView selectedRowInComponent:0];
    NSInteger time = [self.pickerView selectedRowInComponent:1];
    
    //设置代理来绘制图形
    if ([self.delegate respondsToSelector:@selector(drawChartWithChartType:andTime:)]) {
        [self.delegate drawChartWithChartType:drawType andTime:time];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.pickerView.delegate = self;
    self.drawType = @[@"柱状图",@"折线图",@"圆饼图"];
    self.time = @[@"日",@"月",@"年"];
    
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
