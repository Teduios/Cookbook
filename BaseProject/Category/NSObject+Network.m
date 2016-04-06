//
//  NSObject+Network.m
//  BaseProject
//
//  Created by tarena on 15/12/16.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "NSObject+Network.h"

static AFHTTPSessionManager *manager = nil;

@implementation NSObject (Network)

+ (AFHTTPSessionManager *)sharedAFManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        
        manager.requestSerializer.timeoutInterval = 3;
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html",
                           @"application/json",@"text/plain",@"text/javascript", nil];
//        [manager.requestSerializer setValue:@"" forHTTPHeaderField:@""];

    });
    return manager;
}

+ (id)GET:(NSString *)path parameters:(NSDictionary *)params completionHandle:(void (^)(id, NSError *))completionHandle {
    return [[self sharedAFManager] GET:path parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completionHandle(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionHandle(nil, error);
    }];
}

+ (id)POST:(NSString *)path parameters:(NSDictionary *)params completionHandle:(void (^)(id, NSError *))completionHandle {
    return [[self sharedAFManager] POST:path parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completionHandle(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionHandle(nil, error);                                                                                                                                                                                                                                                                                                
    }];
}
@end
