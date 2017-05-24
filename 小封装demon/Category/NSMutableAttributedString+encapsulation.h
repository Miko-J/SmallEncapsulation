//
//  NSMutableAttributedString+encapsulation.h
//  小封装demon
//
//  Created by niujinfeng on 2017/5/23.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSMutableAttributedString (encapsulation)

- (instancetype)attributeWithStr:(NSString *)str;

- (void)rangeWithTitle:(NSString *)title font:(UIFont *)font color:(UIColor *)color;

@end
