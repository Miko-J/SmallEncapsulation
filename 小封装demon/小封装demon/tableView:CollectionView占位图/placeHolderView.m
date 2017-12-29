//
//  PlaceHolderView.m
//  小封装demon
//
//  Created by niujinfeng on 2017/12/29.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

#import "PlaceHolderView.h"
@interface PlaceHolderView()
@property (nonatomic, strong) UIImageView *placeHolderImageView;
@end
@implementation PlaceHolderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    [self addSubview:self.placeHolderImageView];
    [self.placeHolderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    
    [self addSubview:self.placeHolderLable];
    [self.placeHolderLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.placeHolderImageView.mas_bottom).offset(10);
        make.centerX.equalTo(self);
    }];
}
#pragma mark: lazy loading
- (UIImageView *)placeHolderImageView{
    if (!_placeHolderImageView) {
        _placeHolderImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"note"]];
    }
    return _placeHolderImageView;
}
- (UILabel *)placeHolderLable{
    if (!_placeHolderLable) {
        _placeHolderLable = [[UILabel alloc] init];
        _placeHolderLable.text = @"暂无数据";
    }
    return _placeHolderLable;
}

@end
