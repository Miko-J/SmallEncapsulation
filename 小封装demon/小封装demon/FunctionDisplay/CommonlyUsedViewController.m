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

@end

@implementation CommonlyUsedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"常用控件方法封装";
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom createBtnWithtitle:@"按钮" titleColor:[UIColor redColor] imageName:nil bgImageName:nil highImageName:nil selBgImageName:nil btnClickedBlock:^{
        NSLog(@"点击了按钮");
    }];
    btn.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:btn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
