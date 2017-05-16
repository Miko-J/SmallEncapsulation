//
//  UIButton+encapsulationBtn.m
//  1111111111
//
//  Created by niujinfeng on 17/4/12.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

#import "UIButton+encapsulationBtn.h"
#import <objc/runtime.h>

static const char btnKey;

@implementation UIButton (encapsulationBtn)

+ (instancetype)buttonWithType:(UIButtonType)buttonType createBtnWithtitle:(NSString *)title titleColor:(UIColor *)titleColor imageName:(NSString *)imageName bgImageName:(NSString *)bgImageName highImageName:(NSString *)highImageName selBgImageName:(NSString *)selBgImageName btnClickedBlock:(btnClickedBlock)block{
    UIButton *btn = [UIButton buttonWithType:buttonType];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:bgImageName] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    [btn setBackgroundImage:[UIImage imageNamed:selBgImageName] forState:UIControlStateSelected];
    
    [btn addTarget:btn action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    if (block) {
        objc_setAssociatedObject(btn, &btnKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    return btn;
}

- (void)btnAction:(UIButton *)btn
{
    btnClickedBlock block = objc_getAssociatedObject(btn, &btnKey);
    if (block) {
        block();
    }
}

- (void)layoutButtonWithEdgeInsetsStyle:(MKButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space
{
    //self.backgroundColor = [UIColor cyanColor];
    /**
     *  前置知识点：titleEdgeInsets是title相对于其上下左右的inset，跟tableView的contentInset是类似的，
     *  如果只有title，那它上下左右都是相对于button的，image也是一样；
     *  如果同时有image和label，那这时候image的上左下是相对于button，右边是相对于label的；title的上右下是相对于button，左边是相对于image的。
     */
    // 1. 得到imageView和titleLabel的宽、高
    CGFloat imageWith = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
        
    } else {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }
    
    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
    switch (style) {
        case MKButtonEdgeInsetsStyleTop:
        {
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2.0, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space/2.0, 0);
        }
            break;
        case MKButtonEdgeInsetsStyleLeft:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
        }
            break;
        case MKButtonEdgeInsetsStyleBottom:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/2.0, -imageWith, 0, 0);
        }
            break;
        case MKButtonEdgeInsetsStyleRight:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space/2.0, 0, -labelWidth-space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-space/2.0, 0, imageWith+space/2.0);
        }
            break;
        default:
            break;
    }
    // 4. 赋值
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}
@end
