//
//  QuickSortController.m
//  小封装demon
//
//  Created by niujinfeng on 2017/6/16.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

#import "QuickSortController.h"
#import "SortTool.h"
@interface QuickSortController ()

@end

@implementation QuickSortController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"快排";
    self.view.backgroundColor = [UIColor whiteColor];
    
    /*  
     
     快速排序（Quicksort）是对冒泡排序的一种改进。
     
     快速排序由C. A. R. Hoare在1962年提出。它的基本思想是：通过一趟排序将要排序的数据分割成独立的两部分，其中一部分的所有数据都比另外一部分的所有数据都要小，然后再按此方法对这两部分数据分别进行快速排序，整个排序过程可以递归进行，以此达到整个数据变成有序序列。
     
     
     
     快速排序实现方案:
     设要排序的数组是mutableArray对象，首先任意选取一个数据（通常选用数组的第一个数）作为关键数据，然后将所有比它小的数都放到它前面，所有比它大的数都放到它后面，这个过程称为一次快速排序。
     
     步骤讲解:
     
     1 ）.设置两个变量i，j ，排序开始时i = 0，就j = mutableArray.count - 1；
     2 ）.设置数组的第一个值为比较基准数key，key = mutableArray.count[0]；
     3 ）.因为设置key为数组的第一个值，所以先从数组最右边开始往前查找比key小的值。如果没有找到，j--继续往前搜索；如果找到则将mutableArray[i]和mutableArray[j]互换，并且停止往前搜索，进入第4步；
     4 ）.从i位置开始往后搜索比可以大的值，如果没有找到，i++继续往后搜索；如果找到则将mutableArray[i]和mutableArray[j]互换，并且停止往后搜索；
     5 ）.重复第3、4步，直到i == j（此时刚好执行完第三步或第四部），停止排序；
     
     */
    
    //C
    int arr[] = {6,1,2,5,9,4,3,7};
    int length = sizeof(arr) / sizeof(arr[0]);
    printf(" C的数组的长度%d ",length);
    QuickSort(arr, 0 , length - 1);
    for (int i = 0; i < length ; i ++) {
        printf("C的快速排序：%d ",arr[i]);
    }
    
    
    //OC
    NSMutableArray *arr_OC = [[NSMutableArray alloc] initWithObjects:@(6), @(1),@(2),@(5),@(9),@(4),@(3),@(7),nil];
    
    [SortTool quickSortArray:arr_OC withLeftIndex:0 andRightIndex:arr_OC.count - 1];
    
    NSLog(@"%@",arr_OC);
}
//C
int Partition(int *arr, int left, int right)
{
    int pivot = arr[left]; // 以当前表中第一个元素为枢轴值
    
    while (left < right)
    {
        // 从右向左找一个比枢轴值小的元素的位置
        while (left < right && arr[right] >= pivot)
        {
            --right;
        }
        
        arr[left] = arr[right]; // 将比枢轴值小的元素移动到左端
        
        // 从左向右查找比枢轴值大的元素的位置
        while (left < right && arr[left] <= pivot)
        {
            ++left;
        }
        
        arr[right] = arr[left];// 将比枢轴值大的元素移动到右端
    }
    
    arr[left] = pivot; // 将枢轴元素放在最终位置
    
    return left;
}

void QuickSort(int* arr, int left, int right)
{
    if (left < right)
    {
        int pivotPos = Partition(arr, left, right); // 划分
        QuickSort(arr, left, pivotPos - 1); // 快速排序左半部分
        QuickSort(arr, pivotPos + 1, right); // 快速排序右半部分
    }  
}

@end
