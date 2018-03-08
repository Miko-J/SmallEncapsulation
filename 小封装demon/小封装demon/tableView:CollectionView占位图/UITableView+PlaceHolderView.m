//
//  UITableView+PlaceHolderView.m
//  PlaceHolderView
//
//  Created by yh on 17/5/16.
//  Copyright © 2017年 yh. All rights reserved.
//

#import "UITableView+PlaceHolderView.h"
#import "NSObject+encapsulation.h"
#import "PlaceHolderView.h"
#import <objc/runtime.h>
static const char marginKey;

@implementation UITableView (PlaceHolderView)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceSelector:@selector(reloadData) swizzleSelector:@selector(xn_reloadData)];
    });
}

- (void)xn_reloadData
{
    if (self.enablePlaceHolderView) {
        NSInteger sectionCount = [self.dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]?[self.dataSource numberOfSectionsInTableView:self]:1;
        NSInteger rowCount = 0;
        for (int i = 0; i < sectionCount; i++) {
            rowCount += [self.dataSource tableView:self numberOfRowsInSection:i];
        }
        if (rowCount == 0) {
            if (!self.firstReload) {
                self.firstReload = YES;
                if ([self.xn_PlaceHolderView isKindOfClass:[PlaceHolderView class]]) {
                    PlaceHolderView *placeHolderView = (PlaceHolderView *)self.xn_PlaceHolderView;
                    placeHolderView.placeHolderLable.text = @"加载数据中...";
                }
            }else{
                if ([self.xn_PlaceHolderView isKindOfClass:[PlaceHolderView class]]) {
                    PlaceHolderView *placeHolderView = (PlaceHolderView *)self.xn_PlaceHolderView;
                    if (self.placeHolderText) {
                        placeHolderView.placeHolderLable.text = self.placeHolderText;
                    }
                    if (self.placeHolderImageName) {
                        placeHolderView.placeHolderImageView.image = [UIImage imageNamed:self.placeHolderImageName];
                    }
                    if (self.marginToTop > 0) {
                        placeHolderView.marginToTop = self.marginToTop;
                    }
                }
            }
            [self addSubview:self.xn_PlaceHolderView];
        }
        else
        {
            [self.xn_PlaceHolderView removeFromSuperview];
        }
    }
    [self xn_reloadData];
}


- (void)setEnablePlaceHolderView:(BOOL)enblePlaceHolderView
{
    objc_setAssociatedObject(self, @selector(enablePlaceHolderView), @(enblePlaceHolderView), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)enablePlaceHolderView
{
    NSNumber *number = objc_getAssociatedObject(self, @selector(enablePlaceHolderView));
    return number.boolValue;
}

- (void)setFirstReload:(BOOL)firstReload
{
    objc_setAssociatedObject(self, @selector(firstReload), @(firstReload), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)firstReload
{
    NSNumber *number = objc_getAssociatedObject(self, @selector(firstReload));
    return number.boolValue;
}

- (void)setPlaceHolderText:(NSString *)placeHolderText{
    objc_setAssociatedObject(self, @selector(placeHolderText), placeHolderText, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)placeHolderText{
    return  objc_getAssociatedObject(self, @selector(placeHolderText));
}

- (void)setPlaceHolderImageName:(NSString *)placeHolderImageName{
    objc_setAssociatedObject(self, @selector(placeHolderImageName), placeHolderImageName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)placeHolderImageName{
    return objc_getAssociatedObject(self, @selector(placeHolderImageName));
}

- (void)setMarginToTop:(NSInteger)marginToTop{
    objc_setAssociatedObject(self,&marginKey, [NSNumber numberWithInteger:marginToTop], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSInteger)marginToTop{
    return [(NSNumber *)objc_getAssociatedObject(self, &marginKey) integerValue];
}

- (void)setXn_PlaceHolderView:(UIView *)xn_PlaceHolderView{
    objc_setAssociatedObject(self, @selector(xn_PlaceHolderView), xn_PlaceHolderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)xn_PlaceHolderView
{
    UIView *placeHolder = objc_getAssociatedObject(self, @selector(xn_PlaceHolderView));
    if (!placeHolder) {
        placeHolder  = [[PlaceHolderView alloc] initWithFrame:self.bounds];
        self.xn_PlaceHolderView = placeHolder;
    }
    return placeHolder;
}

@end
