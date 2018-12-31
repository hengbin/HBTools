//
//  UIControl+ClickRepeatedly.h
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


#import <UIKit/UIKit.h>

@interface UIControl (ClickRepeatedly)

/**
 *  设置点击的间隔（防止反复点击）
 */
@property (nonatomic, assign)NSTimeInterval clickInterval;

@property (nonatomic, assign)BOOL ignoreClick;

@end
