//
//  EncapsulationMutableTableViewCell.m
//  小封装demon
//
//  Created by niujinfeng on 2018/1/20.
//  Copyright © 2018年 niujinfeng. All rights reserved.
//
#import "EncapsulationMutableTableViewCell.h"

@interface EncapsulationMutableTableViewCell()
@property (nonatomic , strong) UILabel *titleLable;
@property (nonatomic, strong) UILabel *accessoryLable;
@property (nonatomic, strong) UIImageView *accessoryArrowImageView;
@property (nonatomic, strong) UISwitch *accessorySwitch;
@property (nonatomic, strong) UIView *lineView;
@end
@implementation EncapsulationMutableTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
    }
    return self;
}

- (void)setModel:(CellMulTypeModel *)model{
    self.titleLable.text = model.title;
    if (model.type == CellTypeAccessoryViewArrow) {
        self.accessoryArrowImageView.hidden = NO;
        self.accessoryLable.hidden = YES;
        self.accessorySwitch.hidden = YES;
    }else if (model.type == CellTypeAccessoryViewSwitch){
        self.accessoryArrowImageView.hidden = YES;
        self.accessoryLable.hidden = YES;
        self.accessorySwitch.hidden = NO;
    }else{
        self.accessoryArrowImageView.hidden = YES;
        self.accessoryLable.hidden = NO;
        self.accessorySwitch.hidden = YES;
    }
}
- (void)setUpUI{
    [self.contentView addSubview:self.titleLable];
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.accessorySwitch];
    [self.accessorySwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.accessoryLable];
    [self.accessoryLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.accessoryArrowImageView];
    [self.accessoryArrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15);
        make.centerY.equalTo(self.contentView);
    }];
}

#pragma mark: -lazy loading
- (UILabel *)titleLable{
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] init];
    }
    return _titleLable;
}
- (UIImageView *)accessoryArrowImageView{
    if (!_accessoryArrowImageView) {
        _accessoryArrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"right_arrow"]];
    }
    return _accessoryArrowImageView;
}
- (UILabel *)accessoryLable{
    if (!_accessoryLable) {
        _accessoryLable = [[UILabel alloc] init];
    }
    return _accessoryLable;
}
- (UISwitch *)accessorySwitch{
    if (!_accessorySwitch) {
        _accessorySwitch = [[UISwitch alloc] init];
    }
    return _accessorySwitch;
}
@end


@implementation CellMulTypeModel

@end


