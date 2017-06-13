//
//  Singleton-ARC.h
//  小封装demon
//
//  Created by niujinfeng on 2017/6/13.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

#ifndef Singleton_ARC_h
#define Singleton_ARC_h

// .h文件
#define SingletonH(name) + (instancetype)shared##name;

// .m文件
#define SingletonM(name) \
static id _instance; \
\
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
\
+ (instancetype)shared##name \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return _instance; \
}


#endif /* Singleton_ARC_h */
