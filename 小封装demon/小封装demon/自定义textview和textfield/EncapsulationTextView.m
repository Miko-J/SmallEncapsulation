//
//  EncapsulationTextView.m
//  小封装demon
//
//  Created by niujinfeng on 2017/11/9.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

#import "EncapsulationTextView.h"
#import <objc/runtime.h>
#import <objc/message.h>
@implementation EncapsulationTextView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    // 通过运行时，发现UITextView有一个叫做“_placeHolderLabel”的私有变量
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([UITextView class], &count);
    
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        NSString *objcName = [NSString stringWithUTF8String:name];
        NSLog(@"%d : %@",i,objcName);
    }
    
    [self addSubview:self.placeHolderLable];
    [self setValue:self.placeHolderLable forKey:@"_placeholderLabel"];
}

- (UILabel *)placeHolderLable{
    if (!_placeHolderLable) {
        _placeHolderLable = [[UILabel alloc] init];
        [_placeHolderLable sizeToFit];
        _placeHolderLable.backgroundColor = [UIColor clearColor];
        _placeHolderLable.numberOfLines = 0;
    }
    return _placeHolderLable;
}

@end
