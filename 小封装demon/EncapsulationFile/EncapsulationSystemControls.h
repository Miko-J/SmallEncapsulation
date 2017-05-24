//
//  EncapsulationSystemControls.h
//  1111111111
//
//  Created by niujinfeng on 17/4/12.
//  Copyright © 2017年 niujinfeng. All rights reserved.
//


#pragma nark: -屏幕适配的宏定义
#define auto3Dot5Width [ScreenAdaptation shareInstance].autoBase3Dot5Width
#define auto3Dot5Height [ScreenAdaptation shareInstance].autoBase3Dot5Height

#define auto4Dot0Width [ScreenAdaptation shareInstance].autoBase4Dot0Width
#define auto4Dot0Height [ScreenAdaptation shareInstance].autoBase4Dot0Height

#define auto4Dot7Width [ScreenAdaptation shareInstance].autoBase4Dot7Width
#define auto4Dot7Height [ScreenAdaptation shareInstance].autoBase4Dot7Height

#define auto5Dot5Width [ScreenAdaptation shareInstance].autoBase5Dot5Width
#define auto5Dot5Height [ScreenAdaptation shareInstance].autoBase5Dot5Height

#define font4Dot7(x) [[ScreenAdaptation shareInstance] font4Dot7Size:x]

#define font5Dot5(x) [[ScreenAdaptation shareInstance] font5Dot5Size:x]



#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ScreenAdaptation.h"        //屏幕适配／字体适配
#import "CountdownTimer.h"          //倒计时，不是分类方法，没有加进来
@interface EncapsulationSystemControls : NSObject

@end


#pragma mark: -图片

@interface UIImageView (encapsulationImageView)


/**
 返回一个imageView

 @param imageName 传入的图片的名称
 @return imageview
 */
+ (instancetype _Nullable )imageWithName:(NSString *_Nullable)imageName;

@end



#pragma mark: -lable

@interface UILabel (encapsulationlable)


/**
 返回一个定制的lable

 @param text 内容
 @param textColor 内容的颜色
 @param font 内容的大小
 @param bgColor 背景色
 @param textAlignment 格式
 @param numberOfLines 换行
 @return 返回一个lable
 */
+ (instancetype _Nullable )lableWithtext:(NSString *_Nullable)text textColor:(UIColor *_Nullable)textColor font:(UIFont *_Nullable)font bgColor:(UIColor *_Nullable)bgColor textAlignment:(NSTextAlignment)textAlignment numberOfLines:(NSInteger)numberOfLines;

@end

#pragma mark: -按钮／改变按钮和图片的位置

typedef NS_ENUM(NSUInteger, MKButtonEdgeInsetsStyle) {
    MKButtonEdgeInsetsStyleTop, // image在上，label在下
    MKButtonEdgeInsetsStyleLeft, // image在左，label在右
    MKButtonEdgeInsetsStyleBottom, // image在下，label在上
    MKButtonEdgeInsetsStyleRight // image在右，label在左
};

typedef void(^btnClickedBlock) (); //关联block对象（按钮的点击事件）

@interface UIButton (encapsulationBtn)

+ (instancetype _Nullable )buttonWithType:(UIButtonType)buttonType createBtnWithtitle:(NSString *_Nullable)title titleColor:(UIColor *_Nullable)titleColor imageName:(NSString *_Nullable)imageName bgImageName:(NSString *_Nullable)bgImageName highImageName:(NSString *_Nullable)highImageName selBgImageName:(NSString *_Nullable)selBgImageName btnClickedBlock:(btnClickedBlock _Nullable )block;

/**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 */
- (void)layoutButtonWithEdgeInsetsStyle:(MKButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;

@end

#pragma mark: -返回一张圆形的图片／压缩图片／拉伸图片／tabbar原始图片／生成二维码／带有logo的二维码
@interface UIImage (encapsulationImage)
/**
 返回一个圆形的图片
 */
+ (instancetype _Nullable ) returnCircleImageWithOriginImage:(UIImage*_Nullable) originImage withParam:(CGFloat) inset;

/**
 压缩图片
 */
+ (instancetype _Nullable ) returnCompressionImageWithOriginImage: (UIImage *_Nullable) originImage toSize: (CGSize) size;


/**
 根据图片的名称返回一张拉伸的图片

 @param name 图片的名称
 @return 返回一张拉伸的图片
 */
+ (instancetype _Nullable ) resizableImageWithName:(NSString *_Nullable)name;

/**
 ios7之后，默认会把UITabBar上面的按钮图片渲染成蓝色

 @param imageName 原始图片的名称
 @return 返回一张原始的图片主要用于tabbar(被选中的图片原本的颜色)
 */
+ (instancetype _Nullable ) imageWithOriginalImageName:(NSString *_Nullable)imageName;

/**
 生成一张普通的二维码

 @param data 传入的二进制数据
 @param imageViewWidth 传入图片的宽度
 @return 返回一个二维码图片
 */
+ (instancetype _Nullable )generateWithDefaultQRCodeData:(NSString *_Nullable)data imageViewWidth:(CGFloat)imageViewWidth;

/**
 生成一张带有logo的二维码（logoScaleToSuperView：相对于父视图的缩放比取值范围0-1；0，不显示，1，代表与父视图大小相同）

 @param data 传入的二进制数据
 @param logoImageName 传入的logo图片名称
 @param logoScaleToSuperView 相对于父控件的缩放比例
 @return 返回一张带有logo的图片
 */
+ (instancetype _Nullable )generateWithLogoQRCodeData:(NSString *_Nullable)data logoImageName:(NSString *_Nullable)logoImageName logoScaleToSuperView:(CGFloat)logoScaleToSuperView;
@end

#pragma mark: -计算文字的尺寸／base64编码／base64解码／判断密码强度/检测手机号是否正确／检测密码是否为3中符号的两种／检测名称是否中文，英文字母和数字及_／检测密码是否数字和字母/根据索引转星期
//声明block
typedef void (^pWeakBlock)();

typedef void (^pMiddleBlock)();

typedef void (^pStrongBlock)();

typedef void (^chineseBlock)();

@interface NSString (encapsulationNsstring)

/**
 计算文字尺寸

 @param font 文字的字体大小
 @param maxSize 最大尺寸
 @return 返回计算后的文字的尺寸
 */
- (CGSize)sizeWithFont:(UIFont *_Nullable)font andMaxSize:(CGSize)maxSize;

/**
 base64编码

 @return 返回经过base64编码的字符串
 */
- (instancetype _Nullable )base64EncodeString;
/**
 base64解码
 
 @return 返回经过base64解码的字符串
 */

- (instancetype _Nullable )base64DecodeString;

/**
 检查是否为手机号的方法

 @return 返回一个bool类型的值
 */
- (BOOL)isPhoneNumber;
/**
 昵称 匹配中文，英文字母和数字及_: 2-20个字符
 
 @return 返回一个bool类型的值
 */
- (BOOL)inputChineseOrLettersNumberslimit;
/**
 检测密码是否是数字和字母
 
 @return 返回一个bool类型的值
 */
- (BOOL)isNumberAndLetter;
/**
 检测密码是否是数字／字母／特殊字符(不包含汉字)其中的两种
 
 @return 返回一个bool类型的值
 */
- (BOOL)judgePasswordIntensity:(chineseBlock _Nullable )action;

//判断密码强度的强弱
/**
 判断密码强度

 @param pWeak 密码弱的回调
 @param pMiddle 密码中的回调
 @param pStrong 密码弱的回调
 */
- (void)judgePasswordStrongOrWeak:(pWeakBlock _Nullable )pWeak pMiddle:(pMiddleBlock _Nullable )pMiddle pStrong:(pStrongBlock _Nullable )pStrong;


/**
 传入索引返回星期

 @param idx 传入的索引
 @return 返回的星期
 */
+ (instancetype _Nullable )stringToweekdayForIndex:(NSInteger)idx;

@end

#pragma mark: -字符串转nsnumber
@interface NSNumber (encapsulationData)


/**
 字符串转number

 @param string 传入的字符串
 @return 返回的number
 */
+ (instancetype _Nullable )numberWithString:(NSString *_Nullable)string;

@end


#pragma mark: - 颜色的16进制转换
@interface UIColor (encapsulationUIColor)

/**
 颜色的16进制转换

 @param stringToConvert 16进制字符串
 @return 返回一个16进制转换的颜色
 */
+ (instancetype _Nullable ) colorWithHexString: (NSString *_Nullable) stringToConvert;

@end


#pragma mark: -可变字符串转lable的attributText
@interface NSMutableAttributedString (encapsulation)

/**
 根据传入的字符串返回一个可变字符串

 @param str 传入的字符串
 @return 返回可变字符串
 */
+ (instancetype _Nullable )attributeWithStr:(NSString *_Nullable)str;


/**
 改变可变字符串中字符的状态

 @param title 传入的改变的字符
 @param font 字符大小
 @param color 字符颜色
 */
- (void)rangeWithTitle:(NSString *_Nullable)title font:(UIFont *_Nullable)font color:(UIColor *_Nullable)color;

@end

#pragma mark: -手势的点击事件／控件回到原来位置的手势动画／控件设置圆角／绘制分割线

typedef void (^tapAction)();

@interface UIView (encapsulationUIView)

/**
 控件手势点击的block回调

 @param block 点击的动作
 */
- (void)tapGestures:(tapAction _Nullable )block;



/**
 设置控件的圆角

 @param view 传入的view
 @param cornerRadius 圆角的值
 */
- (void)setCornerRadiusWithView:(UIView *_Nullable)view cornerRadius:(CGFloat)cornerRadius;

/**
 绘制一条直线

 @param lineColor 线的颜色
 */
- (void)drawLineWithColor: (UIColor *_Nullable)lineColor;
/**
 *  Make view draggable.
 *
 *  @param view    Animator reference view, usually is super view.
 *  @param damping Value from 0.0 to 1.0. 0.0 is the least oscillation. default is 0.4.
 */
- (void)makeDraggableInView:(UIView *_Nullable)view damping:(CGFloat)damping;

- (void)makeDraggable;

/**
 *  Disable view draggable.
 */
- (void)removeDraggable;

/**
 *  If you call make draggable method in the initialize method such as `-initWithFrame:`,
 *  `-viewDidLoad`, the view may not be layout correctly at that time. So you should
 *  update snap point in `-layoutSubviews` or `-viewDidLayoutSubviews`.
 *
 *  By the way, you can call make draggable method in `-layoutSubviews` or
 *  `-viewDidLayoutSubviews` directly instead of update snap point.
 */
- (void)updateSnapPoint;

@end

#pragma mark: -crc16位校验
@interface NSData (encapsulationData)

/**
 crc16位校验

 @param data  传入的二进制数据
 @return 返回一个nsData类型的数据
 */
+ (instancetype _Nullable ) getCrcVerfityCode: (NSData *_Nullable)data;

@end


#pragma mark: UIAlertController的简单使用
//声明block
typedef void (^ConfirmBtnBlock)();

typedef void (^CancelBtnBlock)();

@interface UIAlertController (encapsulationUIAlertController)

/**
 没有执行动作的alertView

 @param title 标题
 @param message 内容
 @param target 代理
 @param confirmText 点击的内容
 */
+ (void)alertWithTitle:(NSString *_Nullable)title message: (NSString *_Nullable)message target: (UIViewController *_Nullable)target confirmText:(NSString *_Nullable)confirmText;

/**
 执行确定操作的alertView

 @param title 标题
 @param message 内容
 @param target 代理
 @param confirmText 点击的内容
 @param confirmBlock 确定操作的回调
 */
+ (void)alertWithTitle:(NSString *_Nullable)title message: (NSString *_Nullable)message target: (UIViewController *_Nullable)target confirmText:(NSString *_Nullable)confirmText confirmBlock:(ConfirmBtnBlock _Nullable ) confirmBlock;

/**
 执行确定和取消操作的alertView

 @param title 标题
 @param message 内容
 @param cancelText 取消的内容
 @param confirmText 确定的内容
 @param target 代理
 @param confirmBlock 确定的回调
 @param cancelBlock 取消的回调
 */
+ (void)alertWithTitle:(NSString *_Nullable)title Message: (NSString *_Nullable)message cancelText:(NSString *_Nullable)cancelText confirmText:(NSString *_Nullable)confirmText target: (UIViewController *_Nullable)target confirmBlock:(ConfirmBtnBlock _Nullable ) confirmBlock cancelBlock: (CancelBtnBlock _Nullable ) cancelBlock;

@end

#pragma mark: -日期的计算

@interface NSDate (encapsulation)

@property (nonatomic, readonly) NSInteger year; ///< Year component
@property (nonatomic, readonly) NSInteger month; ///< Month component (1~12)
@property (nonatomic, readonly) NSInteger day; ///< Day component (1~31)
@property (nonatomic, readonly) NSInteger hour; ///< Hour component (0~23)
@property (nonatomic, readonly) NSInteger minute; ///< Minute component (0~59)
@property (nonatomic, readonly) NSInteger second; ///< Second component (0~59)

@property (nonatomic, readonly) NSInteger weekday; ///< Weekday component (1~7, first day is based on user setting)
@property (nonatomic, readonly) NSInteger weekdayOrdinal; ///< WeekdayOrdinal component
@property (nonatomic, readonly) NSInteger weekOfMonth; ///< WeekOfMonth component (1~5)
@property (nonatomic, readonly) NSInteger weekOfYear; ///< WeekOfYear component(1~53)

@property (nonatomic, readonly) BOOL isLeapMonth; ///< Weather the month is leap month
@property (nonatomic, readonly) BOOL isLeapYear; ///< Weather the year is leap year

@property (nonatomic, readonly) BOOL isToday; ///< Weather date is today (based on current locale)
@property (nonatomic, readonly) BOOL isYesterday; ///< Weather date is yesterday (based on current locale)


#pragma mark - Date modify
///=============================================================================
/// @name Date modify
///=============================================================================

/**
 Returns a date representing the receiver date shifted later by the provided number of years.
 
 @param years  Number of years to add.
 @return Date modified by the number of desired years.
 */
- (nullable NSDate *)dateByAddingYears:(NSInteger)years;

/**
 Returns a date representing the receiver date shifted later by the provided number of months.
 
 @param months  Number of months to add.
 @return Date modified by the number of desired months.
 */
- (nullable NSDate *)dateByAddingMonths:(NSInteger)months;

/**
 Returns a date representing the receiver date shifted later by the provided number of weeks.
 
 @param weeks  Number of weeks to add.
 @return Date modified by the number of desired weeks.
 */
- (nullable NSDate *)dateByAddingWeeks:(NSInteger)weeks;

/**
 Returns a date representing the receiver date shifted later by the provided number of days.
 
 @param days  Number of days to add.
 @return Date modified by the number of desired days.
 */
- (nullable NSDate *)dateByAddingDays:(NSInteger)days;

/**
 Returns a date representing the receiver date shifted later by the provided number of hours.
 
 @param hours  Number of hours to add.
 @return Date modified by the number of desired hours.
 */
- (nullable NSDate *)dateByAddingHours:(NSInteger)hours;

/**
 Returns a date representing the receiver date shifted later by the provided number of minutes.
 
 @param minutes  Number of minutes to add.
 @return Date modified by the number of desired minutes.
 */
- (nullable NSDate *)dateByAddingMinutes:(NSInteger)minutes;

/**
 Returns a date representing the receiver date shifted later by the provided number of seconds.
 
 @param seconds  Number of seconds to add.
 @return Date modified by the number of desired seconds.
 */
- (nullable NSDate *)dateByAddingSeconds:(NSInteger)seconds;

@end


