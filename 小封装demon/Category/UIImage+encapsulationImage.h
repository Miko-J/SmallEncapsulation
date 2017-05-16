//
//  UIImage+encapsulationImage.h
//  1111111111
//
//  Created by niujinfeng on 17/4/12.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (encapsulationImage)

+ (instancetype) returnCircleImageWithOriginImage:(UIImage*) originImage withParam:(CGFloat) inset;


+ (instancetype) returnCompressionImageWithOriginImage: (UIImage *) originImage toSize: (CGSize) size;


+ (instancetype) resizableImageWithName:(NSString *)name;

+ (instancetype) imageWithOriginalImageName:(NSString *)imageName;

// 生成一张普通的二维码
+ (instancetype)generateWithDefaultQRCodeData:(NSString *)data imageViewWidth:(CGFloat)imageViewWidth;

// 生成一张带有logo的二维码（logoScaleToSuperView：相对于父视图的缩放比取值范围0-1；0，不显示，1，代表与父视图大小相同）
+ (instancetype)generateWithLogoQRCodeData:(NSString *)data logoImageName:(NSString *)logoImageName logoScaleToSuperView:(CGFloat)logoScaleToSuperView;

@end
