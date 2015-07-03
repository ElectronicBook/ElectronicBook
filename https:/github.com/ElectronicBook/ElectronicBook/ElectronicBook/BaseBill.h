//
//  BaseBill.h
//  CoreDataTest
//
//  Created by 你 on 15-7-2.
//  Copyright (c) 2015年 wonder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface BaseBill : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * isIncome;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * remark;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSNumber * value;

@end
