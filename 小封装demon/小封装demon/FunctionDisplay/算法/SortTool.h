//
//  SortTool.h
//  小封装demon
//
//  Created by niujinfeng on 2017/6/19.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SortTool : NSObject

/**
 快排

 @param array 传入的排序的数组
 @param leftIndex 数组的起始索引
 @param rightIndex 数组的最大索引
 */
+ (void)quickSortArray:(NSMutableArray *)array withLeftIndex:(NSInteger)leftIndex andRightIndex:(NSInteger)rightIndex;


//OC
/**
 冒泡排序

 @param array 传入的排序的数组
 */
+ (void)bubbleSort:(NSMutableArray *)array;



/**
 选择排序

 @param array 传入的排序的数组
 */
+ (void)selectSortWithArray:(NSMutableArray *)array;



/**
 插入排序

 @param array 传入的排序的数组
 */
+ (void)inserSort:(NSMutableArray *)array;



/**
 打印函数

 @param array 传入的排序的数组
 */
+ (void)printArray:(NSArray *)array;
@end
