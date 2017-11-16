//
//  CodeSpecification.h
//  小封装demon
//
//  Created by niujinfeng on 2017/11/9.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

#ifndef CodeSpecification_h
#define CodeSpecification_h

#pragma mark: 1.控制器中的代码规范
#pragma mark - Lifecycle

- (instancetype)init {}
- (void)dealloc {}
- (void)viewDidLoad {}
- (void)viewWillAppear:(BOOL)animated {}
- (void)didReceiveMemoryWarning {}

#pragma mark - Custom Accessors

- (void)setCustomProperty:(id)value {}
- (id)customProperty {}

#pragma mark - IBActions

- (IBAction)submitData:(id)sender {}

#pragma mark - Public

- (void)publicMethod {}

#pragma mark - Private

- (void)privateMethod {}

#pragma mark - Protocol conformance
#pragma mark - UITextFieldDelegate
#pragma mark - UITableViewDataSource
#pragma mark - UITableViewDelegate

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {}

#pragma mark - NSObject

- (NSString *)description {}


#prama mark: 2-block的弱引用
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
    

#prama mark: 3-枚举的使用

typedef NS_OPTIONS(NSUInteger, UIControlState) {
    UIControlStateNormal       = 0,
    UIControlStateHighlighted  = 1 << 0,
    UIControlStateDisabled     = 1 << 1,
};
    
    
#prama mark: 4-继承，在父类方法中的声明
//场景需求:在继承中,凡是要求子类重写父类的方法必须先调用父类的这个方法进行初始化操作;建议:父类的方法名后面加上NS_REQUIRES_SUPER; 子类重写这个方法就会自动警告提示要调用这个super方法,示例代码
// 注意:父类中的方法加`NS_REQUIRES_SUPER`,子类重写才有警告提示
- (void)prepare NS_REQUIRES_SUPER;
  

#prama mark: 5-IF条件句的写法
//判断if书写方式建议这样写
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) return 44;
    if (indexPath.row == 1) return 80;
    if (indexPath.row == 2) return 50;
    return 44;
}

#prama mark: 6-NSDictionary的另一种写法
// NSDictionaryOfVariableBindings这个宏生成一个字典,这个宏可以生成一个变量名到变量值映射的Dictionary,比如:
NSNumber * packId=@(2);
NSNumber *userId=@(22);
NSNumber *proxyType=@(2);
NSDictionary *param=NSDictionaryOfVariableBindings(packId,userId,proxyType);



#prama mark: 7-点语法
//美观写法
NSInteger arrayCount = self.array.count;
view.backgroundColor = [UIColor orangeColor];
[UIApplication sharedApplication].delegate;

//不美观写法
NSInteger arrayCount = [self.array count];
[view setBackgroundColor:[UIColor orangeColor]];
[[UIApplication sharedApplication] delegate];



#prama mark: 8-字面值
//美观写法
//NSString, NSDictionary, NSArray, 和 NSNumber的字面值应该在创建这些类的不可变实例时被使用。请特别注意nil值不能传入NSArray和NSDictionary字面值，因为这样会导致crash。
NSArray *names = @[@"Brian", @"Matt", @"Chris", @"Alex", @"Steve", @"Paul"];
NSDictionary *productManagers = @{@"iPhone": @"Kate", @"iPad": @"Kamal", @"Mobile Web": @"Bill"};
NSNumber *shouldUseLiterals = @YES;
NSNumber *buildingStreetNumber = @10018;

//不美观写法
NSArray *names = [NSArray arrayWithObjects:@"Brian", @"Matt", @"Chris", @"Alex", @"Steve", @"Paul", nil];
NSDictionary *productManagers = [NSDictionary dictionaryWithObjectsAndKeys: @"Kate", @"iPhone", @"Kamal", @"iPad", @"Bill", @"Mobile Web", nil];
NSNumber *shouldUseLiterals = [NSNumber numberWithBool:YES];
NSNumber *buildingStreetNumber = [NSNumber numberWithInteger:10018];


#prama mark: 9-常量
//美观写法
//常量是容易重复被使用和无需通过查找和代替就能快速修改值。常量应该使用static来声明而不是使用#define，除非显式地使用宏。
static NSString * const RWTAboutViewControllerCompanyName = @"RayWenderlich.com";

static CGFloat const RWTImageThumbnailHeight = 50.0;

//不美观写法
#define CompanyName @"RayWenderlich.com"

#define thumbnailHeight 2


#prama mark: 10-三目运算符/BOOL赋值
//如果是存在就赋值本身
//美观写法
result = object ? : [self createObject];
//不美观写法
result = object ? object : [self createObject];

//美观写法
BOOL isAdult = age > 18;

//不美观写法
BOOL isAdult;
if (age > 18)
{
    isAdult = YES;
}
else
{
    isAdult = NO;
}


#prama mark: 11-拒绝死值
//美观写法
if (car == Car.Nissan)
or
const int adultAge = 18; if (age > adultAge) { ... }
//不美观写法
if (carName == "Nissan")
or
if (age > 18) { ... }


#prama mark: 12-复杂的条件判断
//美观写法,清晰明了, 每个函数DO ONE THING!
if ([self canDeleteJob:job]) { ... }

- (BOOL)canDeleteJob:(Job *)job
{
    BOOL invalidJobState = job.JobState == JobState.New
    || job.JobState == JobState.Submitted
    || job.JobState == JobState.Expired;
    BOOL invalidJob = job.JobTitle && job.JobTitle.length;
    
    return invalidJobState || invalidJob;
}

//不美观写法
if (job.JobState == JobState.New
    || job.JobState == JobState.Submitted
    || job.JobState == JobState.Expired
    || (job.JobTitle && job.JobTitle.length))
{
    //....
}

#prama mark: 13-嵌套判断
//美观写法
if (!user.UserName) return NO;
if (!user.Password) return NO;
if (!user.Email) return NO;

return YES;

//不美观写法
BOOL isValid = NO;
if (user.UserName)
{
    if (user.Password)
    {
        if (user.Email) isValid = YES;
            }
}
return isValid;


#prama mark: 14-参数过多
//美观写法
- (void)registerUser(User *user)
{
    // to do...
}

//不美观写法
- (void)registerUserName:(NSString *)userName
password:(NSString *)password
email:(NSString *)email
{
    // to do...
}


#endif /* CodeSpecification_h */
