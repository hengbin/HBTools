//
//  UIControl+ClickRepeatedly.h
//  HBTools
//
//  Created by 花生酱 on 31/12/2018.
//  Copyright © 2018 花生酱. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (ClickRepeatedly)

/**
 *  设置点击的间隔（防止反复点击）
 */
@property (nonatomic, assign)NSTimeInterval clickInterval;

@property (nonatomic, assign)BOOL ignoreClick;

@end
