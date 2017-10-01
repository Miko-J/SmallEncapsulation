//
//  RACView.h
//  小封装demon
//
//  Created by niujinfeng on 2017/5/24.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReactiveObjC.h"
@interface RACView : UIView

@property (nonatomic, weak) UIButton *btn;
//代理
@property (nonatomic, strong) RACSubject *delegateSingle;

@end
