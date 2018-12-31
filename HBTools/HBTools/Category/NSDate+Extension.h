//
//  NSDate+Extension.h
//  HBTools
//
//  Created by 花生酱 on 31/12/2018.
//  Copyright © 2018 花生酱. All rights reserved.
//

/*!
 *
 ┌────────────────────────────────────────────────────────────────
 │
 │    部分方法及实现转载于 leeSmile
 │    GitHub https://github.com/leeSmile/tools
 │    简书：  https://www.jianshu.com/p/3e476777c00b
 │
 └────────────────────────────────────────────────────────────────
 *
 */


#import <Foundation/Foundation.h>

@interface DateItem : NSObject
@property (nonatomic, assign) NSInteger day;
@property (nonatomic, assign) NSInteger hour;
@property (nonatomic, assign) NSInteger minute;
@property (nonatomic, assign) NSInteger second;
@end


@interface NSDate (Extension)

- (DateItem *)lx_timeIntervalSinceDate:(NSDate *)anotherDate;

- (BOOL)lx_isToday;
- (BOOL)lx_isYesterday;
- (BOOL)lx_isTomorrow;
- (BOOL)lx_isThisYear;
//获取今天周几
- (NSInteger)getNowWeekday;

@end
