//
//  ViewController.m
//  AddressPickViewModel
//
//  Created by DADASAMA on 15/8/12.
//  Copyright (c) 2015年 huifeng. All rights reserved.
//

#import "ViewController.h"
#import "AppConfig.h"
#import "AddressPickView.h"
@interface ViewController (){
    UILabel *_areaShow;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self uiConfig];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)uiConfig{
   UIButton *_pickBtn = [[UIButton alloc]init];
    _pickBtn.frame = CGRectMake(MYSCREENWIDTH/2-50, 150, 100, 30);
    _pickBtn.backgroundColor = [UIColor colorWithRed:1 green:0.77 blue:0 alpha:1];
    [_pickBtn addTarget:self action:@selector(pickBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_pickBtn setTitle:@"地区选择器" forState:UIControlStateNormal];
    [_pickBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _pickBtn.layer.cornerRadius = 5;
    _pickBtn.layer.masksToBounds = YES;
    [self.view addSubview:_pickBtn];
    
    _areaShow = [[UILabel alloc]init];
    _areaShow.frame = CGRectMake(MYSCREENWIDTH/2-50, 200, 100, 30);
    _areaShow.textColor = [UIColor blackColor];
    _areaShow.textAlignment = NSTextAlignmentCenter;
    _areaShow.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:_areaShow];
}




-(void)pickBtnAction:(UIButton *)sender{
    AddressPickView *apv = [[AddressPickView alloc]init];
    [apv setAddressResult:^(NSDictionary *addressDict) {
        _areaShow.text = [NSString stringWithFormat:@"%@  %@" , addressDict[@"proName"],addressDict[@"cityName"]];
        NSLog(@"%@--%@---%@--%@",addressDict[@"proName"],addressDict[@"proId"],addressDict[@"cityName"],addressDict[@"cityId"]);
    }];
    [self.view addSubview:apv];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
