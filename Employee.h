//
//  Employee.h
//  CoreDataTest
//
//  Created by MacPro.com on 14-8-7.
//  Copyright (c) 2014年 lihongtao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Department;

@interface Employee : NSManagedObject

@property (nonatomic, retain) NSString * employeeNumber;
@property (nonatomic, retain) NSString * love;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * tools;
@property (nonatomic, retain) Department *department;

@end
