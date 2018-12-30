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


+(UIImage *)createImageWithImageNamed:(NSString *)imageNamed fileType:(NSString *)fileType{
    
    if (!fileType) {
        
        fileType = @"png";
    }
    
    // 方法一
    NSString *filePath = [[NSBundle mainBundle] pathForResource:imageNamed ofType:fileType];
    NSData *imageData = [NSData dataWithContentsOfFile:filePath];
    
    UIImage *image = [UIImage imageWithData:imageData];
    
    return image;
}

@end
