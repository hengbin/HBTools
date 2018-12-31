//
//  UIControl+ClickRepeatedly.m
//  HBTools
//
//  Created by 花生酱 on 31/12/2018.
//  Copyright © 2018 花生酱. All rights reserved.
//

#import "UIControl+ClickRepeatedly.h"

#import <objc/runtime.h>

static const char *ClickIntervalKey;
static const char *IgnoreClick;
@implementation UIControl (ClickRepeatedly)

- (void)setClickInterval:(NSTimeInterval)clickInterval{
    objc_setAssociatedObject(self, &ClickIntervalKey, @(clickInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval)clickInterval{
    
    return [objc_getAssociatedObject(self, &ClickIntervalKey) doubleValue];
}

- (void)setIgnoreClick:(BOOL)ignoreClick{
    objc_setAssociatedObject(self, &IgnoreClick, @(ignoreClick), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)ignoreClick{
    return [objc_getAssociatedObject(self, &IgnoreClick) boolValue];
}

+ (void)load
{
    //替换点击事件
    Method a = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method b = class_getInstanceMethod(self, @selector(rc_sendAction:to:forEvent:));
    method_exchangeImplementations(a, b);
}

- (void)rc_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    if (self.ignoreClick) {
        return;
    }
    else{
        [self rc_sendAction:action to:target forEvent:event];
    }
    if (self.clickInterval > 0)
    {
        self.ignoreClick = YES;
        [self performSelector:@selector(setIgnoreClick:) withObject:@(NO) afterDelay:self.clickInterval];
    }
    
}

@end
