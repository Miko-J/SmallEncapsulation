//
//  DisTableViewController.m
//  小封装demon
//
//  Created by niujinfeng on 2017/10/1.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

#import "DisTableViewController.h"
#import "EncapsulationTableViewCell.h"
#import "EncapsulationSystemControls.h"
@interface DisTableViewController ()

@end

@implementation DisTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EncapsulationTableViewCell *cell = [EncapsulationTableViewCell encapsulationTableViewCellWithTableView:tableView];
    cell.cellType = CellTypeAccessoryViewLable;
    CellTypeModel *typeModel = [CellTypeModel accessoryViewWithTitleColor:[UIColor redColor] font:font4Dot7(15) bgColor:[UIColor clearColor] disX:50];
    cell.typeModel = typeModel;
    return cell;
}

@end
