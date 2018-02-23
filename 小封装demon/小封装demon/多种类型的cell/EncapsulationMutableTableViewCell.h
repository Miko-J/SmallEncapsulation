//
//  EncapsulationMutableTableViewCell.h
//  小封装demon
//
//  Created by niujinfeng on 2018/1/20.
//  Copyright © 2018年 niujinfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,CellType) {
    CellTypeAccessoryViewLable = 0,
    CellTypeAccessoryViewSwitch = 1,
};
@interface EncapsulationMutableTableViewCell : UITableViewCell

@end


@interface CellMutableModle: NSObject

+ (NSString *)getIdentifierWithCellType:(CellType)type;
@end
