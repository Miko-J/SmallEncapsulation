//
//  EncapsulationMutableTableViewCell.m
//  小封装demon
//
//  Created by niujinfeng on 2018/1/20.
//  Copyright © 2018年 niujinfeng. All rights reserved.
//
static NSString *const cellLableIdentifier = @"cellLableIdentifier";
static NSString *const cellSwitchIdentifier = @"cellSwitchIdentifier";
#import "EncapsulationMutableTableViewCell.h"

@implementation EncapsulationMutableTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    
}

@end


#pragma mark: -model

@implementation CellMutableModle

+ (NSString *)getIdentifierWithCellType:(CellType)type{
    switch (type) {
        case CellTypeAccessoryViewLable:
            return cellLableIdentifier;
            break;
        case CellTypeAccessoryViewSwitch:
            return cellSwitchIdentifier;
            break;
        default:
            break;
    }
}
@end
