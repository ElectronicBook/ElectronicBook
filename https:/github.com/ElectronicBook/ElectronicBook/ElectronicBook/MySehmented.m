//
//  MySehmented.m
//  ElectronicBook
//
//  Created by 你 on 15-7-10.
//  Copyright (c) 2015年 wonder. All rights reserved.
//

#import "MySehmented.h"

@implementation MySehmented

- (instancetype) initWithMyframe:(CGRect)frame {
    self = [[MySehmented alloc] initWithItems:@[@"收入",@"支出"]];
    [self setFrame:frame];
    NSDictionary *selected = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil];
    [self setTitleTextAttributes:selected forState:UIControlStateDisabled];
    NSDictionary *unselected = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor clearColor], NSForegroundColorAttributeName, nil];
    [self setTitleTextAttributes:unselected forState:UIControlStateNormal];
    [self setDividerImage:[[UIImage alloc] init] forLeftSegmentState:UIControlStateSelected rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self setTintColor:[UIColor whiteColor]];
    [self setBackgroundImage:[UIImage imageNamed:@"segmentedControlUnselected"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self setBackgroundImage:[UIImage imageNamed:@"segmentedControlSelected"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    [self setBackgroundImage:[UIImage imageNamed:@"segmentedControlSelected"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    [self setBackgroundImage:[UIImage imageNamed:@"segmentedControlSelected"] forState:UIControlStateDisabled barMetrics:UIBarMetricsDefault];
    [self setSelectedSegmentIndex:0];
    [self setEnabled:NO forSegmentAtIndex:0];
    
    [self addTarget:self.deledate action:@selector(click) forControlEvents:UIControlEventValueChanged];
    return  self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
