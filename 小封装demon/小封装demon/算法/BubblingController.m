//
//  BubblingController.m
//  小封装demon
//
//  Created by niujinfeng on 2017/6/16.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

#import "BubblingController.h"
#import "SortTool.h"
@interface BubblingController ()

@end

@implementation BubblingController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"冒泡";
    self.view.backgroundColor = [UIColor whiteColor];
    
    /*
     冒泡排序：依次比较相邻的数据，将小数据放在前，大数据放在后；即第一趟先比较第1个和第2个数，大数在后，小数在前，再比较第2个数与第3个数，大数在后，小数在前，以此类推则将最大的数"滚动"到最后一个位置；第二趟则将次大的数滚动到倒数第二个位置......第n-1(n为无序数据的个数)趟即能完成排序。
     */
    
    //C语言写法
    int pDataArray[] = {5,9,3,6,8,1};
    int length = sizeof(pDataArray) / sizeof(pDataArray[0]);
    printf(" C的数组的长度%d ",length);
    BubbleSort(pDataArray, length);
    for (int i = 0; i < length ; i ++) {
        printf("C的冒泡排序：%d ",pDataArray[i]);
    }
    
    

    //OC写法
    NSMutableArray *data_Arr = [NSMutableArray arrayWithObjects:@5,@9,@3,@6,@8,@1,nil];
    [SortTool bubbleSort:data_Arr];
    NSLog(@"OC的冒泡排序：%@",data_Arr);
}
/********************************************************
 *函数名称：BubbleSort
 *参数说明：pDataArray 无序数组；
 *          iDataNum为无序数据个数
 *说明：    冒泡排序
 *********************************************************/
/********************************************************
 *函数名称：BubbleSort
 *参数说明：pDataArray 无序数组；
 *          iDataNum为无序数据个数
 *说明：    冒泡排序
 *********************************************************/
void BubbleSort(int* pDataArray, int arrLength)
{
    BOOL flag = FALSE;    //记录是否存在交换
    for (int i = 0; i < arrLength - 1; i++)    //走iDataNum-1趟
    {
        flag = FALSE;
        for (int j = 0; j < arrLength - i - 1; j++)
            if (pDataArray[j] > pDataArray[j + 1])
            {
                flag = TRUE;
                DataSwap(&pDataArray[j], &pDataArray[j + 1]);
            }
        
        if (!flag)    //上一趟比较中不存在交换，则退出排序
            break;
    }
}

//交换data1和data2所指向的整形
void DataSwap(int* data1, int* data2)
{
    int temp = *data1;
    *data1 = *data2;
    *data2 = temp;
}

@end
