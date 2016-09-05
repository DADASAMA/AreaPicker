//
//  AddressDBManager.h
//  BuFu
//
//  Created by DADASAMA on 15/4/24.
//  Copyright (c) 2015年 Huifeng Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressDBManager : NSObject
+ (id)shareDBManager;
- (NSMutableArray *)fetchAllProvi;

- (NSMutableArray *)fetchAllCityWith:(NSString *)proviCode;

@end
