//
//  Dropdown.h
//  dropdown
//
//  Created by 你 on 15-7-9.
//  Copyright (c) 2015年 wonder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Dropdown : UIView <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong) NSArray *menuArray;
@property (nonatomic, strong) UITextField *textField;

@end
