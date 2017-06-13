//
//  CommonlyUsedViewController.m
//  小封装demon
//
//  Created by niujinfeng on 2017/5/15.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

#import "CommonlyUsedViewController.h"
#import "EncapsulationSystemControls.h"
static int commonSize = 100;
/*
const与宏的区别:

const简介:之前常用的字符串常量，一般是抽成宏，但是苹果不推荐我们抽成宏，推荐我们使用const常量。

编译时刻:宏是预编译（编译之前处理），const是编译阶段。
编译检查:宏不做检查，不会报编译错误，只是替换，const会编译检查，会报编译错误。
宏的好处:宏能定义一些函数，方法。 const不能。
宏的坏处:使用大量宏，容易造成编译时间久，每次都需要重新替换。
 
 注意:很多Blog都说使用宏，会消耗很多内存，我这验证并不会生成很多内存，宏定义的是常量，常量都放在常量区，只会生成一份内存。
 
  static与const作用:声明一个只读的静态变量
 
 1.static关键字修饰局部变量：1：当static关键字修饰局部变量时，该局部变量只会初始化一次，在系统中只有一份内存   2：static关键字不可以改变局部变量的作用域，但是可延长局部变量的生命周期，该变量直到整个项目结束的时候才会被销毁
 
 2：static修饰的全局变量：作用域仅限于当前文件，外部类不可以访问到该变量
 
 
 3：extern：引用关键字，当某一个全局变量，没有用static修饰时，其作用域为整个项目文件，若是在其他类想引用该变量，则用extern关键字，例如，想引用其他类的全局变量，int age = 10；则在当前类中实现，extern int age；也可以在外部修改该变量，extern int age = 40；，若某个文件中的全局变量不想被外界修改，则用static修饰该变量，则其作用域只限于该文件
 */
@interface CommonlyUsedViewController ()
@property (nonatomic, assign) BOOL flag;
@end

@implementation CommonlyUsedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"常用控件方法封装";
    
    NSLog(@"定义的全局变量的name = %@",name);
    
    _flag = NO;
    
    NSMutableAttributedString *aStr = [NSMutableAttributedString attributeWithStr:@"这是一个lable"];
    [aStr rangeWithTitle:@"这是一个" font:font4Dot7(17) color:[UIColor greenColor]];
    [aStr rangeWithTitle:@"lable" font:font4Dot7(21) color:[UIColor redColor]];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(commonSize, 300, 150, commonSize)];
    lable.hidden = YES;
    lable.attributedText = aStr;
    [self.view addSubview:lable];
    
    
    __weak __typeof(&*self)weakSelf = self;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom title:@"点击按钮" titleColor:[UIColor redColor] imageName:nil bgImageName:nil highImageName:nil selBgImageName:nil btnClickedBlock:^{
        NSLog(@"点击了按钮");
        _flag = !_flag;
        [weakSelf showLable:lable];
    }];
    btn.frame = CGRectMake(commonSize, commonSize, commonSize, commonSize);
    [self.view addSubview:btn];
    
}

- (void)showLable:(UILabel *)lable{
    lable.hidden = !_flag;
}

@end
