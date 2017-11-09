//
//  UILabel+encapsulationlable.m
//  1111111111
//
//  Created by niujinfeng on 17/4/12.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

#import "UILabel+encapsulationlable.h"

@implementation UILabel (encapsulationlable)


+ (instancetype)lableWithtext:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font bgColor:(UIColor *)bgColor textAlignment:(NSTextAlignment)textAlignment numberOfLines:(NSInteger)numberOfLines{
    UILabel *lable = [[UILabel alloc] init];
    lable.text = text;
    lable.textColor = textColor;
    lable.font = font;
    lable.backgroundColor = bgColor;
    lable.textAlignment = textAlignment;
    lable.numberOfLines = numberOfLines;
    return lable;
}

@end
