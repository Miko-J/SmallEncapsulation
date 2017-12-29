//
//  PlaceHolderTableViewController.m
//  小封装demon
//
//  Created by niujinfeng on 2017/12/29.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

#import "PlaceHolderTableViewController.h"
#import "UITableView+PlaceHolderView.h"
@interface PlaceHolderTableViewController ()

@end

@implementation PlaceHolderTableViewController
{
    NSInteger _count;
}
- (void)btnClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    _count = sender.selected ? 0 : 50;
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 100, 40);
    [btn setTitle:@"清空" forState:UIControlStateNormal];
    [btn setTitle:@"添加数据" forState:UIControlStateSelected];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    //只需打开这个属性
    self.tableView.enablePlaceHolderView = YES;
    //模拟网络请求，延迟2秒
    [self performSelector:@selector(delayAction) withObject:nil afterDelay:2.0];
    
}
- (void)delayAction{
    _count = 50;
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ide"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ide"];
    }
    cell.textLabel.text = @"123";
    
    
    return cell;
}

@end
