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
#import <UIKit/UIKit.h>
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



#pragma mark - NSAssert的使用

- (void)test5{
    NSInteger a = 5;
    NSInteger b = 6;
    NSAssert(a > b,@"发生错误了,a小于6");
}
//NSAssert(condition, desc)
//condition是条件表达式，值为YES或NO；desc为异常描述，通常为NSString。当conditon为YES时程序继续运行，为NO时，则抛出带有desc描述的异常信息。NSAssert()可以出现在程序的任何一个位置。


#pragma mark - __attribute__函数的作用
//GNU C 的一大特色就是__attribute__ 机制。__attribute__ 可以设置函数属性（Function Attribute ）、变量属性（Variable Attribute ）和类型属性（Type Attribute ）
//禁止new
/*
- (instancetype)init __attribute__((unavailable("init not available, call defaultInstance instead")));
+ (instancetype) new __attribute__((unavailable("new not available, call defaultInstance instead")));
*/

#pragma mark - NS_ASSUME_NONNULL_BEGIN和NS_ASSUME_NONNULL_END

/*
 苹果在Xcode 6.3引入了一个Objective-C的新特性：nullability annotations。这一新特性的核心是两个新的类型注释： __nullable 和 __nonnull 。从字面上我们可以猜到，__nullable表示对象可以是NULL或nil，而__nonnull表示对象不应该为空。当我们不遵循这一规则时，编译器就会给出警告。
 
 如果需要每个属性或每个方法都去指定nonnull和nullable，是一件非常繁琐的事。苹果为了减轻我们的工作量，专门提供了两个宏：NS_ASSUME_NONNULL_BEGIN， NS_ASSUME_NONNULL_END。在这两个宏之间的代码，所有简单指针对象都被假定为nonnull，因此我们只需要去指定那些nullable的指针。
 
 NS_ASSUME_NONNULL_BEGIN
 @interface TestObject : NSObject
 
 @property (nonatomic, strong) NSString *testString;
 @property (nonatomic) BOOL isRight;
 
 @end
 NS_ASSUME_NONNULL_END
 
 typedef定义的类型的nullability特性通常依赖于上下文，即使是在Audited Regions中，也不能假定它为nonnull。
 复杂的指针类型(如id *)必须显示去指定是non null还是nullable。例如，指定一个指向nullable对象的nonnulla指针，可以使用”__nullable id * __nonnull”。
 我们经常使用的NSError **通常是被假定为一个指向nullable NSError对象的nullable指针。
 
 */

#pragma mark - Objective-C Runtime - 消息转发
/*
 我们在 Objective-C 中调用一个方法， 其实就是发送一个消息。 而我们调用的对象来响应这个消息。 比如：
 
 [person sayHello];
 在实际的 Runtime 中，会被转换成这样一个函数调用：
 
 objc_msgSend(person,@selector(sayHello))
 objc_msgSend 告诉 person 去响应 @selector(sayHello) 这个消息。 如果 person 中实现了 sayHello 方法， 那么就可以正常响应。 但是如果 person 所引用的实例不能找到 sayHello 的实现，那么在默认的行为下，程序就会崩溃。
 
 消息转发
 
 咱们上面提到的这种崩溃现象， 相信大家多少都会遇到过。 所以在写代码的时候，要尽量避免这样的消息发送导致 App 崩溃。 比如可以使用 respondsToSelector: 方法在调用之前判断这个实例能不能响应这个消息。
 
 if([person respondsToSelector: @selector(sayHello)]) {
    [person sayHello];
 }
 
 这时一种常见的方法。 当然，在 Runtime 的整个消息传递中，我们还能在其他时机上处理这个事情。 这也就是 Runtime 的消息转发机制。 继承自 NSObject 的类可以覆盖这个方法：
 
 - (void)forwardInvocation:(NSInvocation*)anInvocation
 {
    if([someOtherObject respondsToSelector:[anInvocation selector]])
        [anInvocation invokeWithTarget:someOtherObject];
    else
        [superforwardInvocation:anInvocation];
 }
 
 同时还需要覆盖：
 - (NSMethodSignature*)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature* signature = [supermethodSignatureForSelector:aSelector];
    if(!signature) {
        signature = [someOtherObject methodSignatureForSelector:aSelector];
    }
    returnsignature;
}
 比如我们刚才举得例子中，如果 person 不能响应 sayHello 这个消息，程序并不会马上崩溃， 在这之前 Runtime 会调用 person 的 forwardInvocation: 方法。
 
 forwardInvocation: 接受一个类型为 NSInvocation 的参数。 NSInvocation 中存储了我们发送失败的 sayHello 消息的详细信息。 在这里我们可以把它转发到另外一个实例上面。
 
 通过对 [anInvocation invokeWithTarget:someOtherObject] 的调用， 我们把 sayHello 消息转发到了 someOtherObject 中。 如果 someOtherObject 能够正确的处理这个消息， 那么我们的程序就不会崩溃。
 
 关于消息发送和转发的细节， 涉及到 Runtime 的整体消息传递机制，业绩 isa 指针等这些概念，这里我们不过多展开。
 
 这时候我们再调用 [person sayHello] 之后， 即使 person 本身不能处理这个消息， 程序也不会崩溃， 而是根据我们的转发规则将消息转到可以处理它的实例中了。
 
 但有一点要注意，通过 forwardInvocation 转发的消息不会进入正常的消息验证逻辑，也就是说即便我们通过 forwardInvocation: 将消息正确的转发了。 但 [person respondsToSelector: @selector(sayHello)] 还是会返回 NO。
 
 除非我们同时也覆盖 person 对 respondsToSelector 的实现：
 
 - (BOOL)respondsToSelector:(SEL)aSelector
 {
    if( [superrespondsToSelector:aSelector] )
        returnYES;
    else{
        //对于我们特定转发的 Selector 可以在这里返回 YES
     }
        returnNO;
 }
 除了可以通过 forwardInvocation: 来处理转发规则， 同样还可以忽略掉出错的消息。
 */
@end



