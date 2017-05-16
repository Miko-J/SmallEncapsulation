//
//  UILabel+encapsulationlable.h
//  1111111111
//
//  Created by niujinfeng on 17/4/12.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (encapsulationlable)

+ (instancetype)lableWithtext:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font bgColor:(UIColor *)bgColor textAlignment:(NSTextAlignment)textAlignment numberOfLines:(NSInteger)numberOfLines;

@end
