//
//  NSString+Tools.h
//  HBTools
//
//  Created by 花生酱 on 31/12/2018.
//  Copyright © 2018 花生酱. All rights reserved.
//

/*!
 *
 ┌────────────────────────────────────────────────────────────────
 │
 │    方法及实现转载于他人
 │      字符串处理相关 转载于 volientDuan
 │          GitHub https://github.com/VolientDuan/iOS-ToolClassDemo
 │          简书：  https://www.jianshu.com/p/eb20c2cc7c36
 │
 │      缓存处理及MD5相关 转载于  leeSmile
 │          GitHub https://github.com/leeSmile/tools
 │          简书：  https://www.jianshu.com/p/3e476777c00b
 │
 └────────────────────────────────────────────────────────────────
 *
 */

#import <UIKit/UIKit.h>

#pragma - mark =============== 字符串处理相关 =======================

static NSString  *const XCColorKey = @"color";
static NSString  *const XCFontKey = @"font";
static NSString  *const XCRangeKey = @"range";
/**
 range的校验结果
 */
typedef enum
{
    RangeCorrect = 0,
    RangeError = 1,
    RangeOut = 2,
    
}RangeFormatType;

@interface NSString (Tools)

/**
 *  空判断
 *
 *  @return 是否为空
 */
- (BOOL) isNullString;

#pragma mark - 常用工具
/**
 *  获取当前设备deviceId
 *
 *  @return deviceId
 */
+ (NSString *) getDeviceIdentifierForVendor;
/**
 *  获取当前版本号
 *
 *  @return 版本号
 */
+ (NSString *) getAppVersions;

/**
 *  转换为周X
 *
 *  @param time 时间戳
 *
 *  @return 周几
 */
+ (NSString *) getWeekDay:(NSTimeInterval) time;
/**
 *  转换为XXXX年XX月XX日
 *
 *  @param time 时间戳
 *
 *  @return 年月日
 */
+ (NSString*) format:(NSTimeInterval) time;

/**
 *  转化为XX时XX分XX秒
 *
 *  @param time 时间戳
 *
 *  @return 时:分:秒
 */
+ (NSString*) formatTime:(NSTimeInterval) time;

/**
 *  转化为XXXX年XX月XX日XX时XX分XX秒
 *
 *  @param time 时间戳
 *
 *  @return 年月日 时:分:秒
 */
+ (NSString *) formatDateAndTime:(NSTimeInterval)time;

#pragma mark - 校验NSRange
/**
 *  校验范围（NSRange）
 *
 *  @param range Range
 *
 *  @return 校验结果：RangeFormatType
 */
- (RangeFormatType)checkRange:(NSRange)range;

#pragma mark - 改变单个范围字体的大小和颜色
/**
 *  改变字体的颜色
 *
 *  @param color 颜色（UIColor）
 *  @param range 范围（NSRange）
 *
 *  @return 转换后的富文本（NSMutableAttributedString）
 */
- (NSMutableAttributedString *)changeColor:(UIColor *)color
                                  andRange:(NSRange)range;


/**
 *  改变字体大小
 *
 *  @param font  字体大小(UIFont)
 *  @param range 范围(NSRange)
 *
 *  @return 转换后的富文本（NSMutableAttributedString）
 */
- (NSMutableAttributedString *)changeFont:(UIFont *)font
                                 andRange:(NSRange)range;


/**
 *   改变字体的颜色和大小
 *
 *  @param color      字符串的颜色
 *  @param colorRange 需要改变颜色的字符串范围
 *  @param font       字体大小
 *  @param fontRange  需要改变字体大小的字符串范围
 *
 *  @return 转换后的富文本（NSMutableAttributedString）
 */

- (NSMutableAttributedString *)changeColor:(UIColor *)color
                              andColorRang:(NSRange)colorRange
                                   andFont:(UIFont *)font
                              andFontRange:(NSRange)fontRange;

#pragma mark - 改变多个范围内的字体和颜色

/**
 *  改变多段字符串为一种颜色
 *
 *  @param color  字符串的颜色
 *  @param ranges 范围数组:[NSValue valueWithRange:NSRange]
 *
 *  @return 转换后的富文本（NSMutableAttributedString）
 */
- (NSMutableAttributedString *)changeColor:(UIColor *)color andRanges:(NSArray<NSValue *> *)ranges;

/**
 *  改变多段字符串为同一大小
 *
 *  @param font   字体大小
 *  @param ranges 范围数组:[NSValue valueWithRange:NSRange]
 *
 *  @return 转换后的富文本（NSMutableAttributedString）
 */
- (NSMutableAttributedString *)changeFont:(UIFont *)font andRanges:(NSArray<NSValue *> *)ranges;
/**
 *  用于多个位置颜色和大小改变
 *
 *  @param changes 对应属性改变的数组.示例:@[@{XCColorKey:UIColor,XCFontKey:UIFont,XCRangeKey:NSArray<NSValue *>}];
 *
 *  @return 转换后的富文本（NSMutableAttributedString）
 */
- (NSMutableAttributedString *)changeColorAndFont:(NSArray<NSDictionary *> *)changes;


#pragma mark - 对特定字符进行改变
/**
 *  对相应的字符串进行改变
 *
 *  @param str   需要改变的字符串
 *  @param color 字体颜色
 *  @param font  字体大小
 *
 *  @return 转换后的富文本（NSMutableAttributedString）
 */
- (NSMutableAttributedString *)changeWithStr:(NSString *)str andColor:(UIColor *)color andFont:(UIFont *)font;

#pragma mark - 给字符串添加中划线
/**
 *  添加中划线
 *
 *  @return 富文本
 */
- (NSMutableAttributedString *)addCenterLine;

#pragma mark - 给字符串添加下划线
/**
 *  添加下划线
 *
 *  @return 富文本
 */
- (NSMutableAttributedString *)addDownLine;

#pragma - mark =============== 缓存处理相关 =======================

/**
 *  根据文件名计算出文件大小
 */
- (unsigned long long)fileSize;
/**
 *  生成缓存目录全路径
 */
- (instancetype)cacheDir;
/**
 *  生成文档目录全路径
 */
- (instancetype)docDir;
/**
 *  生成临时目录全路径
 */
- (instancetype)tmpDir;

/**
 *  @brief 根据字数的不同,返回UILabel中的text文字需要占用多少Size
 *  @param size 约束的尺寸
 *  @param font 文本字体
 *  @return 文本的实际尺寸
 */
- (CGSize)textSizeWithContentSize:(CGSize)size font:(UIFont *)font;

/**
 *  @brief  根据文本字数/文本宽度约束/文本字体 求得text的Size
 *  @param width 宽度约束
 *  @param font  文本字体
 *  @return 文本的实际高度
 */
- (CGFloat)textHeightWithContentWidth:(CGFloat)width font:(UIFont *)font;

/**
 *  @brief  根据文本字数/文本宽度约束/文本字体 求得text的Size
 *  @param height 宽度约束
 *  @param font  文本字体
 *  @return 文本的实际长度
 */
- (CGFloat)textWidthWithContentHeight:(CGFloat)height font:(UIFont *)font;

#pragma - mark =============== MD5加密相关 =======================

/**
 *  md5加密
 */
+ (NSString*)md5HexDigest:(NSString*)input;


@end
