//
//  UIBarButtonItem+HBBarbuttonItem.m
//  HBTools
//
//  Created by 花生酱 on 01/01/2019.
//  Copyright © 2019 花生酱. All rights reserved.
//

#import "UIBarButtonItem+HBBarbuttonItem.h"

@implementation UIBarButtonItem (HBBarbuttonItem)

+(instancetype)barButtonItemWithImage:(UIImage*)image highImage:(UIImage*)highImage addTarget:(id)target action:(SEL)action{
    
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView* subView = [[UIView alloc] initWithFrame:btn.frame];
    [subView addSubview:btn];
    return [[UIBarButtonItem alloc] initWithCustomView:subView];
}



+(instancetype)barButtonItemWithImage:(UIImage*)image selImage:(UIImage*)selImage addTarget:(id)target action:(SEL)action{
    
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:selImage forState:UIControlStateSelected];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView* subView = [[UIView alloc] initWithFrame:btn.frame];
    [subView addSubview:btn];
    return [[UIBarButtonItem alloc] initWithCustomView:subView];
}

@end
