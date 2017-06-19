//
//  TableListController.m
//  小封装demon
//
//  Created by niujinfeng on 2017/5/15.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

#import "TableListController.h"
#import "EncapsulationSystemControls.h"
#import "CommonlyUsedViewController.h"
#import "ScreenSdaptationViewController.h"   //屏幕适配
#import "CountdownViewController.h"          //倒计时
#import "RACTableController.h"               //RAC
#import "AlgorithmTableController.h"         //算法
#import "PingTransition.h"                   //动画
#import "AnimationTableController.h"         //动画的表
#import "ReactiveObjC.h"
@interface TableListController ()<UINavigationControllerDelegate>
@property (nonatomic, strong) NSArray *titleArray;
@end

@implementation TableListController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.delegate = self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"小封装";
    //设置右侧item
    [self setUpRightBarButtonItem];
}
//设置右侧item
- (void)setUpRightBarButtonItem{
    self.button.frame = CGRectMake(0, 0, 50, 30);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.button];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //声明一个重用ID
    static NSString *ID = @"Algorithm_Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.titleArray[indexPath.row];
    return cell;
}

#pragma mark: -delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
             [self.navigationController pushViewController:[[CommonlyUsedViewController alloc] init] animated:YES];
            break;
        case 1:
            [self.navigationController pushViewController:[[ScreenSdaptationViewController alloc] init] animated:YES];
            break;
        case 2:
            [self.navigationController pushViewController:[[CountdownViewController alloc] init] animated:YES];
            break;
        case 3:
            [self.navigationController pushViewController:[[RACTableController alloc] init] animated:YES];
        case 4:
            [self.navigationController pushViewController:[[AlgorithmTableController alloc] init] animated:YES];
        default:
            break;
    }
}
#pragma mark - UINavigationControllerDelegate

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPush) {
        
        PingTransition *ping = [PingTransition new];
        return ping;
    }else{
        return nil;
    }
}
#pragma mark：-懒加载
- (NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = @[@"常用控件",@"屏幕适配",@"倒计时",@"RAC的常用方法",@"排序算法"];
    }
    return _titleArray;
}

- (UIButton *)button{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom title:@"动画" titleColor:[UIColor blackColor] disBGImageName:nil normalBGImageName:nil];
        @weakify(self);
        [[_button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            [self.navigationController pushViewController:[[AnimationTableController alloc] init] animated:YES];
        }];
    }
    return _button;
}
@end
