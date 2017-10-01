//
//  InsertSortController.m
//  小封装demon
//
//  Created by niujinfeng on 2017/6/16.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

#import "InsertSortController.h"
#import "SortTool.h"
@interface InsertSortController ()

@end

@implementation InsertSortController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"插入排序";
    self.view.backgroundColor = [UIColor whiteColor];
    
    /*
    算法思想：将等排序列划分为有序与无序两部分，然后再依次将无序部分插入到已经有序的部分，最后
    就可以形成有序序列
     */
    //C的写法
    int array[] = {3,2, 6, 9, 8, 5, 7, 1, 4};
    //为了增加可移植性(采取sizeof())计算数组元素个数count
    int length = sizeof(array) /sizeof(array[0]);
    printf(" C的数组的长度%d ",length);
    InsertSort(array, length);
    for (int i = 0; i < length ; i ++) {
        printf("C的选择排序：%d ",array[i]);
    }
    
    //OC
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:@3,@2,@6,@9,@8,@5,@7,@1,@4,nil];
    [SortTool inserSort:arr];
    
}
//C的写法
void InsertSort(int *arr, int length)
{
    //逐个记录,插入有序数列
    for (int i = 1; i < length; i++) {
        int j = i;  //j是一个坑，确定坑的位置，再把数从坑里取出来，注意顺序
        int temp = arr[i];   //temp 是从坑里取数
        //把a[i]插入有序序列
        while (j > 0 && temp < arr[j -1]) {   //j > 0 防止越界，写&&前面效率更高
            arr[j] = arr[j -1];
            j--;
        }
        arr[j] = temp;
    }
}
@end
