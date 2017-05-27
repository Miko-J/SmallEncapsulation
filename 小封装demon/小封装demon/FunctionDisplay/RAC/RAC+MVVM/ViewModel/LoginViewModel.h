//
//  LoginViewModel.h
//  小封装demon
//
//  Created by niujinfeng on 2017/5/26.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"
#import "ReactiveObjC.h"
@interface LoginViewModel : NSObject

@property (nonatomic, strong) Account *account;

// 是否允许登录的信号
@property (nonatomic, strong, readonly) RACSignal *enableLoginSignal;


@property (nonatomic, strong, readonly) RACCommand *LoginCommand;
@end
