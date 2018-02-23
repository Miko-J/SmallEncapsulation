//
//  DisMutiableTableViewController.m
//  小封装demon
//
//  Created by niujinfeng on 2018/1/20.
//  Copyright © 2018年 niujinfeng. All rights reserved.
//

#import "DisMutiableTableViewController.h"
#import "EncapsulationMutableTableViewCell.h"//;
@interface DisMutiableTableViewController ()

@end

@implementation DisMutiableTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册cell
    [self.tableView registerClass:[EncapsulationMutableTableViewCell class] forCellReuseIdentifier:[CellMutableModle getIdentifierWithCellType:CellTypeAccessoryViewLable]];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EncapsulationMutableTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[CellMutableModle getIdentifierWithCellType:CellTypeAccessoryViewLable]];
    cell.textLabel.text = @"哈哈哈";
    return cell;
}


@end
