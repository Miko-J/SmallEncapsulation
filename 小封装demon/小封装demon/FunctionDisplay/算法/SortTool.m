//
//  SortTool.m
//  小封装demon
//
//  Created by niujinfeng on 2017/6/19.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

#import "SortTool.h"

@implementation SortTool

//OC
+ (void)quickSortArray:(NSMutableArray *)array withLeftIndex:(NSInteger)leftIndex andRightIndex:(NSInteger)rightIndex
{
    if (leftIndex >= rightIndex) {//如果数组长度为0或1时返回
        return ;
    }
    
    NSInteger i = leftIndex;
    NSInteger j = rightIndex;
    //记录比较基准数
    NSInteger key = [array[i] integerValue];
    
    while (i < j) {
        /**** 首先从右边j开始查找比基准数小的值 ***/
        while (i < j && [array[j] integerValue] >= key) {//如果比基准数大，继续查找
            j--;
        }
        //如果比基准数小，则将查找到的小值调换到i的位置
        array[i] = array[j];
        
        /**** 当在右边查找到一个比基准数小的值时，就从i开始往后找比基准数大的值 ***/
        while (i < j && [array[i] integerValue] <= key) {//如果比基准数小，继续查找
            i++;
        }
        //如果比基准数大，则将查找到的大值调换到j的位置
        array[j] = array[i];
        
    }
    
    //将基准数放到正确位置
    array[i] = @(key);
    
    /**** 递归排序 ***/
    //排序基准数左边的
    [self quickSortArray:array withLeftIndex:leftIndex andRightIndex:i - 1];
    //排序基准数右边的
    [self quickSortArray:array withLeftIndex:i + 1 andRightIndex:rightIndex];
}


//OC
+ (void)bubbleSort:(NSMutableArray *)array{
    for (int i = 0; i < array.count; ++i) {
        
        //遍历数组的每一个`索引`（不包括最后一个,因为比较的是j+1）
        for (int j = 0; j < array.count-1; ++j) {
            
            //根据索引的`相邻两位`进行`比较`
            if (array[j] < array[j+1]) {
                
                [array exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
            
        }
    }
}


//OC
+ (void)selectSortWithArray:(NSMutableArray *)array{
    for (int i=0; i<array.count; i++) {
        
        for (int j=i+1; j<array.count; j++) {
            
            if (array[i]<array[j]) {
                
                [array exchangeObjectAtIndex:i withObjectAtIndex:j];
                
            }
            
        }
        
    }
}


//OC
+ (void)inserSort:(NSMutableArray *)array
{
    if(array == nil || array.count == 0){
        return;
    }
    
    for (int i = 0; i < array.count; i++) {
        NSNumber *temp = array[i];
        int j = i-1;
        
        while (j >= 0 && [array[j] compare:temp] == NSOrderedDescending) {
            [array replaceObjectAtIndex:j+1 withObject:array[j]];
            j--;
            
            printf("排序中:");
            [self printArray:array];
        }
        
        [array replaceObjectAtIndex:j+1 withObject:temp];
    }
}

+ (void)printArray:(NSArray *)array
{
    for(NSNumber *number in array) {
        printf("%d ",[number intValue]);
    }
    
    printf("\n");
}
@end
