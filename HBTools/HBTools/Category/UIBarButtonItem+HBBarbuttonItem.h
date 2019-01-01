//
//  UIBarButtonItem+HBBarbuttonItem.h
//  HBTools
//
//  Created by 花生酱 on 01/01/2019.
//  Copyright © 2019 花生酱. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (HBBarbuttonItem)



/**
 初始化BarButtonItem

 @param image 默认图片
 @param highImage 高亮图片
 @param target 回调目标
 @param action 回调事件
 @return barButtonItem对象
 */
+(instancetype)barButtonItemWithImage:(UIImage*)image highImage:(UIImage*)highImage addTarget:(id)target action:(SEL)action;


/**
 创建BarButtonItem

 @param image 默认图片
 @param selImage 选中时显示的图片
 @param target 回调目标
 @param action 回调事件
 @return barButtonItem对象
 */
+(instancetype)barButtonItemWithImage:(UIImage*)image selImage:(UIImage*)selImage addTarget:(id)target action:(SEL)action;


@end
