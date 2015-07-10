//
//  AppDelegate.h
//  ElectronicBook
//
//  Created by 你 on 15-6-30.
//  Copyright (c) 2015年 wonder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseBillManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) BaseBillManager *baseBillManager;     //数据库管理器

@property (strong, nonatomic) NSMutableArray *incomeType;           //收入类型
@property (strong, nonatomic) NSMutableArray *expenditureType;      //支出类型

@end

