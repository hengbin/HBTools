//
//  UIColor+ColorToImage.m
//  HBTools
//
//  Created by 花生酱 on 28/12/2018.
//  Copyright © 2018 花生酱. All rights reserved.
//

#import "UIImage+Tools.h"

@implementation UIImage (Tools)

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

-(UIImage *)scaleImageToSize:(CGSize)size{
    UIGraphicsBeginImageContext(CGSizeMake(size.width, size.height));
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
}

- (UIImage *)imageReSize:(CGSize)reSize{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [self drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
}

-(UIImage *)cutImageWithRect:(CGRect)cutRect{
    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, cutRect);
    UIGraphicsBeginImageContext(cutRect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, cutRect, subImageRef);
    UIImage* cutedImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    if (subImageRef) {
        CFRelease(subImageRef);
    }
    return cutedImage;
}

+ (UIImage *)smallTheImage:(UIImage *)image{
    NSData *data = UIImageJPEGRepresentation(image, 1.);
    if (data.length > 1024*1024*2) {
        NSData *smallData = UIImageJPEGRepresentation(image, (1024*1024*2)/data.length*2);
        if (smallData.length > 1024*1024*2) {
            return [self smallTheImage:[UIImage imageWithData:smallData]];
        } else {
            return [UIImage imageWithData:smallData];
        }
    } else {
        return image;
    }
}

+ (NSData *)smallTheImageBackData:(UIImage *)image{
    NSData *data = UIImageJPEGRepresentation(image, 1.);
    if (data.length > 1024*1024*1) {
        NSData *smallData = UIImageJPEGRepresentation(image, (1024*1024*1)/data.length*2);
        if (smallData.length > 1024*1024*1) {
            return [self smallTheImageBackData:[UIImage imageWithData:smallData]];
        } else {
            return smallData;
        }
    } else {
        return data;
    }
}

+ (UIImage *)imageFromView:(UIView*)view{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, [UIScreen mainScreen].scale);
    } else {
        UIGraphicsBeginImageContext(view.bounds.size);
    }
    CGContextRef currnetContext = UIGraphicsGetCurrentContext();
    //    CGContextSetInterpolationQuality(currnetContext, kCGInterpolationHigh);
    [view.layer renderInContext:currnetContext];
    // 从当前context中创建一个改变大小后的图片
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    return image;
}

- (NSString *)saveImageToSandox:(NSString *)filePath{
    
    NSString *imagePath = [NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/Documents%@",filePath]];
    [UIImagePNGRepresentation(self) writeToFile:imagePath atomically:YES];
    return imagePath;
}
- (NSString *)saveImageToDocument:(NSString *)filePath{
    NSString *url;
    return url;
}

@end
