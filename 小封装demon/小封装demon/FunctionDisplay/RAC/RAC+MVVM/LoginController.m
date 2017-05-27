//
//  LoginController.m
//  小封装demon
//
//  Created by niujinfeng on 2017/5/26.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

#import "LoginController.h"
#import "EncapsulationSystemControls.h"
#import "ReactiveObjC.h"
#import "LoginViewModel.h"
@interface LoginController ()

@property (nonatomic, strong) LoginViewModel *loginViewModel;
@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UITextField *nameTF;
@property (nonatomic, strong) UITextField *passWdTF;
@property (nonatomic, strong) UIButton *loginBtn;
@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
#warning 控制器中的ui完全可以在view中写，这样控制器就显得很轻便,这里比较懒就不写了😃
    //设置ui
    [self setUpUI];
}
//设置ui
- (void)setUpUI{
    //添加背景
    [self.view addSubview:self.backImageView];
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    //添加输入框
    [self.backImageView addSubview:self.nameTF];
    
    [self.backImageView addSubview:self.passWdTF];
    
    //天际登录按钮
    [self.view addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backImageView).offset(50);
        make.right.bottom.equalTo(self.backImageView).offset(-50);
        make.height.equalTo(@35);
    }];
    //绑定模型
    [self bindModel];
}
//绑定模型
- (void)bindModel{
    // 只要账号文本框一改变，就会给account赋值
    RAC(self.loginViewModel.account, name) = _nameTF.rac_textSignal;
    RAC(self.loginViewModel.account, pwd) = _passWdTF.rac_textSignal;
    
    // 绑定登录按钮
    RAC(self.loginBtn,enabled) = self.loginViewModel.enableLoginSignal;
    
    //按钮的点击事件
    @weakify(self);
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"点击了按钮");
        @strongify(self);
        // 执行登录事件
        [self.loginViewModel.LoginCommand execute:nil];
    }];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
#pragma mark: -懒加载
- (LoginViewModel *)loginViewModel
{
    if (_loginViewModel == nil) {
        
        _loginViewModel = [[LoginViewModel alloc] init];
    }
    return _loginViewModel;
}

- (UIImageView *)backImageView{
    if (!_backImageView) {
        _backImageView = [UIImageView imageWithName:@"003"];
        _backImageView.userInteractionEnabled = YES;
    }
    return _backImageView;
}
- (UITextField *)nameTF{
    if (!_nameTF) {
        _nameTF = [[UITextField alloc] init];
        _nameTF.placeholder = @"请输入姓名";
        CGFloat _nameTFX = (self.view.width - 200) / 2;
        _nameTF.frame = CGRectMake(_nameTFX, 150, 200, 30);
#warning 绘制控件的圆角需先知道控件的frame，用masonry布局获取不到
        [_nameTF setCornerRadius:5 borderWidth:1 borderColor:[UIColor whiteColor]];
    }
    return _nameTF;
}
- (UITextField *)passWdTF{
    if (!_passWdTF) {
        _passWdTF = [[UITextField alloc] init];
        _passWdTF.placeholder = @"请输入密码";
        _passWdTF.frame = CGRectMake(self.nameTF.x, CGRectGetMaxY(self.nameTF.frame) + 100, self.nameTF.width, self.nameTF.height);
        [_passWdTF setCornerRadius:5 borderWidth:1 borderColor:[UIColor whiteColor]];
    }
    return _passWdTF;
}
- (UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom title:@"登录" titleColor:[UIColor whiteColor] disBGImageName:@"btn_bg_dis" normalBGImageName:@"btn_bg_normal"];
    }
    return _loginBtn;
}
@end
