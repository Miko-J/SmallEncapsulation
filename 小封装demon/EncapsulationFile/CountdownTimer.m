//
//  CountdownTimer.m
//  1111111111
//
//  Created by niujinfeng on 2017/5/13.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

#import "CountdownTimer.h"
@interface CountdownTimer()
@property (nonatomic, strong) dispatch_source_t timer;
@property (nonatomic, assign) NSTimeInterval timerInterval;
@property (nonatomic, assign) NSInteger totalTime;
@property (nonatomic, copy) timingBlock  timingBlock;
@property (nonatomic, copy) fisishBlock  fisishBlock;
@end
@implementation CountdownTimer


- (instancetype)initWithTimerInterval: (NSTimeInterval)timerInterval totalTime:(NSInteger)totalTime timingBlock:(timingBlock) timingBlock fisishBlock:(fisishBlock)fisishBlock{
    if (self = [super init]) {
        self.timerInterval = timerInterval;
        self.totalTime = totalTime;
        self.timingBlock = timingBlock;
        self.fisishBlock = fisishBlock;
    }
    return self;
}

- (void)cutDown{
    //全局并发队列
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //主队列；属于串行队列
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    //定时循环执行事件
    //dispatch_source_set_timer 方法值得一提的是最后一个参数（leeway），他告诉系统我们需要计时器触发的精准程度。所有的计时器都不会保证100%精准，这个参数用来告诉系统你希望系统保证精准的努力程度。如果你希望一个计时器每5秒触发一次，并且越准越好，那么你传递0为参数。另外，如果是一个周期性任务，比如检查email，那么你会希望每10分钟检查一次，但是不用那么精准。所以你可以传入60，告诉系统60秒的误差是可接受的。他的意义在于降低资源消耗。
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, globalQueue);
    
    dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, _timerInterval * NSEC_PER_SEC, 0.0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(_timer, ^{ //计时器事件处理器
        //NSLog(@"Event Handler");
        if (_totalTime <= 0) {
            dispatch_source_cancel(_timer); //取消定时循环计时器；使得句柄被调用，即事件被执行
        } else {
            _totalTime--;
            dispatch_async(mainQueue, ^{
                if (self.timingBlock) {
                    self.timingBlock(_totalTime);
                }
            });
        }
    });
    dispatch_source_set_cancel_handler(_timer, ^{ //计时器取消处理器；调用
        //dispatch_source_cancel 时执行
        // NSLog(@"Cancel Handler");
        dispatch_async(mainQueue, ^{
            if (self.fisishBlock) {
                self.fisishBlock();
            }
        });
    });
    dispatch_resume(_timer);  //恢复定时循环计时器；Dispatch Source 创建完后默认状态是挂起的，需要主动恢复，否则事件不会被传递，也不会被执行
}
//判断定时器是否存在
- (BOOL)isScheduled
{
    return _timer != nil;
}
//重置时间间隔
- (void)resetTimerInterval:(NSTimeInterval)timerInterval{
    [self releaseTimer];
    _timerInterval = timerInterval;
    [self cutDown];
}
//取消计时器
- (void)invalidate{
    [self releaseTimer];
}

- (void)dealloc
{
    [self releaseTimer];
}

- (void)releaseTimer{
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}
@end
