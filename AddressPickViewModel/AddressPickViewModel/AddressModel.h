//
//  addressModel.h
//  BuFu
//
//  Created by DADASAMA on 15/4/24.
//  Copyright (c) 2015年 Huifeng Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressModel : NSObject

@property (nonatomic, copy) NSString *rowid;
@property (nonatomic, copy) NSString *addcode;
@property (nonatomic, copy) NSString *long_name;
@property (nonatomic, copy) NSString *parent_code;
@property (nonatomic, copy) NSString *short_name;

@end
