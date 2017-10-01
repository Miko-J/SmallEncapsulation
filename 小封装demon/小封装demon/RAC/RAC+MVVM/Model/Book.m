//
//  Book.m
//  小封装demon
//
//  Created by niujinfeng on 2017/5/31.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

#import "Book.h"

@implementation Book

- (id)initWithDict:(NSDictionary*)dict{
    if (self == [super init]) {
        self.title = dict[@"title"];
        self.subtitle = dict[@"subtitle"];
    }
    return self;
}

+ (id)bookWithDict:(NSDictionary*)dict{
    return [[self alloc] initWithDict:dict];
}
@end
