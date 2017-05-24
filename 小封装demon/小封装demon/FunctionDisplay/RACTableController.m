//
//  RACTableController.m
//  小封装demon
//
//  Created by niujinfeng on 2017/5/22.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

#import "RACTableController.h"
#import "RACBaseController.h"
@interface RACTableController ()
@property (nonatomic, strong) NSArray *titleArray;
@end

@implementation RACTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"RAC";
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
    static NSString *ID = @"deviceDetailsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    cell.textLabel.text = self.titleArray[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        [self.navigationController pushViewController:[[RACBaseController alloc] init] animated:YES];
    }
}
#pragma mark：-懒加载
- (NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = @[@"RAC基础用法",@"RAC+MVVM"];
    }
    return _titleArray;
}

@end
