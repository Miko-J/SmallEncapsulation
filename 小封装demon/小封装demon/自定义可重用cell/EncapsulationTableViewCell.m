//
//  EncapsulationTableViewCell.m
//  小封装demon
//
//  Created by niujinfeng on 2017/10/1.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

#import "EncapsulationTableViewCell.h"
#import "EncapsulationSystemControls.h"
@interface EncapsulationTableViewCell()
@property (nonatomic, strong) UILabel *accessoryViewLable;
@property (nonatomic, strong) UISwitch *accessoryViewSwitch;
@end
@implementation EncapsulationTableViewCell

+ (instancetype)encapsulationTableViewCellWithTableView:(UITableView *)tableView {
    static  NSString *ID = @"ID";
    EncapsulationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[EncapsulationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
    }
    return self;
}

//ui根据类型创建
- (void)setUpUI{
    if (self.cellType == CellTypeAccessoryViewLable) {//lable
        [self.contentView addSubview:self.accessoryViewLable];
        [self.accessoryViewLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.contentView).offset(-15);
        }];
    }
}

- (void)setTypeModel:(CellTypeModel *)typeModel{
    _typeModel = typeModel;
    self.accessoryViewLable.font = typeModel.font;
    self.accessoryViewLable.textColor = typeModel.titleColor;
    self.accessoryViewLable.backgroundColor = typeModel.bgColor;
    [self.accessoryViewLable mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-typeModel.disX);
    }];
}
#pragma mark: -懒加载
- (UILabel *)accessoryViewLable{
    if (!_accessoryViewLable) {
        _accessoryViewLable = [UILabel lableWithtext:@"这是一个lable" textColor:[UIColor blackColor] font:font4Dot7(15) bgColor:nil textAlignment:NSTextAlignmentRight numberOfLines:0];
    }
    return _accessoryViewLable;
}

- (UISwitch *)accessoryViewSwitch{
    if (!_accessoryViewSwitch) {
        _accessoryViewSwitch = [[UISwitch alloc] init];
    }
    return _accessoryViewSwitch;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end



@implementation CellTypeModel
+ (instancetype)accessoryViewWithTitleColor:(UIColor *)titleColor font:(UIFont *)font bgColor:(UIColor *)bgColor disX:(CGFloat)disX{
    CellTypeModel *typeModel = [[CellTypeModel alloc] init];
    typeModel.titleColor = titleColor;
    typeModel.font = font;
    typeModel.bgColor = bgColor;
    typeModel.disX = disX;
    return typeModel;
}
@end
