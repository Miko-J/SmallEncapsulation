//
//  CommonlyUsedViewController.m
//  小封装demon
//
//  Created by niujinfeng on 2017/5/15.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

#import "CommonlyUsedViewController.h"
#import "EncapsulationSystemControls.h"
@interface CommonlyUsedViewController ()
@property (nonatomic, assign) BOOL flag;
@end

@implementation CommonlyUsedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"常用控件方法封装";
    _flag = NO;
    
    NSMutableAttributedString *aStr = [NSMutableAttributedString attributeWithStr:@"这是一个lable"];
    [aStr rangeWithTitle:@"这是一个" font:font4Dot7(17) color:[UIColor greenColor]];
    [aStr rangeWithTitle:@"lable" font:font4Dot7(21) color:[UIColor redColor]];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(100, 300, 150, 100)];
    lable.hidden = YES;
    lable.attributedText = aStr;
    [self.view addSubview:lable];
    
    
    __weak __typeof(&*self)weakSelf = self;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom title:@"点击按钮" titleColor:[UIColor redColor] imageName:nil bgImageName:nil highImageName:nil selBgImageName:nil btnClickedBlock:^{
        NSLog(@"点击了按钮");
        _flag = !_flag;
        [weakSelf showLable:lable];
    }];
    btn.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:btn];
    
}

- (void)showLable:(UILabel *)lable{
    lable.hidden = !_flag;
}

@end
