//
//  EncapsulationMutableTableViewCell.h
//  小封装demon
//
//  Created by niujinfeng on 2018/1/20.
//  Copyright © 2018年 niujinfeng. All rights reserved.
//
#import <UIKit/UIKit.h>
@class CellMulTypeModel;
typedef NS_ENUM(NSInteger,CellType) {
    CellTypeAccessoryViewLable = 0,
    CellTypeAccessoryViewSwitch,
    CellTypeAccessoryViewArrow
};
static NSString * const CellMulTypeModelID = @"CellMulTypeModelID";
@interface EncapsulationMutableTableViewCell : UITableViewCell
@property (nonatomic, strong) CellMulTypeModel *model;
@end

@interface CellMulTypeModel: NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) CellType type;
@property (nonatomic, copy) NSString *extendStr;
@end

