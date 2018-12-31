//
//  NSObject+Unicode.h
//  HBTools
//
//  Created by 花生酱 on 31/12/2018.
//  Copyright © 2018 花生酱. All rights reserved.
//

/*!
 *
 ┌────────────────────────────────────────────────────────────────
 │
 │    方法及实现转载于 volientDuan
 │    GitHub https://github.com/VolientDuan/iOS-ToolClassDemo
 │    简书：  https://www.jianshu.com/p/eb20c2cc7c36
 │
 └────────────────────────────────────────────────────────────────
 *
 */


#import <Foundation/Foundation.h>

@interface NSObject (Unicode)

/**
 *  解决输出中文乱码问题
 *
 *  @return 字符串
 */
- (NSString *)my_description;


@end
