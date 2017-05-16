//
//  NSString+encapsulationNsstring.h
//  1111111111
//
//  Created by niujinfeng on 17/4/12.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//声明block
typedef void (^pWeakBlock)();

typedef void (^pMiddleBlock)();

typedef void (^pStrongBlock)();

typedef void (^chineseBlock)();

@interface NSString (encapsulationNsstring)

//计算文字的尺寸
- (CGSize)sizeWithFont:(UIFont *)font andMaxSize:(CGSize)maxSize;

//base64编码
- (instancetype)base64EncodeString;
//base64解码

- (instancetype)base64DecodeString;

//检查是否为手机号的方法
- (BOOL)isPhoneNumber;
//昵称 匹配中文，英文字母和数字及_: 2-20个字符
- (BOOL)inputChineseOrLettersNumberslimit;
//检测密码是否是数字和字母
- (BOOL)isNumberAndLetter;
//检测密码是否是数字／字母／特殊字符(不包含汉字)其中的两种
- (BOOL)judgePasswordIntensity:(chineseBlock)action;

//判断密码强度的强弱
- (void)judgePasswordStrongOrWeak:(pWeakBlock)pWeak pMiddle:(pMiddleBlock)pMiddle pStrong:(pStrongBlock)pStrong;

+ (instancetype)stringToweekdayForIndex:(NSInteger)idx;
@end
