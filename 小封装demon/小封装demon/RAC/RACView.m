//
//  RACView.m
//  小封装demon
//
//  Created by niujinfeng on 2017/5/24.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

#import "RACView.h"

@implementation RACView

- (instancetype)initWithFrame: (CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //设置UI
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn = btn;
    btn.titleLabel.numberOfLines = 0;
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn setTitle:@"textField都有值才能点击的按钮" forState:UIControlStateNormal];
    btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    btn.layer.borderWidth = 1;
    [self addSubview:btn];
    @weakify(self)
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"点击了按钮");
        @strongify(self)
        if (self.delegateSingle) {
            [self.delegateSingle sendNext:@"200"];
        }
    }];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.btn.frame = self.bounds;
}
@end
