//
//  UIColor+ColorToImage.h
//  HBTools
//
//  Created by 花生酱 on 28/12/2018.
//  Copyright © 2018 花生酱. All rights reserved.
//

/*!
 *
    ┌────────────────────────────────────────────────────────────────┐
    │
    │    部分方法及实现转载于他人
    │       图片尺寸相关  转载于 volientDuan
    │    GitHub https://github.com/VolientDuan/iOS-ToolClassDemo
    │    简书：  https://www.jianshu.com/p/eb20c2cc7c36
    │
    │       图片效果相关  转载于  leeSmile
    │          GitHub https://github.com/leeSmile/tools
    │          简书：  https://www.jianshu.com/p/3e476777c00b
    │
    └────────────────────────────────────────────────────────────────┘
 *
 */

#import <UIKit/UIKit.h>
#import <Accelerate/Accelerate.h>

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
 取消UIImage的渲染模式

 @param imageName 图片名字
 @return 图片对象
 */
+ (UIImage *)imageRenderingModeImageNamed:(NSString *)imageName;

#pragma - mark =============== 尺寸、裁剪相关 =======================

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

#pragma - mark =============== 图片效果相关 =======================
- (instancetype)lx_circleImage;
// 生成一个圆形图片
+ (instancetype)lx_circleImageNamed:(NSString *)name;

// 给定一个不要渲染的图片名称,生成一个最原始的图片
+ (UIImage *)imageWithOriginalImageName:(NSString *)imageName;

// 模糊效果(渲染很耗时间,建议在子线程中渲染)
- (UIImage *)blurImage;
- (UIImage *)blurImageWithMask:(UIImage *)maskImage;
- (UIImage *)blurImageWithRadius:(CGFloat)radius;
- (UIImage *)blurImageAtFrame:(CGRect)frame;

// 灰度效果
- (UIImage *)grayScale;

// 固定宽度与固定高度
- (UIImage *)scaleWithFixedWidth:(CGFloat)width;
- (UIImage *)scaleWithFixedHeight:(CGFloat)height;

// 平均的颜色
- (UIColor *)averageColor;

// 裁剪图片的一部分
- (UIImage *)croppedImageAtFrame:(CGRect)frame;

// 将自身填充到指定的size
- (UIImage *)fillClipSize:(CGSize)size;


@end
