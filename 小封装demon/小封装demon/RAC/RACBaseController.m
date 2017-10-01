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
@property (nonatomic, weak) UITextField *textfield1;
@property (nonatomic, weak) UITextField *textfield2;
@property (nonatomic, weak) RACView *RACView;
@property (nonatomic, strong) RACCommand *conmmand;
@end

@implementation RACBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //1 RACSiganl简单使用
    [self RACSingalSimpleUse];
    
    //2.RACSubject和RACReplaySubject简单使用
    [self RACSubjectAndRACReplaySubjectSimpleUse];
    
    //3.RACMulticastConnection简单使用
    [self RACMulticastConnectionSimpleUse];
    
    //4.RACCommand简单使用
    [self RACCommandSimpleUse];
    
    //5.遍历
    [self traverse];
    
    //6.事件监听和代理方法
    [self signalForControlEvents];
    
    //7.通知
    [self addNotification];
    
    //8.监听文本框文字的改变
    [self detectionText];
    
    //9.kvo
    [self kvo];
    
    //10.合并两个输入框信号，并返回按钮bool类型的值
    [self mergeSingal];
    
    //11.处理多个请求，都返回结果的时候，统一做处理.
    [self dealMultipleSingal];
}
//1 RACSiganl简单使用
- (void)RACSingalSimpleUse{
    
    /*说明 RACSiganl:信号类,一般表示将来有数据传递，只要有数据改变，信号内部接收到数据，就会马上发出数据。
    
    信号类(RACSiganl)，只是表示当数据改变时，信号内部会发出数据，它本身不具备发送信号的能力，而是交给内部一个订阅者去发出。
    
    默认一个信号都是冷信号，也就是值改变了，也不会触发，只有订阅了这个信号，这个信号才会变为热信号，值改变了才会触发。
    
    如何订阅信号：调用信号RACSignal的subscribeNext就能订阅。*/
    
    
    // RACSignal使用步骤：
    // 1.创建信号 + (RACSignal *)createSignal:(RACDisposable * (^)(id<RACSubscriber> subscriber))didSubscribe
    // 2.订阅信号,才会激活信号. - (RACDisposable *)subscribeNext:(void (^)(id x))nextBlock
    // 3.发送信号 - (void)sendNext:(id)value
    
    
    // RACSignal底层实现：
    // 1.创建信号，首先把didSubscribe保存到信号中，还不会触发。
    // 2.当信号被订阅，也就是调用signal的subscribeNext:nextBlock
    // 2.1 subscribeNext内部会创建订阅者subscriber，并且把nextBlock保存到subscriber中。
    // 2.2 subscribeNext内部会调用siganl的didSubscribe
    // 3.siganl的didSubscribe中调用[subscriber sendNext:@1];
    // 3.1 sendNext底层其实就是执行subscriber的nextBlock
    
    // 1.创建信号(冷信号)
    RACSignal *siganl = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        // block调用时刻：每当有订阅者订阅信号，就会调用block。
        
        // 3.发送信号
        [subscriber sendNext:@1];
        
        // 如果不在发送数据，最好发送信号完成，内部会自动调用[RACDisposable disposable]取消订阅信号。
        [subscriber sendCompleted];
        
        return [RACDisposable disposableWithBlock:^{
            
            // block调用时刻：当信号发送完成或者发送错误，就会自动执行这个block,取消订阅信号。
            
            // 执行完Block后，当前信号就不在被订阅了。
            
            NSLog(@"信号被销毁");
            
        }];
    }];
    
    // 2.订阅信号,才会激活信号.(热信号)
    [siganl subscribeNext:^(id x) {
        // block调用时刻：每当有信号发出数据，就会调用block.
        NSLog(@"接收到数据:%@",x);
    }];
}
//2.RACSubject和RACReplaySubject简单使用
- (void)RACSubjectAndRACReplaySubjectSimpleUse{
    /*RACSubscriber:表示订阅者的意思，用于发送信号，这是一个协议，不是一个类，只要遵守这个协议，并且实现方法才能成为订阅者。通过create创建的信号，都有一个订阅者，帮助他发送数据。
        
    RACDisposable:用于取消订阅或者清理资源，当信号发送完成或者发送错误的时候，就会自动触发它。
        
        使用场景:不想监听某个信号时，可以通过它主动取消订阅信号。
    RACSubject:RACSubject:信号提供者，自己可以充当信号，又能发送信号。
        
        使用场景:通常用来代替代理，有了它，就不必要定义代理了。
    RACReplaySubject:重复提供信号类，RACSubject的子类。
        
        RACReplaySubject与RACSubject区别:
        RACReplaySubject可以先发送信号，在订阅信号，RACSubject就不可以。
        使用场景一:如果一个信号每被订阅一次，就需要把之前的值重复发送一遍，使用重复提供信号类。
        使用场景二:可以设置capacity数量来限制缓存的value的数量,即只缓充最新的几个值。*/
    
    // RACSubject使用步骤
    // 1.创建信号 [RACSubject subject]，跟RACSiganl不一样，创建信号时没有block。
    // 2.订阅信号 - (RACDisposable *)subscribeNext:(void (^)(id x))nextBlock
    // 3.发送信号 sendNext:(id)value
    
    // RACSubject:底层实现和RACSignal不一样。
    // 1.调用subscribeNext订阅信号，只是把订阅者保存起来，并且订阅者的nextBlock已经赋值了。
    // 2.调用sendNext发送信号，遍历刚刚保存的所有订阅者，一个一个调用订阅者的nextBlock。
    
    // 1.创建信号
    RACSubject *subject = [RACSubject subject];
    
    // 2.订阅信号
    [subject subscribeNext:^(id x) {
        // block调用时刻：当信号发出新值，就会调用.
        NSLog(@"第一个订阅者%@",x);
    }];
    [subject subscribeNext:^(id x) {
        // block调用时刻：当信号发出新值，就会调用.
        NSLog(@"第二个订阅者%@",x);
    }];
    
    // 3.发送信号
    [subject sendNext:@"1"];
    
    
    // RACReplaySubject使用步骤:
    // 1.创建信号 [RACSubject subject]，跟RACSiganl不一样，创建信号时没有block。
    // 2.可以先订阅信号，也可以先发送信号。
    // 2.1 订阅信号 - (RACDisposable *)subscribeNext:(void (^)(id x))nextBlock
    // 2.2 发送信号 sendNext:(id)value
    
    // RACReplaySubject:底层实现和RACSubject不一样。
    // 1.调用sendNext发送信号，把值保存起来，然后遍历刚刚保存的所有订阅者，一个一个调用订阅者的nextBlock。
    // 2.调用subscribeNext订阅信号，遍历保存的所有值，一个一个调用订阅者的nextBlock
    
    // 如果想当一个信号被订阅，就重复播放之前所有值，需要先发送信号，在订阅信号。
    // 也就是先保存值，在订阅值。
    
    // 1.创建信号
    RACReplaySubject *replaySubject = [RACReplaySubject subject];
    
    // 2.发送信号
    [replaySubject sendNext:@1];
    [replaySubject sendNext:@2];
    
    // 3.订阅信号
    [replaySubject subscribeNext:^(id x) {
        
        NSLog(@"第一个订阅者接收到的数据%@",x);
    }];
    
    // 订阅信号
    [replaySubject subscribeNext:^(id x) {
        
        NSLog(@"第二个订阅者接收到的数据%@",x);
    }];
}
//3.RACMulticastConnection简单使用
- (void)RACMulticastConnectionSimpleUse{
    /*
     RACMulticastConnection:用于当一个信号，被多次订阅时，为了保证创建信号时，避免多次调用创建信号中的block，造成副作用，可以使用这个类处理。
     
     使用注意:RACMulticastConnection通过RACSignal的-publish或者-muticast:方法创建.
     */
    // RACMulticastConnection使用步骤:
    // 1.创建信号 + (RACSignal *)createSignal:(RACDisposable * (^)(id<RACSubscriber> subscriber))didSubscribe
    // 2.创建连接 RACMulticastConnection *connect = [signal publish];
    // 3.订阅信号,注意：订阅的不在是之前的信号，而是连接的信号。 [connect.signal subscribeNext:nextBlock]
    // 4.连接 [connect connect]
    
    // RACMulticastConnection底层原理:
    // 1.创建connect，connect.sourceSignal -> RACSignal(原始信号)  connect.signal -> RACSubject
    // 2.订阅connect.signal，会调用RACSubject的subscribeNext，创建订阅者，而且把订阅者保存起来，不会执行block。
    // 3.[connect connect]内部会订阅RACSignal(原始信号)，并且订阅者是RACSubject
    // 3.1.订阅原始信号，就会调用原始信号中的didSubscribe
    // 3.2 didSubscribe，拿到订阅者调用sendNext，其实是调用RACSubject的sendNext
    // 4.RACSubject的sendNext,会遍历RACSubject所有订阅者发送信号。
    // 4.1 因为刚刚第二步，都是在订阅RACSubject，因此会拿到第二步所有的订阅者，调用他们的nextBlock
    
    
    // 需求：假设在一个信号中发送请求，每次订阅一次都会发送请求，这样就会导致多次请求。
    // 解决：使用RACMulticastConnection就能解决.
    
    // 1.创建请求信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        
        NSLog(@"发送请求");
        
        return nil;
    }];
    // 2.订阅信号
    [signal subscribeNext:^(id x) {
        
        NSLog(@"接收数据");
        
    }];
    // 2.订阅信号
    [signal subscribeNext:^(id x) {
        
        NSLog(@"接收数据");
        
    }];
    
    
    // RACMulticastConnection:解决重复请求问题
    // 1.创建信号
    RACSignal *mulSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        
        NSLog(@"发送请求");
        [subscriber sendNext:@1];
        
        return nil;
    }];
    
    // 2.创建连接
    RACMulticastConnection *connect = [mulSignal publish];
    
    // 3.订阅信号，
    // 注意：订阅信号，也不能激活信号，只是保存订阅者到数组，必须通过连接,当调用连接，就会一次性调用所有订阅者的sendNext:
    [connect.signal subscribeNext:^(id x) {
        
        NSLog(@"订阅者一信号");
        
    }];
    
    [connect.signal subscribeNext:^(id x) {
        
        NSLog(@"订阅者二信号");
        
    }];
    
    // 4.连接,激活信号
    [connect connect];
}
//4.RACCommand简单使用
- (void)RACCommandSimpleUse{
 /*
  RACCommand:RAC中用于处理事件的类，可以把事件如何处理,事件中的数据如何传递，包装到这个类中，他可以很方便的监控事件的执行过程。
  
  使用场景:监听按钮点击，网络请求
  */
    // 一、RACCommand使用步骤:
    // 1.创建命令 initWithSignalBlock:(RACSignal * (^)(id input))signalBlock
    // 2.在signalBlock中，创建RACSignal，并且作为signalBlock的返回值
    // 3.执行命令 - (RACSignal *)execute:(id)input
    
    // 二、RACCommand使用注意:
    // 1.signalBlock必须要返回一个信号，不能传nil.
    // 2.如果不想要传递信号，直接创建空的信号[RACSignal empty];
    // 3.RACCommand中信号如果数据传递完，必须调用[subscriber sendCompleted]，这时命令才会执行完毕，否则永远处于执行中。
    
    // 三、RACCommand设计思想：内部signalBlock为什么要返回一个信号，这个信号有什么用。
    // 1.在RAC开发中，通常会把网络请求封装到RACCommand，直接执行某个RACCommand就能发送请求。
    // 2.当RACCommand内部请求到数据的时候，需要把请求的数据传递给外界，这时候就需要通过signalBlock返回的信号传递了。
    
    // 四、如何拿到RACCommand中返回信号发出的数据。
    // 1.RACCommand有个执行信号源executionSignals，这个是signal of signals(信号的信号),意思是信号发出的数据是信号，不是普通的类型。
    // 2.订阅executionSignals就能拿到RACCommand中返回的信号，然后订阅signalBlock返回的信号，就能获取发出的值。
    
    // 五、监听当前命令是否正在执行executing
    
    // 六、使用场景,监听按钮点击，网络请求
    
    
    // 1.创建命令
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        
        NSLog(@"执行命令");
        
        // 创建空信号,必须返回信号
        //        return [RACSignal empty];
        
        // 2.创建信号,用来传递数据
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [subscriber sendNext:@"请求数据"];
            
            // 注意：数据传递完，最好调用sendCompleted，这时命令才执行完毕。
            [subscriber sendCompleted];
            
            return nil;
        }];
        
    }];
    
    // 强引用命令，不要被销毁，否则接收不到数据
    _conmmand = command;
    
    
    // 3.执行命令
    [self.conmmand execute:@1];
    
    // 4.订阅RACCommand中的信号
    [command.executionSignals subscribeNext:^(id x) {
        
        [x subscribeNext:^(id x) {
            
            NSLog(@"%@",x);
        }];
        
    }];
    
    // RAC高级用法
    // switchToLatest:用于signal of signals，获取signal of signals发出的最新信号,也就是可以直接拿到RACCommand中的信号
    [command.executionSignals.switchToLatest subscribeNext:^(id x) {
        
        NSLog(@"%@",x);
    }];
    
    // 5.监听命令是否执行完毕,默认会来一次，可以直接跳过，skip表示跳过第一次信号。
    [[command.executing skip:1] subscribeNext:^(id x) {
        
        if ([x boolValue] == YES) {
            // 正在执行
            NSLog(@"正在执行");
            
        }else{
            // 执行完成
            NSLog(@"执行完成");
        }
        
    }];
}

//5.遍历
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
  
    // 把参数中的数据包装成元组
//    RACTuple *tuple = RACTuplePack(@10,@20);
//    RACTupleUnpack(NSString *name,NSNumber *age) = tuple;
}
//6.事件监听和代理方法
- (void)signalForControlEvents{
    RACView *view = [[RACView alloc] init];
    self.RACView = view;
    view.delegateSingle = [RACSubject subject];
    view.frame = CGRectMake(100, 100, 250, 100);
    [self.view addSubview:view];
    
    @weakify(self)
    [view.delegateSingle subscribeNext:^(NSString * x) {
        @strongify(self)
        [UIAlertController alertWithTitle:@"执行了代理方法" message:[NSString stringWithFormat:@"获取到的值 %@",x] target:self confirmText:@"老夫知道了"];
    }];
}

//7.通知
- (void)addNotification{
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillChangeFrameNotification object:nil] subscribeNext:^(NSNotification *notification) {
        NSDictionary *info = [notification userInfo];
        NSValue *keyboardFrameValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
        CGRect keyboardFrame = [keyboardFrameValue CGRectValue];
        
        CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        NSLog(@"键盘弹出的高度%f  键盘弹出的时间%f",keyboardFrame.size.height,duration);
    }];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}
//8.监听文本框文字的改变
- (void)detectionText{
    UITextField *textfield1 = [[UITextField alloc] initWithFrame:CGRectMake(100, 300, 200, 30)];
    self.textfield1 = textfield1;
    textfield1.layer.borderWidth = 1;
    textfield1.layer.borderColor = [UIColor lightGrayColor].CGColor;
    textfield1.placeholder = @"请输入内容";
    [self.view addSubview:textfield1];
    [textfield1.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"textfield输入的内容为 %@",x);
    }];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

//9.kvo
- (void)kvo{
    self.textfield1.text = @"textfield赋值了";
   [RACObserve(self.textfield1, text) subscribeNext:^(id  _Nullable x) {
       NSLog(@"textfield的kvo值变化 %@",x);
   }];
}

//10.合并两个输入框信号，并返回按钮bool类型的值
- (BOOL)mergeSingal{
    UITextField *textfield2 = [[UITextField alloc] initWithFrame:CGRectMake(100, 350, 200, 30)];
    self.textfield2 = textfield2;
    textfield2.layer.borderWidth = 1;
    textfield2.layer.borderColor = [UIColor lightGrayColor].CGColor;
    textfield2.placeholder = @"请输入内容";
    [self.view addSubview:textfield2];
    
    RACSignal *isValid = [RACSignal combineLatest:@[self.textfield1.rac_textSignal, self.textfield2.rac_textSignal] reduce:^(NSString *text1,NSString *text2){
        return @(text1.length && text2.length);
    }];
    RAC(self.RACView.btn,enabled) = isValid;
    return isValid;
}
//11.处理多个请求，都返回结果的时候，统一做处理.
- (void)dealMultipleSingal{
    RACSignal *request1 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        // 发送请求1
        [subscriber sendNext:@"发送请求1"];
        return nil;
    }];
    
    RACSignal *request2 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        // 发送请求2
        [subscriber sendNext:@"发送请求2"];
        return nil;
    }];
    
    // 使用注意：几个信号，参数一的方法就几个参数，每个参数对应信号发出的数据。
    [self rac_liftSelector:@selector(updateUIWithR1:R2:) withSignalsFromArray:@[request1,request2]];
}
// 更新UI
- (void)updateUIWithR1:(id)data R2:(id)data1
{
    NSLog(@"更新UI%@  %@",data,data1);
}
@end
