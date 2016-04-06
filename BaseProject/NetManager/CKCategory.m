//
//  CKCategory.m
//  BaseProject
//
//  Created by tarena on 15/12/19.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "CKCategory.h"

@implementation CKCategory


+ (NSDictionary *)objectClassInArray{
    return @{@"result" : [CKResult class]};
}
- (BOOL)createDataBaseTable {
    
    NSString *docsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *dbPath = [docsPath stringByAppendingPathComponent:@"category.db"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    
    BOOL isSuccess = [db open];
    
    if (!isSuccess) {
        NSLog(@"db 文件打开失败！");
    } else {
        //创建第一张表
        BOOL isSuccess = [db executeUpdate:@"create table if not exists category (id integer primary key, name text)"];
        if (!isSuccess) {
            NSLog(@"category create fail! %@", [db lastError]);
            return NO;
        }
        for (int i = 0; i < self.result.count; i++) {
            CKResult *result = self.result[i];
            isSuccess = [db executeUpdateWithFormat:@"insert into category (name) values(%@)", result.name];
            if (!isSuccess) {
                NSLog(@"创建分类表失败！, %@", [db lastError]);
                return NO;
            }
        }
        
        //创建第二张表
        isSuccess = [db executeUpdate:@"create table if not exists subcategory (tag integer primary key, title text, kind text, parentId text, ID text)"];
        if (!isSuccess) {
            NSLog(@"subcategory create fail! %@", [db lastError]);
            return NO;
        }
        
        for (int i = 0; i < self.result.count; i++) {
            CKResult *result = self.result[i];
            for (int j = 0; j < result.list.count; j++) {
                CKList *list = result.list[j];
                isSuccess = [db executeUpdateWithFormat:@"insert into subcategory (title, kind, parentId, ID) values(%@, %@, %@, %@)", list.name, result.name, list.parentId, list.ID];
                if (!isSuccess) {
                    NSLog(@"创建子分类表失败！, %@", [db lastError]);
                    return NO;
                }
            }
        }
    }
    [db close];
    
    return YES;
}


@end
@implementation CKResult

+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [CKList class]};
}

@end


@implementation CKList

@end


