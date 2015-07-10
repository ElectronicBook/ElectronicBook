//
//  ShowTime.m
//  ElectronicBook
//
//  Created by 你 on 15-7-9.
//  Copyright (c) 2015年 wonder. All rights reserved.
//

#import "ShowTime.h"
#import "Dropdown.h"

@interface ShowTime()

@property (strong, nonatomic) Dropdown *yearMenu;
@property (strong, nonatomic) Dropdown *monthMenu;
@property (strong, nonatomic) Dropdown *dayMenu;

@end

@implementation ShowTime

- (instancetype)initWithFrame:(CGRect)frame andMenuCount:(int)count{
    self = [super initWithFrame:frame];
    //初始化年菜单
    self.yearMenu = [[Dropdown alloc] initWithFrame:CGRectMake(0, 0, frame.size.width/3, frame.size.height)];
    NSMutableArray *yearArr = [NSMutableArray array];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    for (int i = [[formatter stringFromDate:[NSDate date]] intValue];yearArr.count<=20;i--) {
        [yearArr addObject:[NSNumber numberWithInt:i]];
    }
    self.yearMenu.menuArray = yearArr;
    [self addSubview:self.yearMenu];
    //初始化月菜单
    self.monthMenu = [[Dropdown alloc] initWithFrame:CGRectMake(frame.size.width/3, 0, frame.size.width/3, frame.size.height)];
    NSMutableArray *monthArr = [NSMutableArray array];
    for(int i=1; i<=12; i++) {
        [monthArr addObject:[NSNumber numberWithInt:i]];
    }
    self.monthMenu.menuArray = monthArr;
    [self addSubview:self.monthMenu];
    //初始化日菜单
    self.dayMenu = [[Dropdown alloc] initWithFrame:CGRectMake(2*frame.size.width/3, 0, frame.size.width/3, frame.size.height)];
    NSMutableArray *dayArr = [NSMutableArray array];
    for(int i=1; i<31; i++) {
        [dayArr addObject:[NSNumber numberWithInt:i]];
    }
    
    
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
