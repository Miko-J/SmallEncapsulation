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
static char topEdgeKey;
static char leftEdgeKey;
static char bottomEdgeKey;
static char rightEdgeKey;

@implementation UIButton (encapsulationBtn)

+ (instancetype)buttonWithType:(UIButtonType)buttonType title:(NSString *)title titleColor:(UIColor *)titleColor imageName:(NSString *)imageName bgImageName:(NSString *)bgImageName highImageName:(NSString *)highImageName selBgImageName:(NSString *)selBgImageName btnClickedBlock:(btnClickedBlock)block{
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

+ (instancetype _Nullable )buttonWithType:(UIButtonType)buttonType title:(NSString *_Nullable)title titleColor:(UIColor *_Nullable)titleColor  disBGImageName:(NSString *_Nullable)disBGImageName normalBGImageName:(NSString *_Nullable)normalBGImageName{
    UIButton *btn = [UIButton buttonWithType:buttonType];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:disBGImageName] forState:UIControlStateDisabled];
    [btn setBackgroundImage:[UIImage imageNamed:normalBGImageName] forState:UIControlStateNormal];
    return btn;
}

//重新高亮方法，去掉高亮状态
- (void)setHighlighted:(BOOL)highlighted{
    
}

-(void)setEnlargedEdge:(CGFloat)enlargedEdge
{
    [self setEnlargedEdgeWithTop:enlargedEdge left:enlargedEdge bottom:enlargedEdge right:enlargedEdge];
}
-(void)setEnlargedEdgeWithTop:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right
{
    objc_setAssociatedObject(self, &topEdgeKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &leftEdgeKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &bottomEdgeKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &rightEdgeKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(CGFloat)enlargedEdge
{
    return [(NSNumber *)objc_getAssociatedObject(self, &topEdgeKey) floatValue];
}
-(CGRect)enlargedRect
{
    NSNumber *topEdge = objc_getAssociatedObject(self, &topEdgeKey);
    NSNumber *leftEdge = objc_getAssociatedObject(self, &leftEdgeKey);
    NSNumber *bottomEdge = objc_getAssociatedObject(self, &bottomEdgeKey);
    NSNumber *rightEdge = objc_getAssociatedObject(self, &rightEdgeKey);
    
    if(topEdge && leftEdge && bottomEdge && rightEdge)
    {
        CGRect enlargedRect = CGRectMake(self.bounds.origin.x-leftEdge.floatValue, self.bounds.origin.y - topEdge.floatValue, self.bounds.size.width+ leftEdge.floatValue +rightEdge.floatValue, self.bounds.size.height+topEdge.floatValue+bottomEdge.floatValue);
        return enlargedRect;
    }
    
    return self.bounds;
    
}
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if(self.alpha <= 0.01 || !self.userInteractionEnabled ||self.hidden)
    {
        return nil;
    }
    CGRect enlargedRect = [self enlargedRect];
    return CGRectContainsPoint(enlargedRect, point) ? self: nil;
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
