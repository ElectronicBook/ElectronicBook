//
//  JHTitleView.m
//  ElectronicBook
//
//  Created by gan on 7/4/15.
//  Copyright (c) 2015 wonder. All rights reserved.
//

#import "JHTitleView.h"

@interface JHTitleView()

- (IBAction)leftArrowButtonClick:(UIButton *) sender;
- (IBAction)rightArrowButtonClick:(UIButton *) sender;
@property (weak, nonatomic) IBOutlet UILabel *timelabel;
@property (nonatomic, strong) NSDate *nowDate;
@end
@implementation JHTitleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib{
    self.timelabel.text = [self getDate:self.nowDate andInterval:0];
}
- (IBAction)leftArrowButtonClick:(UIButton *) sender{
     
    //时间间隔为1天
    NSTimeInterval interval = -24*60*60*1;
    //创建一个新的时间对象，日期为当前日期加上interval
    NSString *dateNeed = [self getDate:self.nowDate andInterval:interval];
    self.timelabel.text = dateNeed;
  //  NSLog(@"日间为:%@", dateNeed);
    
    // 通知代理被点击了
    [self.delegate titleView:self andTitleText:dateNeed];
    
}
- (void)rightArrowButtonClick:(UIButton *)sender{
    //时间间隔为1天
    NSTimeInterval interval = 24*60*60*1;
    //创建一个新的时间对象，日期为当前日期加上interval
    NSString *dateNeed = [self getDate:self.nowDate andInterval:interval];
    self.timelabel.text = dateNeed;
  //  NSLog(@"日间为:%@", dateNeed);
    
    // 通知代理被点击了
    [self.delegate titleView:self andTitleText:dateNeed];


}

- (NSDate *)nowDate{
    if (_nowDate == nil) {
        _nowDate = [[NSDate alloc]init];
    }
    return _nowDate;
}
// 设置日期格式
- (NSString *) getDate: (NSDate *) date andInterval: (NSTimeInterval )interval {
    self.nowDate = [self.nowDate initWithTimeInterval:interval sinceDate:self.nowDate];
    //创建日间初始化对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yy/MM/dd"];
    NSString *dateNeed = [dateFormatter stringFromDate:self.nowDate];
    return dateNeed;
}
@end
