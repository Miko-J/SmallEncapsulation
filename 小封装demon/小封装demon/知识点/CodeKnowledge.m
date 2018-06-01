//
//  CodeKnowledge.m
//  小封装demon
//
//  Created by niujinfeng on 2018/6/1.
//  Copyright © 2018年 niujinfeng. All rights reserved.
//
extern uint64_t dispatch_benchmark(size_t count, void (^block)(void));
#import "CodeKnowledge.h"
#import <objc/runtime.h>
@implementation CodeKnowledge

#pragma mark - @autoreleasepool与循环

- (void)tes1{
    // 测试的次数
    size_t count = 10;
    // 循环中产生的实例的个数
    NSUInteger objectCount = 10000000;
    // 测试1 - @autoreleasepool在循环外部
    // 在循环中产生的之后不再被使用的实例需要在整个for循环结束后才会被调用release方法
    // 实际测试中，内存占用的峰值为480M，平均耗时为10780423522纳秒
    uint64_t time1 = dispatch_benchmark(count, ^{
        @autoreleasepool {
            for (NSUInteger i = 0; i < objectCount; ++i) {
                [NSString stringWithFormat:@"str - %lu", (unsigned long)i];
            }
        }
    });
    NSLog(@"@autoreleasepool { for { } } = %llu ns", time1);
}

- (void)test2{
    // 测试的次数
    size_t count = 10;
    // 循环中产生的实例的个数
    NSUInteger objectCount = 10000000;
    // 测试2 - @autoreleasepool在循环内部
    // 在循环中产生的之后不再被使用的实例将代码执行到@autoreleasepool代码块的第二个括号时被调用release操作
    // 实际测试中，内存占用的峰值为16M，平均耗时为9902072437纳秒
    uint64_t time2 = dispatch_benchmark(count, ^{
        for (NSUInteger i = 0; i < objectCount; ++i) {
            @autoreleasepool {
                [NSString stringWithFormat:@"str - %lu", (unsigned long)i];
            }
        }
    });
    NSLog(@"for { @autoreleasepool { } } = %llu ns", time2);
}

@end
