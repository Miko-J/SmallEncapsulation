//
//  CodeSpecification.h
//  小封装demon
//
//  Created by niujinfeng on 2017/11/9.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

#ifndef CodeSpecification_h
#define CodeSpecification_h


#prama mark: 1-block的弱引用
//避免循环引用
//如果【block内部】使用【外部声明的强引用】访问【对象A】, 那么【block内部】会自动产生一个【强引用】指向【对象A】
//如果【block内部】使用【外部声明的弱引用】访问【对象A】, 那么【block内部】会自动产生一个【弱引用】指向【对象A】
__weak typeof(self) weakSelf = self;
dispatch_block_t block = ^{
    [weakSelf doSomething]; // weakSelf != nil
    // preemption, weakSelf turned nil
    [weakSelf doSomethingElse]; // weakSelf == nil
};
//最好这样调用：
__weak typeof(self) weakSelf = self;
myObj.myBlock = ^{
    __strong typeof(self) strongSelf = weakSelf;
    if (strongSelf) {
        [strongSelf doSomething]; // strongSelf != nil
        // preemption, strongSelf still not nil（抢占的时候，strongSelf 还是非 nil 的)
        [strongSelf doSomethingElse]; // strongSelf != nil }
        else { // Probably nothing... return;
        }
    }
};
    

#prama mark: 2-枚举的使用

typedef NS_OPTIONS(NSUInteger, UIControlState) {
    UIControlStateNormal       = 0,
    UIControlStateHighlighted  = 1 << 0,
    UIControlStateDisabled     = 1 << 1,
};
    
    
#prama mark: 3-继承，在父类方法中的声明
//场景需求:在继承中,凡是要求子类重写父类的方法必须先调用父类的这个方法进行初始化操作;建议:父类的方法名后面加上NS_REQUIRES_SUPER; 子类重写这个方法就会自动警告提示要调用这个super方法,示例代码
// 注意:父类中的方法加`NS_REQUIRES_SUPER`,子类重写才有警告提示
- (void)prepare NS_REQUIRES_SUPER;
  

#prama mark: 4-IF条件句的写法
//判断if书写方式建议这样写
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) return 44;
    if (indexPath.row == 1) return 80;
    if (indexPath.row == 2) return 50;
    return 44;
}

#prama mark: 5-NSDictionary的另一种写法
// NSDictionaryOfVariableBindings这个宏生成一个字典,这个宏可以生成一个变量名到变量值映射的Dictionary,比如:
NSNumber * packId=@(2);
NSNumber *userId=@(22);
NSNumber *proxyType=@(2);
NSDictionary *param=NSDictionaryOfVariableBindings(packId,userId,proxyType);

#endif /* CodeSpecification_h */
