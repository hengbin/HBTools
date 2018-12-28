//
//  UIColor+ColorToImage.h
//  HBTools
//
//  Created by 花生酱 on 28/12/2018.
//  Copyright © 2018 花生酱. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ColorToImage)


/**
 UIColor对象转UIImage对象

 @param color UIColor对象
 @return 转换的UIImage对象
 */
+(UIImage*)createImageWithColor: (UIColor*) color;

@end
