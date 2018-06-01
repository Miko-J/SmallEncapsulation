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

#pragma mark - EnumerateObjectsUsingBlock,enumerateKeysAndObjectsUsingBlock的使用

- (void)test3{
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:@"obj1",@"key1",@"obj2",@"key2", nil];
    [dic enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
        NSLog(@"value for key %@ is %@ ", key, value);
        if ([@"key2" isEqualToString:key]) {
            *stop = YES;
        }
    }];
}

- (void)test4{
    NSArray *array = [[NSArray alloc]initWithObjects:@"a",@"b",@"c",@"d",@"e",@"f", nil];
    
    //遍历数组元素
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"obj=%@   idx=%ld",obj,idx);
    }];
    
    //如果指定了NSEnumerationConcurrent顺序，那么底层通过GCD来处理并发执行事宜，具体实现可能会用到dispatch group。也就是说，这个会用多线程来并发实现，并不保证按照顺序执行
    
    //NSEnumerationReverse 倒序排列
    [array enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"idx=%ld, id=%@", idx, obj);
        
        //当需要结束循环的时候,调用stop,赋予YES
        if (idx ==3) {
            *stop = YES;
        }
        
    }];
    //NSIndexSet类代表一个不可变的独特的无符号整数的集合,称为索引,因为使用它们的方式。这个集合被称为索引集    唯一的，有序的，无符号整数的集合
    [NSIndexSet indexSetWithIndex:1];//创建一个索引集合，根据索引值
    [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0,8)];//创建一个索引集合，根据一个NSRange对象
    
    [array enumerateObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0,3)] options:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"\n\n\nidx=%ld, id=%@", idx, obj);
    }];
}
/*
for in、经典for循环和EnumerateObjectsUsingBlock 的比较
对于集合中对象数很多的情况下，for in 的遍历速度非常之快，但小规模的遍历并不明显（还没普通for循环快）
Value查询index的时候, 面对大量的数组推荐使用 enumerateObjectsWithOptions的并行方法.
遍历字典类型的时候, 推荐使用enumerateKeysAndObjectsUsingBlock,block版本的字典遍历可以同时取key和value（forin只能取key再手动取value）
*/
@end
