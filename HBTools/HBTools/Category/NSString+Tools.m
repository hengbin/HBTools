//
//  NSString+Tools.m
//  HBTools
//
//  Created by 花生酱 on 31/12/2018.
//  Copyright © 2018 花生酱. All rights reserved.
//

#import "NSString+Tools.h"
#import <objc/runtime.h>
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Tools)

#pragma - mark =============== 字符串处理相关 =======================


- (BOOL) isNullString{
    if(self == nil) {
        return YES;
    }
    
    if((NSNull *)self == [NSNull null]) {
        return YES;
    }
    
    if(self.length == 0) {
        return YES;
    }
    
    if([self isEqualToString:@"<null>"]) {
        return YES;
    }
    if ([self stringByReplacingOccurrencesOfString:@" " withString:@""].length == 0) {
        return YES;
    }
    return NO;
}
+ (NSString *) getDeviceIdentifierForVendor{
    return  [[UIDevice currentDevice].identifierForVendor UUIDString];
}

+ (NSString *)getAppVersions{
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return app_Version;
}

+ (NSString *)getWeekDay:(NSTimeInterval)time {
    //创建一个星期数组
    NSArray *weekday = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    //将时间戳转换成日期
    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:time];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday fromDate:newDate];
    NSString *weekStr = [weekday objectAtIndex:components.weekday];
    return weekStr;
}

+ (NSString*) format:(NSTimeInterval) time;
{
    if (time < 0)
    {
        return @"";
    }
    
    NSDateFormatter *formatter;
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:time/1000];
    return [formatter stringFromDate:date];
}

+ (NSString*) formatTime:(NSTimeInterval) time;
{
    if (time < 0)
    {
        return @"";
    }
    
    NSDateFormatter *formatter;
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:time/1000];
    return [formatter stringFromDate:date];
}

+ (NSString *) formatDateAndTime:(NSTimeInterval)time;{
    if (time < 0) {
        return @"";
    }
    NSDateFormatter *formatter;
    formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time/1000];
    return [formatter stringFromDate:date];
}

- (RangeFormatType)checkRange:(NSRange)range{
    NSInteger loc = range.location;
    NSInteger len = range.length;
    if (loc>=0 && len>0) {
        if (range.location + range.length <= self.length) {
            return RangeCorrect;
        }
        else{
            NSLog(@"The range out-of-bounds!");
            return RangeOut;
        }
    }
    else{
        NSLog(@"The range format is wrong: NSMakeRange(a,b) (a>=0,b>0). ");
        return RangeError;
    }
}

- (NSMutableAttributedString *)changeColor:(UIColor *)color
                                  andRange:(NSRange)range{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:self];
    if ([self checkRange:range] == RangeCorrect) {
        if (color) {
            [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
        }
        else{
            NSLog(@"color is nil");
        }
        
    }
    return attributedStr;
}


- (NSMutableAttributedString *)changeFont:(UIFont *)font
                                 andRange:(NSRange)range{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:self];
    if ([self checkRange:range] == RangeCorrect) {
        if (font) {
            [attributedStr addAttribute:NSFontAttributeName value:font range:range];
        }
        else{
            NSLog(@"font is nil...");
        }
    }
    return attributedStr;
}


- (NSMutableAttributedString *)changeColor:(UIColor *)color
                              andColorRang:(NSRange)colorRange
                                   andFont:(UIFont *)font
                              andFontRange:(NSRange)fontRange{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:self];
    if ([self checkRange:colorRange] == RangeCorrect) {
        if (color) {
            [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:colorRange];
        }
        else{
            NSLog(@"color is nil");
        }
    }
    if ([self checkRange:fontRange] == RangeCorrect) {
        if (font) {
            [attributedStr addAttribute:NSFontAttributeName value:font range:fontRange];
        }
        else{
            NSLog(@"font is nil...");
        }
    }
    return attributedStr;
}

- (NSMutableAttributedString *)changeColor:(UIColor *)color andRanges:(NSArray<NSValue *> *)ranges{
    __block NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:self];
    if (color) {
        [ranges enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSRange range = [(NSValue *)obj rangeValue];
            if ([self checkRange:range] == RangeCorrect) {
                [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
            }
            else{
                NSLog(@"index:%ld",idx);
            }
            
        }];
    }
    else{
        NSLog(@"color is nil...");
    }
    return attributedStr;
}

- (NSMutableAttributedString *)changeFont:(UIFont *)font andRanges:(NSArray<NSValue *> *)ranges{
    __block NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:self];
    if (font) {
        [ranges enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSRange range = [(NSValue *)obj rangeValue];
            if ([self checkRange:range] == RangeCorrect) {
                [attributedStr addAttribute:NSFontAttributeName value:font range:range];
            }
            else{
                NSLog(@"index:%ld",idx);
            }
            
        }];
    }
    else{
        NSLog(@"font is nil...");
    }
    return attributedStr;
}

- (NSMutableAttributedString *)changeColorAndFont:(NSArray<NSDictionary *> *)changes{
    __block NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:self];
    [changes enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIColor *color = obj[XCColorKey];
        UIFont *font = obj[XCFontKey];
        NSArray<NSValue *> *ranges = obj[XCRangeKey];
        if (!color) {
            NSLog(@"warning: NSColorKey -> nil! index:%ld",idx);
        }
        if (!font) {
            NSLog(@"warning: NSFontKey -> nil! index:%ld",idx);
        }
        if (ranges.count>0) {
            [ranges enumerateObjectsUsingBlock:^(NSValue * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSRange range = [obj rangeValue];
                if ([self checkRange:range] == RangeCorrect) {
                    if (color) {
                        [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
                    }
                    if (font) {
                        [attributedStr addAttribute:NSFontAttributeName value:font range:range];
                    }
                }
                else{
                    NSLog(@"index:%ld",idx);
                }
                
            }];
        }
        else{
            NSLog(@"warning: NSRangeKey -> nil! index:%ld",idx);
        }
    }];
    return attributedStr;
    
}

- (NSMutableAttributedString *)changeWithStr:(NSString *)str andColor:(UIColor *)color andFont:(UIFont *)font{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:self];
    NSUInteger length = self.length;
    while (length > str.length) {
        NSRange range = [self rangeOfString:str options:NSBackwardsSearch range:NSMakeRange(0, length)];
        if ([self checkRange:range] == RangeCorrect) {
            if (color) {
                [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
            }
            if (font) {
                [attributedStr addAttribute:NSFontAttributeName value:font range:range];
            }
            length = range.location;
        }
        else{
            length = str.length - 1;
        }
    }
    return attributedStr;
}
- (NSMutableAttributedString *)addCenterLine{
    
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc]initWithString:self attributes:attribtDic];
    return attributeStr;
}
- (NSMutableAttributedString *)addDownLine{
    
    NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc]initWithString:self attributes:attribtDic];
    return attributeStr;
}

#pragma - mark =============== 缓存处理相关 =======================
- (unsigned long long)lx_fileSize
{
    // 计算self这个文件夹\文件的大小
    
    // 文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 文件类型
    NSDictionary *attrs = [mgr attributesOfItemAtPath:self error:nil];
    NSString *fileType = attrs.fileType;
    
    if ([fileType isEqualToString:NSFileTypeDirectory]) { // 文件夹
        // 获得文件夹的遍历器
        NSDirectoryEnumerator *enumerator = [mgr enumeratorAtPath:self];
        
        // 总大小
        unsigned long long fileSize = 0;
        
        // 遍历所有子路径
        for (NSString *subpath in enumerator) {
            // 获得子路径的全路径
            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
            fileSize += [mgr attributesOfItemAtPath:fullSubpath error:nil].fileSize;
        }
        
        return fileSize;
    }
    
    // 文件
    return attrs.fileSize;
}

//- (unsigned long long)lx_fileSize
//{
//    // 计算self这个文件夹\文件的大小
//
//    // 文件管理者
//    NSFileManager *mgr = [NSFileManager defaultManager];
//
//    // 文件类型
//    BOOL isDirectory = NO;
//    BOOL exists = [mgr fileExistsAtPath:self isDirectory:&isDirectory];
//    if (!exists) return 0;
//
//    if (isDirectory) { // 文件夹
//        // 获得文件夹的遍历器
//        NSDirectoryEnumerator *enumerator = [mgr enumeratorAtPath:self];
//
//        // 总大小
//        unsigned long long fileSize = 0;
//
//        // 遍历所有子路径
//        for (NSString *subpath in enumerator) {
//            // 获得子路径的全路径
//            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
//            fileSize += [mgr attributesOfItemAtPath:fullSubpath error:nil].fileSize;
//        }
//
//        return fileSize;
//    }
//
//    // 文件
//    return [mgr attributesOfItemAtPath:self error:nil].fileSize;
//}
- (instancetype)cacheDir
{
    NSString *dir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    return [dir stringByAppendingPathComponent:[self lastPathComponent]];
}
- (instancetype)docDir
{
    NSString *dir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    return [dir stringByAppendingPathComponent:[self lastPathComponent]];
}

- (instancetype)tmpDir
{
    NSString *dir = NSTemporaryDirectory();
    return [dir stringByAppendingPathComponent:[self lastPathComponent]];
}

- (CGSize)textSizeWithContentSize:(CGSize)size font:(UIFont *)font {
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
}

- (CGFloat)textHeightWithContentWidth:(CGFloat)width font:(UIFont *)font {
    CGSize size = CGSizeMake(width, MAXFLOAT);
    return [self textSizeWithContentSize:size font:font].height;
}

- (CGFloat)textWidthWithContentHeight:(CGFloat)height font:(UIFont *)font {
    CGSize size = CGSizeMake(MAXFLOAT, height);
    return [self textSizeWithContentSize:size font:font].width;
}

#pragma - mark =============== MD5相关 =======================
+ (NSString*)md5HexDigest:(NSString*)input {
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}

@end
