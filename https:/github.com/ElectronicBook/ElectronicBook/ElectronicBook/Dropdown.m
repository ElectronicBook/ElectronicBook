//
//  Dropdown.m
//  dropdown
//
//  Created by 你 on 15-7-9.
//  Copyright (c) 2015年 wonder. All rights reserved.
//

#import "Dropdown.h"
#define cellHight 30

@interface Dropdown()

@property (assign,nonatomic) BOOL isShowList;
@property (nonatomic, strong) UITableView *menu;

@end

@implementation Dropdown

- (id)initWithFrame:(CGRect)frame {    
    
    self = [super initWithFrame:frame];
    if(self) {
        self.isShowList = NO;
        
        UITableView *menu = [[UITableView alloc] initWithFrame:CGRectMake(0, cellHight, frame.size.width, 0)];
        menu.delegate = self;
        menu.dataSource = self;
        menu.separatorStyle = UITableViewCellSeparatorStyleNone;   //设置边界线类别
        menu.bounces = NO;
        menu.hidden = YES;
        self.menu = menu;
        [self addSubview:menu];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, cellHight)];
        
        [textField setBorderStyle:UITextBorderStyleRoundedRect];
        [textField addTarget:self action:@selector(dropdown) forControlEvents:UIControlEventAllTouchEvents];
        textField.delegate = self;
        self.textField = textField;
        [self addSubview:textField];
    }
    return self;
}

//隐藏键盘
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return NO;
}

//点击textField的事件
- (void)dropdown {
    //如果下拉菜单已显示，则隐藏下拉菜单
    if(self.isShowList) {
        [self menuHiden];
        return;
    }
    //如果下拉菜单没有显示，则显示下拉菜单
    [self bringSubviewToFront:self.menu];
    self.menu.hidden = NO;
    self.isShowList = YES;
    
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    CGRect frame = self.frame;
    frame.size.height = (self.menuArray.count + 1) * cellHight;
    self.frame = frame;
    self.menu.frame = CGRectMake(0, cellHight, self.frame.size.width, self.frame.size.height-cellHight);
    [UIView commitAnimations];
    
}

//tableView的设置
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.menuArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [self.menuArray objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return cellHight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.textField setText:[self.menuArray objectAtIndex:indexPath.row]];
    
    [self menuHiden];
}

//隐藏下拉菜单
- (void)menuHiden {
    self.isShowList = NO;
    self.menu.hidden = YES;
    CGRect frame = self.frame;
    frame.size.height = cellHight;
    self.frame = frame;
    self.menu.frame = CGRectMake(0, cellHight, self.frame.size.width, 0);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
