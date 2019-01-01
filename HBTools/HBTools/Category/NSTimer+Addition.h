//
//  NSTimer+Addition.h
//  HBTools
//
//  Created by 花生酱 on 01/01/2019.
//  Copyright © 2019 花生酱. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Addition)


/** 暂停定时器 */
- (void)pauseTimer;

/** 重启定时器 */
- (void)resumeTimer;

/**
 一段时间后重新启动

 @param interval 时间间隔
 */
- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval;

@end
