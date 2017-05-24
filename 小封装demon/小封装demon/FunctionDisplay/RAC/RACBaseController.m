//
//  RACBaseController.m
//  小封装demon
//
//  Created by niujinfeng on 2017/5/24.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

#import "RACBaseController.h"
#import "EncapsulationSystemControls.h"
#import "ReactiveObjC.h"
#import "RACView.h"
@interface RACBaseController ()

@end

@implementation RACBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //1.遍历
    [self traverse];
    
    //2.事件监听和代理方法
    [self signalForControlEvents];
}

//1.遍历
- (void)traverse{
    // 1.遍历数组
    NSArray *numbers = @[@1,@2,@3,@4];
    // 这里其实是三步
    // 第一步: 把数组转换成集合RACSequence numbers.rac_sequence
    // 第二步: 把集合RACSequence转换RACSignal信号类,numbers.rac_sequence.signal
    // 第三步: 订阅信号，激活信号，会自动把集合中的所有值，遍历出来。
    [numbers.rac_sequence.signal subscribeNext:^(id x) {
        NSLog(@"数组遍历的结果：%@",x);
    }];
    
    
    // 2.遍历字典,遍历出来的键值对会包装成RACTuple(元组对象)
    NSDictionary *dict = @{@"name":@"xmg",@"age":@18};
    [dict.rac_sequence.signal subscribeNext:^(RACTuple *x) {
        
        // 解包元组，会把元组的值，按顺序给参数里面的变量赋值
        RACTupleUnpack(NSString *key,NSString *value) = x;
        
        // 相当于以下写法
        //        NSString *key = x[0];
        //        NSString *value = x[1];
        
        NSLog(@"%@ %@",key,value);
    }];
  
}

//2.事件监听和代理方法
- (void)signalForControlEvents{
    RACView *view = [[RACView alloc] init];
    view.delegateSingle = [RACSubject subject];
    view.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:view];
    
    @weakify(self)
    [view.delegateSingle subscribeNext:^(NSString * x) {
        @strongify(self)
        [UIAlertController alertWithTitle:@"执行了代理方法" message:[NSString stringWithFormat:@"获取到的值 %@",x] target:self confirmText:@"确定"];
    }];
}


@end
