//
//  SelectionSortController.m
//  小封装demon
//
//  Created by niujinfeng on 2017/6/16.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

#import "SelectionSortController.h"

@interface SelectionSortController ()

@end

@implementation SelectionSortController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"选择排序";
    self.view.backgroundColor = [UIColor whiteColor];
    
    /*假设排序表为L[1...n],第i趟排序从表中选择关键字最小的元素与Li交换，第一趟排序可以确定一个元素的
    最终位置，这样经过n-1趟排序就可以使得整个排序表有序。
     */
    //C语言写法
    int dataArray[] = {6,10,3,5,15,3,1,9};
    int length = sizeof(dataArray) / sizeof(dataArray[0]);
    printf(" C的数组的长度%d ",length);
    selectSort(dataArray, length);
    for (int i = 0; i < length ; i ++) {
        printf("C的选择排序：%d ",dataArray[i]);
    }
    
    //OC
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:@6,@10,@3,@5,@15,@3,@1,@9,nil];
    [self selectSortWithArray:arr];
    NSLog(@"OC的选择排序%@",arr);
}

//C
void selectSort(int* arr, int length)
{
    int i, j, min;
    int tmp;
    
    for (i = 0; i < length - 1; ++i) // 需要n-1趟
    {
        min = i;
        
        for (j = i + 1; j < length; ++j)
        {
            if (arr[j] < arr[min]) // 每一趟选择元素值最小的下标
            {
                min = j;
            }
        }
        
        if (min != i) // 如果第i趟的Li元素值该趟找到的最小元素值，则交换，以使Li值最小
        {
            tmp = arr[i];
            arr[i] = arr[min];
            arr[min] = tmp;
        }
    }  
}

//OC
- (void)selectSortWithArray:(NSMutableArray *)array{
    for (int i=0; i<array.count; i++) {
        
        for (int j=i+1; j<array.count; j++) {
            
            if (array[i]<array[j]) {
                
                [array exchangeObjectAtIndex:i withObjectAtIndex:j];
                
            }
            
        }
        
    }
}

@end
