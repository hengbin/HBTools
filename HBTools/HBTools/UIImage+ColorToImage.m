//
//  UIColor+ColorToImage.m
//  HBTools
//
//  Created by 花生酱 on 28/12/2018.
//  Copyright © 2018 花生酱. All rights reserved.
//

#import "UIImage+ColorToImage.h"

@implementation UIImage (ColorToImage)

//UIColor 转UIImage
+(UIImage*) createImageWithColor: (UIColor*) color{
    CGRect rect=CGRectMake(0,0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
