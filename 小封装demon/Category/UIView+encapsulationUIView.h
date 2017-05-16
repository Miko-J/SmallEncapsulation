//
//  UIView+encapsulationUIView.h
//  1111111111
//
//  Created by niujinfeng on 17/4/13.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^tapAction)();

@interface UIView (encapsulationUIView)

- (void)tapGestures:(tapAction)block;


//设置圆角
- (void)setCornerRadiusWithView:(UIView *)view cornerRadius:(CGFloat)cornerRadius;

//画一条直线
- (void)drawLineWithColor: (UIColor *)lineColor;
#pragma mark: -控件拖动的手势动画
/**
 *  Make view draggable.
 *
 *  @param view    Animator reference view, usually is super view.
 *  @param damping Value from 0.0 to 1.0. 0.0 is the least oscillation. default is 0.4.
 */
- (void)makeDraggableInView:(UIView *)view damping:(CGFloat)damping;

- (void)makeDraggable;

/**
 *  Disable view draggable.
 */
- (void)removeDraggable;

/**
 *  If you call make draggable method in the initialize method such as `-initWithFrame:`,
 *  `-viewDidLoad`, the view may not be layout correctly at that time. So you should
 *  update snap point in `-layoutSubviews` or `-viewDidLayoutSubviews`.
 *
 *  By the way, you can call make draggable method in `-layoutSubviews` or
 *  `-viewDidLayoutSubviews` directly instead of update snap point.
 */
- (void)updateSnapPoint;



@end
