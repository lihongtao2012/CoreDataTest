//
//  Department.h
//  CoreDataTest
//
//  Created by MacPro.com on 14-8-7.
//  Copyright (c) 2014年 lihongtao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Employee;

@interface Department : NSManagedObject

@property (nonatomic, retain) NSString * idCard;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * spirit;
@property (nonatomic, retain) NSSet *employee;
@end

@interface Department (CoreDataGeneratedAccessors)

- (void)addEmployeeObject:(Employee *)value;
- (void)removeEmployeeObject:(Employee *)value;
- (void)addEmployee:(NSSet *)values;
- (void)removeEmployee:(NSSet *)values;

@end
