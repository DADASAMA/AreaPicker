//
//  AddressPickView.h
//  AddressPickViewModel
//
//  Created by DADASAMA on 15/8/13.
//  Copyright (c) 2015年 huifeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressPickView : UIView<UIPickerViewDataSource , UIPickerViewDelegate>

@property (copy , nonatomic) NSString *provId;//省ID
@property (copy , nonatomic) NSString *cityId;//市ID
@property (copy , nonatomic) NSString *provName;//省名称
@property (copy , nonatomic) NSString *cityName;//市名称
@property (copy , nonatomic) NSMutableArray *provArray;//省数组
@property (copy , nonatomic) NSMutableArray *cityArray;//市数组

//字典里包含   省市名称 id
@property (nonatomic,copy) void(^addressResult)(NSDictionary *);


@end
