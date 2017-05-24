//
//  TableListController.m
//  小封装demon
//
//  Created by niujinfeng on 2017/5/15.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

#import "TableListController.h"
#import "CommonlyUsedViewController.h"
#import "ScreenSdaptationViewController.h"   //屏幕适配
#import "CountdownViewController.h"          //倒计时
#import "RACTableController.h"
@interface TableListController ()
@property (nonatomic, strong) NSArray *titleArray;
@end

@implementation TableListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"小封装";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    static NSString *ID = @"tableList_Cell";
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
        default:
            break;
    }
}
#pragma mark：-懒加载
- (NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = @[@"常用控件",@"屏幕适配",@"倒计时",@"RAC的常用方法"];
    }
    return _titleArray;
}
@end
