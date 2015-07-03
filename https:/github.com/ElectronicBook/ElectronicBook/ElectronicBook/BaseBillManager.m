//
//  BaseBillManager.m
//  CoreDataTest
//
//  Created by 你 on 15-7-3.
//  Copyright (c) 2015年 wonder. All rights reserved.
//

#import "BaseBillManager.h"

@implementation BaseBillManager

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

//初始化并获取需要读取的表名
- (instancetype)initWithTableName:(NSString *)tableName {
    self = [super init];
    self.TableName = tableName;
    return self;
}

//获取上下文
- (void)saveContext {
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if(managedObjectContext !=nil) {
        if([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@",error,[error userInfo]);
            abort();
        }
    }
}

#pragma mark - 属性懒加载

- (NSManagedObjectContext *)managedObjectContext {
    if(_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = self.persistentStoreCoordinator;
    if(coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel {
    if(_managedObjectModel !=nil) {
        return _managedObjectModel;
    }
//    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"NewsModel" withExtension:@"momd"];
//    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if(_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.data",self.tableName]];
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    if(![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"Unresolved error %@, %@",error,[error userInfo]);
        abort();
    }
    return _persistentStoreCoordinator;
}

#pragma mark - 数据库操作

//获取程序文件地址
- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

//创建
- (NSManagedObject *)createBill{
    NSManagedObjectContext *context = self.managedObjectContext;
    NSManagedObject *newBill = [NSEntityDescription insertNewObjectForEntityForName:self.tableName inManagedObjectContext:context];
    NSError *error = nil;
    if(![context save:&error]) {
        NSLog(@"创建失败: %@",error);
        return nil;
    }
    return newBill;
}

//查询
- (NSMutableArray *)selectBills:(NSPredicate *)predicate {
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:self.tableName inManagedObjectContext:context]];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO];
    [request setSortDescriptors:[NSArray arrayWithObject:sort]];
    [request setPredicate:predicate];
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:request error:&error];
    if(error) {
        NSLog(@"查询失败: %@",[error localizedDescription]);
        return nil;
    }
    
    NSMutableArray *results = [NSMutableArray array];
    for(NSManagedObject *bill in fetchedObjects) {
        [results addObject:bill];
    }
    return  results;
}

//删除
- (void)deleteBills:(NSArray *)billsArray {
    NSManagedObjectContext *context = self.managedObjectContext;
    for (NSManagedObject *bill in billsArray) {
        [context deleteObject:bill];
    }
    NSError *error = nil;
    if(![context save:&error]) {
        NSLog(@"删除失败: %@",error);
    }
}

//保存
- (void)saveBill{
    NSManagedObjectContext *context = self.managedObjectContext;
    NSError *error = nil;
    if(![context save:&error]) {
        NSLog(@"保存失败: %@",[error localizedDescription]);
    }
}


@end
