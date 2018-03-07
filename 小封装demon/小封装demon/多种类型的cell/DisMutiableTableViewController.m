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
@property (nonatomic, strong) NSArray *dataArr;
@end

@implementation DisMutiableTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册cell
    [self.tableView registerClass:[EncapsulationMutableTableViewCell class] forCellReuseIdentifier:CellMulTypeModelID];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EncapsulationMutableTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellMulTypeModelID];
    cell.model = self.dataArr[indexPath.row];
    return cell;
}

#pragma mark: -lazy loading
- (NSArray *)dataArr{
    if (!_dataArr) {
        NSArray *titleData = @[@"多频测脂",@"心率开关",@"二维码",@"配置WiFi",@"当前电量",@"MAC地址",@"固件版本"];
        NSMutableArray *dataM = [NSMutableArray array];
        for (int i = 0; i < titleData.count; i++) {
            CellMulTypeModel *model = [[CellMulTypeModel alloc] init];
            model.title = titleData[i];
            if (i == 0 || i == 1) {
                model.type = CellTypeAccessoryViewSwitch;
            }else if (i == 2 || i == 3) {
                model.type = CellTypeAccessoryViewArrow;
            }else{
                model.type = CellTypeAccessoryViewLable;
            }
            [dataM addObject:model];
        }
        _dataArr = dataM.mutableCopy;
    }
    return _dataArr;
}
@end
