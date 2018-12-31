//
//  UINavigationBar+BackGroundColor.m
//  HBTools
//
//  Created by 花生酱 on 31/12/2018.
//  Copyright © 2018 花生酱. All rights reserved.
//

#import "UINavigationBar+BackGroundColor.h"
#import <objc/runtime.h>

static char bgColor;

@implementation UINavigationBar (BackGroundColor)

- (void)setBgColor:(UIColor *)bgColor{
    [self willChangeValueForKey:@"bgColor"];
    objc_setAssociatedObject(self, &bgColor, bgColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"bgColor"];
    // 核心方法 - 通过KVC对backgroundView赋值
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, -20, self.bounds.size.width, 64)];
    view.backgroundColor = bgColor;
    [self setValue:view forKey:@"backgroundView"];
}

- (UIColor *)bgColor{
    return objc_getAssociatedObject(self, &bgColor);
}

@end
