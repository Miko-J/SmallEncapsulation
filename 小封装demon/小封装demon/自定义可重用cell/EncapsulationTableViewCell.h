//
//  EncapsulationTableViewCell.h
//  小封装demon
//
//  Created by niujinfeng on 2017/10/1.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CellTypeModel;
typedef NS_ENUM(NSInteger,CellType) {
    CellTypeAccessoryViewLable = 0,
    CellTypeAccessoryViewSwitch = 1,
};
@interface EncapsulationTableViewCell : UITableViewCell

@property (nonatomic, strong) CellTypeModel *typeModel;

@property (nonatomic, assign) CellType cellType;

+ (instancetype)encapsulationTableViewCellWithTableView:(UITableView *)tableView;

@end

@interface CellTypeModel : NSObject
/**
 *  icon图标
 */
@property (nonatomic , copy) NSString *icon;
/**
 *  bgColor背景色
 */
@property (nonatomic , strong) UIColor *bgColor;
/**
 *  font字体大小
 */
@property (nonatomic, strong) UIFont *font;
/**
 *  titleColor  title字体色
 */
@property (nonatomic , strong) UIColor *titleColor;


/**
 lable距离右边的距离
 */
@property (nonatomic, assign) CGFloat disX;

+ (instancetype)accessoryViewWithTitleColor:(UIColor *)titleColor font:(UIFont *)font bgColor:(UIColor *)bgColor disX:(CGFloat)disX;

@end
