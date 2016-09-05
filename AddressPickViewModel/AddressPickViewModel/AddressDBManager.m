//
//  AddressDBManager.m
//  BuFu
//
//  Created by DADASAMA on 15/4/24.
//  Copyright (c) 2015年 Huifeng Technology Co.,Ltd. All rights reserved.
//

#import "AddressDBManager.h"
#import "FMDatabase.h"
#import "AddressModel.h"
@implementation AddressDBManager
{
    FMDatabase *db;
}


+(instancetype )shareDBManager
{
    static AddressDBManager *_m = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _m = [[AddressDBManager alloc] init];
    });
    return _m;
}

- (id)init
{
    self = [super init];
    if (self) {
        NSString *dbPath=[[NSBundle mainBundle] pathForResource:@"address" ofType:@"db"];
        db = [[FMDatabase alloc]init];
        db = [FMDatabase databaseWithPath:dbPath];
        //先判断数据库是否存在，如果不存在，创建数据库
        if (!db) {
            db = [FMDatabase databaseWithPath:dbPath];
        }
        //判断数据库是否已经打开，如果没有打开，提示失败
        if (![db open]) {
            NSLog(@"数据库打开失败");
        }
        
        //为数据库设置缓存，提高查询效率
        [db setShouldCacheStatements:YES];
    }
    return self;
}
- (NSMutableArray *)fetchAllProvi{

    NSString *allArea = [NSString stringWithFormat:@"select * from address where parent_code = '0'"];
    FMResultSet *rsProvi = [db executeQuery:allArea];
    
    NSMutableArray *proviArray = [[NSMutableArray alloc]init];
    while ([rsProvi next]) {
        AddressModel *addressm = [[AddressModel alloc] init];
        addressm.addcode = [rsProvi stringForColumn:@"code"];
        addressm.short_name = [rsProvi stringForColumn:@"short_name"];
        [proviArray addObject:addressm];
    }

    return proviArray;
    
    
    

}

- (NSMutableArray *)fetchAllCityWith:(NSString *)proviCode{

    NSMutableArray *arr = [[NSMutableArray alloc] init];
    NSString *sql = [NSString stringWithFormat:@"select * from address where parent_code = %@",proviCode];
//    NSLog(@"asfdsghgf%@" , sql);
    //集合
    FMResultSet *set = [db executeQuery:sql];
    //set 是一个指针  指向这个集合的第0个元素之前
    while ([set next]) {
        NSString *addcode = [set stringForColumn:@"code"];
        NSString *short_name = [set stringForColumn:@"short_name"];
        
        AddressModel *model = [[AddressModel alloc] init];
        model.addcode = addcode;
        model.short_name = short_name;
        [arr addObject:model];
    }
    return arr;
    
    
}


@end














