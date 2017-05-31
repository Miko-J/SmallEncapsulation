//
//  Book.h
//  小封装demon
//
//  Created by niujinfeng on 2017/5/31.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject

@property (nonatomic,copy) NSString *subtitle;
@property (nonatomic,copy) NSString *title;


- (id)initWithDict:(NSDictionary*)dict;

+ (id)bookWithDict:(NSDictionary*)dict;
@end
