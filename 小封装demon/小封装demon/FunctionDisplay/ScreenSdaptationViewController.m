//
//  ScreenSdaptationViewController.m
//  小封装demon
//
//  Created by niujinfeng on 2017/5/15.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

#import "ScreenSdaptationViewController.h"
#import "EncapsulationSystemControls.h"
@interface ScreenSdaptationViewController ()

@end

@implementation ScreenSdaptationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"屏幕适配";
    
    
    UILabel *lable1 = [UILabel lableWithtext:@"4.7标准" textColor:[UIColor redColor] font:[UIFont systemFontOfSize:17] bgColor:[UIColor greenColor] textAlignment: NSTextAlignmentCenter numberOfLines:0];
    lable1.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:lable1];
    
    
    UILabel *lable2 = [UILabel lableWithtext:@"适配" textColor:[UIColor redColor] font:font4Dot7(17) bgColor:[UIColor greenColor] textAlignment: NSTextAlignmentCenter numberOfLines:0];
    lable2.frame = CGRectMake(250, 100, 100 * auto4Dot7Width, 100 * auto4Dot7Height);
    [self.view addSubview:lable2];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
