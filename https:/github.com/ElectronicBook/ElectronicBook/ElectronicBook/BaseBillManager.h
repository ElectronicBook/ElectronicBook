//
//  BaseBillManager.h
//  CoreDataTest
//
//  Created by 你 on 15-7-3.
//  Copyright (c) 2015年 wonder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface BaseBillManager : NSObject

@property (strong, nonatomic)NSString *tableName;

@property (readonly, strong, nonatomic)NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic)NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic)NSPersistentStoreCoordinator *persistentStoreCoordinator;

//初始化并选择需要读取的表名
- (instancetype)initWithTableName:(NSString *)tableName;
//获取上下文
- (void)saveContext;
//插入数据
- (NSManagedObject *)createBill;
//查询
- (NSMutableArray *)selectBills:(NSPredicate *)predicate;
//删除
- (void)deleteBills:(NSArray *)billsArray;
//更新
- (void)saveBill;

@end
