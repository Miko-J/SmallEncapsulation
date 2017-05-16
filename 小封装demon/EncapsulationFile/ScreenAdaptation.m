//
//  ScreenAdaptation.m
//  ECGLayoutConstraintDemo
//
//  Created by niujinfeng on 2017/4/26.
//  Copyright © 2017年 tantan. All rights reserved.
//
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#import "ScreenAdaptation.h"

@implementation ScreenAdaptation

+ (instancetype)shareInstance
{
    static ScreenAdaptation *_screenAdaptaion;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _screenAdaptaion = [[ScreenAdaptation alloc] init];
        _screenAdaptaion->_deviceType = [_screenAdaptaion resolutionSize];
    });
    return _screenAdaptaion;
}

#pragma mark: -计算宽度
- (double)autoBase3Dot5Width{
    return [self calculateWidth:320];
}

- (double)autoBase4Dot0Width{
    return [self calculateWidth:320];
}

- (double)autoBase4Dot7Width{
    return [self calculateWidth:375];
}

- (double)autoBase5Dot5Width{
    return [self calculateWidth:414];
}
#pragma mark: -计算高度
- (double)autoBase3Dot5Height{
    return [self calculateHeight : 480];
}

- (double)autoBase4Dot0Height{
    return [self calculateHeight : 568];
}

- (double)autoBase4Dot7Height{
    return [self calculateHeight : 667];
}

- (double)autoBase5Dot5Height{
    return [self calculateHeight : 736];
}
#pragma mark: -字体大小

- (UIFont *)font4Dot7Size: (NSInteger) fontSize{
    return [UIFont systemFontOfSize:[self calculate4Dot7Size:fontSize]] ;
}

- (UIFont *)font5Dot5Size: (NSInteger) fontSize{
    return [UIFont systemFontOfSize:[self calculate5Dot5Size:fontSize]] ;
}
#pragma mark: -基础计算
- (double)calculateWidth: (CGFloat)baseScreenWidth{
    NSInteger sizeType = [self resolutionSize];
    double proportionW = 1.0;
    switch (sizeType) {
        case 0:
            proportionW = 320 / baseScreenWidth;
            break;
        case 1:
            proportionW = 320 / baseScreenWidth;
            break;
        case 2:
            proportionW = 375 / baseScreenWidth;
            break;
        case 3:
            proportionW = 414 / baseScreenWidth;
            break;
        default:
            break;
    }
    return proportionW;
}

- (double)calculateHeight:(CGFloat)baseScreenHeight{
    NSInteger sizeType = [self resolutionSize];
    double proportionH = 1.0;
    NSLog(@"%ld",(long)sizeType);
    switch (sizeType) {
        case 0:
            proportionH = 480 / baseScreenHeight;
            break;
        case 1:
            proportionH = 568 / baseScreenHeight;
            break;
        case 2:
            proportionH = 667 / baseScreenHeight;
            break;
        case 3:
            proportionH = 736 / baseScreenHeight;
            break;
        default:
            break;
    }
    return proportionH;
}
- (double)calculate4Dot7Size: (double) fontSize{
    NSInteger sizeType = [self resolutionSize];
    double size = 0.0;
    NSLog(@"%ld",(long)sizeType);
    switch (sizeType) {
        case 0:
            size = fontSize *0.85333333;
            break;
        case 1:
            size = fontSize *0.85333333;
            break;
        case 2:
            size = fontSize;
            break;
        case 3:
            size = fontSize *1.104;
            break;
        default:
            break;
    }
    return size;
}
- (double)calculate5Dot5Size: (double) fontSize{
    NSInteger sizeType = [self resolutionSize];
    double size = 0.0;
    NSLog(@"%ld",(long)sizeType);
    switch (sizeType) {
        case 0:
            size = fontSize *0.7;
            break;
        case 1:
            size = fontSize *0.7;
            break;
        case 2:
            size = fontSize * 0.9;
            break;
        case 3:
            size = fontSize;
            break;
        default:
            break;
    }
    return size;
}
- (DeviceType)resolutionSize
{
    if (SCREEN_HEIGHT == 480.0f) {
        return Screen3Dot5inch;
    } else if(SCREEN_HEIGHT == 568) {
        return Screen4inch;
    } else if(SCREEN_HEIGHT == 667) {
        return  Screen4Dot7inch;
    } else if(SCREEN_HEIGHT == 736) {
        return Screen5Dot5inch;
    } else
        return UnknownSize;
}

@end
