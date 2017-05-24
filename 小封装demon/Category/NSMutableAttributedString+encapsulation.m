//
//  NSMutableAttributedString+encapsulation.m
//  小封装demon
//
//  Created by niujinfeng on 2017/5/23.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

#import "NSMutableAttributedString+encapsulation.h"

@implementation NSMutableAttributedString (encapsulation)

- (instancetype)attributeWithStr:(NSString *)str{
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:str];
    return attributeStr;
}

- (void)rangeWithTitle:(NSString *)title font:(UIFont *)font color:(UIColor *)color{
    NSRange range = [[self string]rangeOfString:title];
    [self addAttribute:NSForegroundColorAttributeName value:color range:range];
    [self addAttribute:NSFontAttributeName value:font range:range];
}

@end
