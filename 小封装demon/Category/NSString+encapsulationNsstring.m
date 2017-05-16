//
//  NSString+encapsulationNsstring.m
//  1111111111
//
//  Created by niujinfeng on 17/4/12.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

#import "NSString+encapsulationNsstring.h"

@implementation NSString (encapsulationNsstring)

- (CGSize)sizeWithFont:(UIFont *)font andMaxSize:(CGSize)maxSize
{
    NSDictionary *arrDict = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:arrDict context:nil].size;
}


//base64编码
- (instancetype)base64EncodeString{
    //1.先把字符串转换为二进制数据
    
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    //2.对二进制数据进行base64编码，返回编码后的字符串
    
    return [data base64EncodedStringWithOptions:0];
}
//base64解码

- (instancetype)base64DecodeString{

    //1.将base64编码后的字符串『解码』为二进制数据
    
    NSData *data = [[NSData alloc]initWithBase64EncodedString:self options:0];
    
    //2.把二进制数据转换为字符串返回
    
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}
//判断是否为手机号
- (BOOL)isPhoneNumber{
    NSString *photoRange = @"^1(3[0-9]|4[0-9]|5[0-9]|7[0-9]|8[0-9])\\d{8}$";//正则表达式
    NSPredicate *regexMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",photoRange];
    BOOL result = [regexMobile evaluateWithObject:self];
    if (result)
    {
        return YES;
        
    } else
    {
        return NO;
    }
}
//昵称 匹配中文，英文字母和数字及_: 2-20个字符
- (BOOL)inputChineseOrLettersNumberslimit{
    NSString *regex =@"[\u4e00-\u9fa5_a-zA-Z0-9_]{2,20}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return  [predicate evaluateWithObject:self];
}
//检测密码是否是数字和字母
- (BOOL)isNumberAndLetter{
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return  [pred evaluateWithObject:self];
}
//检测密码是否是数字／字母／特殊字符(不包含汉字)其中的两种
- (BOOL)judgePasswordIntensity:(chineseBlock)action{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\u4e00-\u9fa5]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:self
                                                               options:0
                                                                 range:NSMakeRange(0, [self length])
                                                          withTemplate:@""];
    //包含汉字的回调
    if (modifiedString.length) {
        action();
        return NO;
    }else{
        NSString *passWordRegex = @"^(?=.*[a-zA-Z0-9].*)(?=.*[a-zA-Z\\W].*)(?=.*[0-9\\W].*).{6,18}$";
        //NSString *passWordRegex = @"^(?:[0-9A-Za-z]+|[A-Za-z\\W+]+|[0-9\\W+]+).{6,18}$";
        NSPredicate *hybridletter = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passWordRegex];
        
        if ([hybridletter evaluateWithObject:self]) {
            return YES;
        }else{
            return NO;
        }
    }
}
//判断密码强度
- (void)judgePasswordStrongOrWeak:(pWeakBlock)pWeak pMiddle:(pMiddleBlock)pMiddle pStrong:(pStrongBlock)pStrong{
    NSString *weakStr = @"^(?:\\d+|[a-zA-Z]+|\\W+)$";
    
    NSString *middleStr = @"^(?:[0-9A-Za-z]+|[A-Za-z\\W+]+|[0-9\\W+]+)$";
    
    NSString *strongStr = @"^[0-9A-Za-z\\W+]+$";
    
    NSPredicate *predweakStr = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", weakStr];
    
    NSPredicate *predmiddle = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", middleStr];
    
    NSPredicate *predstrong = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", strongStr];
    
    if ([predweakStr evaluateWithObject:self]) {
        pWeak();
    }else if([predmiddle evaluateWithObject:self]){
        pMiddle();
    }
    else if([predstrong evaluateWithObject:self]){
        pStrong();
    }
}

+ (instancetype)stringToweekdayForIndex:(NSInteger)idx
{
    NSString *string = @"";
    switch (idx) {
        case 1:
            string = @"星期日";
            break;
        case 2:
            string = @"星期一";
            break;
        case 3:
            string = @"星期二";
            break;
        case 4:
            string = @"星期三";
            break;
        case 5:
            string = @"星期四";
            break;
        case 6:
            string = @"星期五";
            break;
        case 7:
            string = @"星期六";
            break;
            
        default:
            break;
    }
    return string;
}

@end
