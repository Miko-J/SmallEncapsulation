//
//  CountdownTimer.h
//  1111111111
//
//  Created by niujinfeng on 2017/5/13.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^timingBlock)(NSInteger totalTime);
typedef void (^fisishBlock)();

@interface CountdownTimer : NSObject

- (instancetype)initWithTimerInterval: (NSTimeInterval)timerInterval totalTime:(NSInteger)totalTime timingBlock:(timingBlock) timingBlock fisishBlock:(fisishBlock)fisishBlock;

//倒计时
- (void)cutDown;

//定时器是否存在
- (BOOL)isScheduled;

//取消计时器
- (void)invalidate;

//重置时间间隔
- (void)resetTimerInterval:(NSTimeInterval)timerInterval;
@end
