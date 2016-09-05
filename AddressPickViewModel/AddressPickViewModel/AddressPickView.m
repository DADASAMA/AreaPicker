//
//  AddressPickView.m
//  AddressPickViewModel
//
//  Created by DADASAMA on 15/8/13.
//  Copyright (c) 2015年 huifeng. All rights reserved.
//

#import "AddressPickView.h"
#import "AppConfig.h"
#import "AddressDBManager.h"
#import "AddressModel.h"
#import "ViewController.h"

#define BOTTOMHEIGHT    220
#define TOPBUTTONHEIGHT    40

@interface AddressPickView ()

@property (nonatomic,strong) UIView *bottomView;//承载PickView的View
@property (nonatomic,strong) UIButton *leftBtn;//左边按钮
@property (nonatomic,strong) UIButton *rightBtn;//右边按钮
@property (nonatomic,strong) UIPickerView *addressPickerView;

@end

@implementation AddressPickView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(0, 0, MYSCREENWIDTH, MYSCREENHEIGHT);
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissSelf)];
        [self addGestureRecognizer:tap];
        
        [self prepareData];
        
        [self loadUiConfig];
    }
    return self;
}

#pragma mark -将省市信息放入数组中
- (void)prepareData
{
    _provArray = [[AddressDBManager shareDBManager] fetchAllProvi];
    _provArray = [[_provArray sortedArrayUsingComparator:
                   ^NSComparisonResult(AddressModel *obj1, AddressModel *obj2) {
                       NSComparisonResult result = [obj1.addcode compare:obj2.addcode];
                       return result;
                   }] mutableCopy];
    
    
    _cityArray = [[AddressDBManager shareDBManager] fetchAllCityWith:[_provArray[0] addcode]];
    _provId = @"110100";
    _provName = @"北京";
    _cityId = @"110101";
    _cityName = @"东城";
}

- (void)loadUiConfig
{
    [self addSubview:self.bottomView];
    [UIView animateWithDuration:0.25 animations:^{
        _bottomView.frame = CGRectMake(0, MYSCREENHEIGHT-BOTTOMHEIGHT, MYSCREENWIDTH, BOTTOMHEIGHT);
    }];
}

#pragma mark - 点击空白处让pickView缩回
- (void)dismissSelf
{
    [UIView animateWithDuration:0.2 animations:^{
        _bottomView.frame = CGRectMake(0, MYSCREENHEIGHT, MYSCREENWIDTH, BOTTOMHEIGHT);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}



- (void)rightBtnClick
{
    [self dismissSelf];
    NSDictionary *dict = @{@"proName":_provName,@"proId":_provId,@"cityName":_cityName,@"cityId":_cityId};
    _addressResult(dict);
}



- (UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, MYSCREENHEIGHT, MYSCREENWIDTH, BOTTOMHEIGHT)];
        _bottomView.backgroundColor = [UIColor whiteColor];
        UITapGestureRecognizer *wutap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(noUse)];
        [_bottomView addGestureRecognizer:wutap];
        [_bottomView addSubview:self.leftBtn];
        [_bottomView addSubview:self.rightBtn];
        [_bottomView addSubview:self.addressPickerView];
    }
    return _bottomView;
}
#pragma mark - 点击区域为pickView时不让其缩回
-(void)noUse{
    
}

- (UIButton *)leftBtn
{
    if (!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.frame = CGRectMake(0, 0, 100, TOPBUTTONHEIGHT);
        [_leftBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_leftBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(dismissSelf) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}
- (UIButton *)rightBtn
{
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.frame = CGRectMake(MYSCREENWIDTH-CGRectGetWidth(_leftBtn.frame), 0, CGRectGetWidth(_leftBtn.frame), CGRectGetHeight(_leftBtn.frame));
        [_rightBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}

- (UIPickerView *)addressPickerView
{
    if (!_addressPickerView) {
        _addressPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(_leftBtn.frame), MYSCREENWIDTH, CGRectGetHeight(_bottomView.frame)-CGRectGetHeight(_leftBtn.frame))];
        _addressPickerView.delegate = self;
        _addressPickerView.dataSource = self;
    }
    return _addressPickerView;
}

#pragma mark - 返回显示的列数
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}
#pragma mark - 返回当前列显示的行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return _provArray.count;
    }else
    {
        return _cityArray.count;
    }
}

#pragma mark - 在pickView上展示的信息
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return [_provArray[row] short_name];
    }else
    {
        return [_cityArray[row] short_name];
    }
}

#pragma mark - 绘制PickView
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.minimumScaleFactor = 8.;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15]];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

#pragma mark - 获取选中的地区信息
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        _provId = [_provArray[row] addcode];
        [_cityArray removeAllObjects];
        _cityArray = [[[AddressDBManager shareDBManager] fetchAllCityWith:_provId] mutableCopy];
        
        [pickerView selectedRowInComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:NO];
        [pickerView reloadAllComponents];
        _provName = [_provArray[row] short_name];
        _cityName = _cityArray.count == 0?@"":[_cityArray[0] short_name];
        _cityId = _cityArray.count == 0?@"":[_cityArray[0] addcode];
//        NSLog(@"%@----%@----%@----%@",[_provArray[row] short_name],[_provArray[row] addcode],_cityName,_cityId);
    }
    else
    {
        _cityName = _cityArray.count == 0?@"":[_cityArray[row] short_name];
        _cityId = _cityArray.count == 0?@"":[_cityArray[row] addcode];
//        NSLog(@"%@++++%@++++%@++++%@",_provName,_provId,[_cityArray[row] short_name],[_cityArray[row] addcode]);
    }
}


@end




