//
//  SecondViewController.h
//  CoreDataTest
//
//  Created by MacPro.com on 14-8-6.
//  Copyright (c) 2014年 lihongtao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Department.h"

@interface SecondViewController : UITableViewController

@property(nonatomic,strong)Department *managedObject;
@property(nonatomic,strong)NSManagedObjectContext *managedObjectContext;

@end
