//
//  EncapsulationTextView.m
//  小封装demon
//
//  Created by niujinfeng on 2017/11/9.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

#import "EncapsulationTextView.h"

@implementation EncapsulationTextView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
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
