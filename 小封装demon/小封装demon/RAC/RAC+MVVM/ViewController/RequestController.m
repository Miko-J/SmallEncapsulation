//
//  RequestController.m
//  小封装demon
//
//  Created by niujinfeng on 2017/5/31.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

#import "RequestController.h"
#import "RequestViewModel.h"
#import "ReactiveObjC.h"
@interface RequestController ()

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) RequestViewModel *requesViewModel;
@end

@implementation RequestController

- (RequestViewModel *)requesViewModel
{
    if (_requesViewModel == nil) {
        _requesViewModel = [[RequestViewModel alloc] init];
    }
    return _requesViewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 创建tableView
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView = tableView;
    tableView.dataSource = self.requesViewModel;
    
    [self.view addSubview:tableView];
    
    // 执行请求
    RACSignal *requesSiganl = [self.requesViewModel.reuqesCommand execute:nil];
    
    // 获取请求的数据
    [requesSiganl subscribeNext:^(NSArray *x) {
        
        NSLog(@"获取的数组数据为%@",x);
        self.requesViewModel.models = x;
        
        [self.tableView reloadData];
        
    }];
}



@end
