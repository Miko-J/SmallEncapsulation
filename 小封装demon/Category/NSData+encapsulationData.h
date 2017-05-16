//
//  NSData+encapsulationData.h
//  1111111111
//
//  Created by niujinfeng on 17/4/13.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (encapsulationData)

//CRC 16校验
+ (instancetype) getCrcVerfityCode: (NSData *)data;

@end
