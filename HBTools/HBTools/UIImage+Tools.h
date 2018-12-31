//
//  UIColor+ColorToImage.h
//  HBTools
//
//  Created by 花生酱 on 28/12/2018.
//  Copyright © 2018 花生酱. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Tools)


/**
 UIColor对象转UIImage对象

 @param color UIColor对象
 @return 转换的UIImage对象
 */
+(UIImage*)createImageWithColor: (UIColor*) color;


/**
 读取本地图片资源

 @param imageNamed 图片名字
 @param fileType 图片类型（png可填nil）
 @return 图片对象
 */
+(UIImage *)createImageWithImageNamed:(NSString *)imageNamed fileType:(NSString *)fileType;


/**
 *  等比缩放
 *
 *  @param size 设置尺寸
 *
 *  @return image
 */
-(UIImage *)scaleImageToSize:(CGSize)size;
/**
 *  自定长宽
 *
 *  @param reSize 设置尺寸
 *
 *  @return image
 */
-(UIImage *)imageReSize:(CGSize)reSize;
/**
 *  剪切
 *
 *  @param cutRect 选取截取部分
 *
 *  @return image
 */
-(UIImage *)cutImageWithRect:(CGRect)cutRect;
/**
 *  压缩
 *
 *  @param image 待压缩的图片
 *
 *  @return image
 */
+ (UIImage *)smallTheImage:(UIImage *)image;
/**
 *  压缩（上传）
 *
 *  @param image 待压缩图片
 *
 *  @return 图片的二进制文件
 */
+ (NSData *)smallTheImageBackData:(UIImage *)image;
/**
 *  view转位图（一般用于截图）
 *
 *  @param view 需要转化的view
 *
 *  @return image
 */
+ (UIImage *)imageFromView:(UIView*)view;

- (NSString *)saveImageToDocument:(NSString *)filePath;

@end
