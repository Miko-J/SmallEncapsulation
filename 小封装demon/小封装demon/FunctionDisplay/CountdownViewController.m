//
//  CountdownViewController.m
//  小封装demon
//
//  Created by niujinfeng on 2017/5/15.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

#import "CountdownViewController.h"
#import "EncapsulationSystemControls.h"
#import "CountdownTimer.h"
@interface CountdownViewController ()

@end

@implementation CountdownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"倒计时";
    
    UILabel *lable = [UILabel lableWithtext:@"初始状态" textColor:[UIColor redColor] font:font4Dot7(17) bgColor:[UIColor greenColor] textAlignment: NSTextAlignmentCenter numberOfLines:0];
    lable.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:lable];
    

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CountdownTimer *timer = [[CountdownTimer alloc] initWithTimerInterval:1 totalTime:10 timingBlock:^(NSInteger totalTime) {
            lable.text = [NSString stringWithFormat:@"%lds",(long)totalTime];
        } fisishBlock:^{
            lable.text = @"结束";
        }];
        [timer cutDown];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
