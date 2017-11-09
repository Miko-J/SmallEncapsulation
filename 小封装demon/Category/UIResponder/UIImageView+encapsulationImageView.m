//
//  UIImageView+encapsulationImageView.m
//  1111111111
//
//  Created by niujinfeng on 17/4/12.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

#import "UIImageView+encapsulationImageView.h"

@implementation UIImageView (encapsulationImageView)

+ (instancetype)imageWithName:(NSString *)imageName{
    
    UIImageView *imageView = [[UIImageView alloc] init];
    
    imageView.image = [UIImage imageNamed:imageName];
    
    return imageView;
}

@end
