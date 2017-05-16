//
//  UIAlertController+encapsulationUIAlertController.m
//  1111111111
//
//  Created by niujinfeng on 17/4/13.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

#import "UIAlertController+encapsulationUIAlertController.h"

@implementation UIAlertController (encapsulationUIAlertController)


+ (void)alertWithTitle:(NSString *)title message: (NSString *)message target: (UIViewController *)target confirmText:(NSString *)confirmText{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:  UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:confirmText style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [target dismissViewControllerAnimated:true completion:nil];
    }]];
    //弹出提示框；
    [target presentViewController:alert animated:true completion:nil];
}

+ (void)alertWithTitle:(NSString *)title message: (NSString *)message target: (UIViewController *)target confirmText:(NSString *)confirmText confirmBlock:(ConfirmBtnBlock) confirmBlock{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:  UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:confirmText style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        confirmBlock();
        [target dismissViewControllerAnimated:true completion:nil];
    }]];
    //弹出提示框；
    [target presentViewController:alert animated:true completion:nil];
}

+ (void)alertWithTitle:(NSString *)title Message: (NSString *)message cancelText:(NSString *)cancelText confirmText:(NSString *)confirmText target: (UIViewController *)target confirmBlock:(ConfirmBtnBlock) confirmBlock cancelBlock: (CancelBtnBlock) cancelBlock{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:  UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:cancelText style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        cancelBlock();
        [target dismissViewControllerAnimated:true completion:nil];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:confirmText style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        confirmBlock();
        [target dismissViewControllerAnimated:true completion:nil];
    }]];
    //弹出提示框；
    [target presentViewController:alert animated:true completion:nil];
}

@end
