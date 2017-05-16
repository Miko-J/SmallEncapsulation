//
//  UIAlertController+encapsulationUIAlertController.h
//  1111111111
//
//  Created by niujinfeng on 17/4/13.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
//声明block
typedef void (^ConfirmBtnBlock)();

typedef void (^CancelBtnBlock)();

@interface UIAlertController (encapsulationUIAlertController)

+ (void)alertWithTitle:(NSString *)title message: (NSString *)message target: (UIViewController *)target confirmText:(NSString *)confirmText;

+ (void)alertWithTitle:(NSString *)title message: (NSString *)message target: (UIViewController *)target confirmText:(NSString *)confirmText confirmBlock:(ConfirmBtnBlock) confirmBlock;

+ (void)alertWithTitle:(NSString *)title Message: (NSString *)message cancelText:(NSString *)cancelText confirmText:(NSString *)confirmText target: (UIViewController *)target confirmBlock:(ConfirmBtnBlock) confirmBlock cancelBlock: (CancelBtnBlock) cancelBlock;

@end
