//
//  CoreDataEngine.m
//  CoreDataTest
//
//  Created by MacPro.com on 14-8-12.
//  Copyright (c) 2014年 lihongtao. All rights reserved.
//

#import "CoreDataEngine.h"

@implementation CoreDataEngine

+(void)operationWithPath:(NSString *)string params:(NSDictionary *)params completionHandler:(void(^)(NSDictionary *dic,NSError *error))completionHandler
{
    CoreDataEngine *engine=[[CoreDataEngine alloc]initWithHostName:@"api.miaolianwang.com"];
    MKNetworkOperation *netWork =  [engine operationWithPath:@"android/gettime" params:nil httpMethod:@"POST"];
    [netWork addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSLog(@"  result = %@",[completedOperation responseJSON]);
        
        CoreDataEngine *engine1=[[CoreDataEngine alloc]initWithHostName:@"api.miaolianwang.com"];

        MKNetworkOperation *netWork1=  [engine1 operationWithPath:string params:params httpMethod:@"POST"];
        
        [netWork1 addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
           NSDictionary *dic= [completedOperation responseJSON];
            completionHandler(dic,nil);
            
        } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
            completionHandler(nil,error);

        }];

        [engine1 enqueueOperation:netWork1];

        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"  error = %@",[error.userInfo objectForKey:@"NSErrorFailingURLKey"]);
    }];
    [engine enqueueOperation:netWork];
    
}

@end
