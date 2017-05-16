//
//  ScreenAdaptation.h
//  ECGLayoutConstraintDemo
//
//  Created by niujinfeng on 2017/4/26.
//  Copyright © 2017年 tantan. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DeviceType){
    Screen3Dot5inch   = 0,
    Screen4inch       = 1,
    Screen4Dot7inch   = 2,
    Screen5Dot5inch   = 3,
    UnknownSize       = 4
};
@interface ScreenAdaptation : NSObject
//3.5
@property (nonatomic, assign) double autoBase3Dot5Width;

@property (nonatomic, assign) double autoBase3Dot5Height;


//4.0
@property (nonatomic, assign) double autoBase4Dot0Width;

@property (nonatomic, assign) double autoBase4Dot0Height;


//4.7
@property (nonatomic, assign) double autoBase4Dot7Width;

@property (nonatomic, assign) double autoBase4Dot7Height;

//@property (nonatomic, assign) double font4Dot7Size;

- (UIFont *_Nullable)font4Dot7Size: (NSInteger) fontSize;

//5.5
@property (nonatomic, assign) double autoBase5Dot5Width;

@property (nonatomic, assign) double autoBase5Dot5Height;

//@property (nonatomic, assign) double font5Dot5Size;

- (UIFont *_Nullable)font5Dot5Size: (NSInteger) fontSize;


/**  返回一个单例 */
+ (_Nullable instancetype)shareInstance;

/**  当前的设备型号 */
@property (nonatomic,assign,readonly)DeviceType deviceType;

@end
