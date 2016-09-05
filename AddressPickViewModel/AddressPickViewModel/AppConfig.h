//
//  AppConfig.h
//  BuFu
//
//  Created by luonaigao on 15/3/30.
//  Copyright (c) 2015年 Huifeng Technology Co.,Ltd. All rights reserved.
//

#ifndef BuFu_AppConfig_h
#define BuFu_AppConfig_h
//程序的一些字典定义在里面，比如用到的第三方的Key,程序的字体、颜色，

// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//带有RGBA的颜色设置
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

//随机色
#define RandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]


#define ViewBgColor [UIColor colorWithRed:0.93f green:0.93f blue:0.93f alpha:1.00f]
#define fenhongColor [UIColor colorWithRed:1.00f green:0.26f blue:0.46f alpha:1.00f]
#define fontqhColor [UIColor colorWithRed:0.79f green:0.80f blue:0.79f alpha:1.00f]

#define SYSTEMVERSION           [[[UIDevice currentDevice] systemVersion] floatValue]
#define SCREENHEIGHT            ([[UIScreen mainScreen] bounds].size.height -20)
#define MYSCREENHEIGHT          [[UIScreen mainScreen] bounds].size.height
#define MYSCREENWIDTH           [[UIScreen mainScreen] bounds].size.width
#define CONTROLWIDTH            640.0
#define CONTROLHEIGHT           1138.0
#define HEADBARCOLOR            [UIColor colorWithRedFloat:79.0f greenFloat:105.0f blueFloat:127.0f alphaFloat:255.0f]
#define BACKGROUNDCOLOR         [UIColor colorWithRedFloat:241.0f greenFloat:241.0f blueFloat:241.0f alphaFloat:255.0f]

#define TOPBARHEIGHT            64
#define BOTTOMBARHEIGHT         50

#define UBSPAudioTempFolderPath ([NSString stringWithFormat:@"%@audio",NSTemporaryDirectory()])
#define UBSPAudioFolderPath     ([NSString stringWithFormat:@"%@/audio",[NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0]])
typedef enum : NSUInteger {
    UBSP_Business_NOCOMMIT = 1,
    UBSP_Business_WAITCHECK,
    UBSP_Business_PASS,
    UBSP_Business_NOPASS,
} BusinessCheckType;

typedef enum : NSUInteger {
    UBSP_TEXT = 1,
    UBSP_RECORD,
    UBSP_IMAGE,
    UBSP_LOCATION,
} UBSP_CHECK_CONDITION;

static NSString *const Key_BMapAK = @"siilRDCC7RyCRikQInQVNxmL";


#define judgeStr(str)     [Tools judgeStr:str]



#endif










