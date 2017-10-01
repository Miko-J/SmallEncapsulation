//
//  RequestViewModel.h
//  小封装demon
//
//  Created by niujinfeng on 2017/5/31.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveObjC.h"
@interface RequestViewModel : NSObject <UITableViewDataSource>

// 请求命令
@property (nonatomic, strong, readonly) RACCommand *reuqesCommand;

//模型数组
@property (nonatomic, strong) NSArray *models;

@end
