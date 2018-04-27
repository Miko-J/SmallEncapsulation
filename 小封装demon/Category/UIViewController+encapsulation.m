//
//  UIViewController+encapsulation.m
//  小封装demon
//
//  Created by niujinfeng on 2018/4/27.
//  Copyright © 2018年 niujinfeng. All rights reserved.
//

#import "UIViewController+encapsulation.h"
#import <objc/runtime.h>

@implementation UIViewController (encapsulation)
#ifdef DEBUG

+ (void)load {
    Method originalMethod = class_getInstanceMethod(self, @selector(viewDidLoad));
    Method swizzledMethod = class_getInstanceMethod(self, @selector(sw_viewDidLoad));
    method_exchangeImplementations(originalMethod, swizzledMethod);
    
    originalMethod = class_getInstanceMethod(self, NSSelectorFromString(@"dealloc"));
    swizzledMethod = class_getInstanceMethod(self, @selector(sw_dealloc));
    method_exchangeImplementations(originalMethod, swizzledMethod);
    
    originalMethod = class_getInstanceMethod(self, NSSelectorFromString(@"viewDidDisappear:"));
    swizzledMethod = class_getInstanceMethod(self, @selector(sw_viewDidDisappear:));
    method_exchangeImplementations(originalMethod, swizzledMethod);
    
    
    originalMethod = class_getInstanceMethod(self, NSSelectorFromString(@"initWithNibName:bundle:"));
    swizzledMethod = class_getInstanceMethod(self, @selector(sw_initWithNibName:bundle:));
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

- (void)sw_dealloc {
    NSLog(@"页面已释放--->:%@", self);
    [self sw_dealloc];
}
- (void)sw_viewDidLoad {
    NSLog(@"进入页面--->:%@", self);
    [self sw_viewDidLoad];
}


-(void)sw_viewDidDisappear:(BOOL)animated {
    NSLog(@"离开页面--->:%@", self);
    [self sw_viewDidDisappear:animated];
}


- (instancetype)sw_initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil {
    
    if (nibBundleOrNil == nil) {
        //先去类所在的Bundle里面找，找不到去主工程里面找
        if ([NSBundle bundleForClass:[self class]]) {
            return [self sw_initWithNibName:nibNameOrNil bundle:[NSBundle bundleForClass:[self class]]];
        }
        else {
            return [self sw_initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
        }
    }
    else {
        return [self sw_initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    }
    
    
}

#endif

@end
