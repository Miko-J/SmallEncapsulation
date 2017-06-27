//
//  AlgorithmTableController.m
//  小封装demon
//
//  Created by niujinfeng on 2017/6/16.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

#import "AlgorithmTableController.h"
#import "QuickSortController.h"
#import "BubblingController.h"
#import "SelectionSortController.h"
#import "InsertSortController.h"
@interface AlgorithmTableController ()
@property (nonatomic, strong) NSArray *titleArray;
@end

@implementation AlgorithmTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
            [self.navigationController pushViewController:[[QuickSortController alloc] init] animated:YES];
            break;
        case 1:
            [self.navigationController pushViewController:[[BubblingController alloc] init] animated:YES];
            break;
        case 2:
            [self.navigationController pushViewController:[[SelectionSortController alloc] init] animated:YES];
            break;
        case 3:
            [self.navigationController pushViewController:[[InsertSortController alloc] init] animated:YES];
            break;
        default:
            break;
    }
}
#pragma mark：-懒加载
- (NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = @[@"快排",@"冒泡",@"选择",@"插入"];
    }
    return _titleArray;
}

@end
