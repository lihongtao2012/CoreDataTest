//
//  CoreDataEngine.h
//  CoreDataTest
//
//  Created by MacPro.com on 14-8-12.
//  Copyright (c) 2014年 lihongtao. All rights reserved.
//

#import "MKNetworkEngine.h"

@interface CoreDataEngine : MKNetworkEngine

@property(nonatomic,copy)void(^addd)(int aa);


+(void)operationWithPath:(NSString *)string params:(NSDictionary *)params completionHandler:(void(^)(NSDictionary *dic,NSError *error))completionHandler;

@end
