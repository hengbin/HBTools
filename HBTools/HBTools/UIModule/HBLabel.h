//
//  HBLabel.h
//  HBTools
//
//  Created by 花生酱 on 01/01/2019.
//  Copyright © 2019 花生酱. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,Alignment) {
    left,
    center,
    right,
};

@class HBLabel;

typedef HBLabel *(^ColorForLabel)(UIColor * color);

typedef HBLabel *(^SizeForLabel)(CGFloat size);

typedef HBLabel *(^TextAlignment)(Alignment textAlign);

typedef HBLabel *(^labelColorHex)(NSString * hexString);

typedef HBLabel *(^Text)(NSString * text);

typedef HBLabel *(^AttributedString)(NSAttributedString * attributedString);

typedef HBLabel *(^LabelFrame)(CGFloat viewX,CGFloat viewY,CGFloat viewWidth,CGFloat viewHeight);

typedef HBLabel *(^Paragraph)(CGFloat value);

@interface HBLabel : UILabel

/** 文字颜色 */
@property(nonatomic ,copy,readonly) ColorForLabel textColor_HB;

/** 文字颜色（16进制） */
@property(nonatomic ,copy,readonly) labelColorHex textColorHex_HB;

/** 背景颜色 */
@property(nonatomic ,copy,readonly) ColorForLabel backgroundColor_HB;

/** 背景颜色（16进制） */
@property(nonatomic ,copy,readonly) labelColorHex backgroundColorHex_HB;

/** 字体大小（系统字体） */
@property(nonatomic ,copy,readonly) SizeForLabel fontSize_HB;

/** 文字对齐方式 */
@property(nonatomic ,copy,readonly) TextAlignment textAlignment_HB;

/** 要显示的文字 */
@property(nonatomic ,copy,readonly) Text labelText_HB;

/** 富文本文字 */
@property(nonatomic ,copy,readonly) AttributedString attributedString_HB;

/** 自身的frame */
@property(nonatomic ,copy,readonly) LabelFrame frame_HB;

#pragma - mark =============== 段落样式 =======================
/** 行间距 */
@property(nonatomic ,copy,readonly) Paragraph lineSpacing_HB;

/** 段落间距 */
@property(nonatomic ,copy,readonly) Paragraph paragraphSpacing_HB;

/** 第一行头缩进 */
@property(nonatomic ,copy,readonly) Paragraph firstLineHeadIndent_HB;

/** 最小行高 */
@property(nonatomic ,copy,readonly) Paragraph minimumLineHeight_HB;

/** 最大行高 */
@property(nonatomic ,copy,readonly) Paragraph maximumLineHeight_HB;


//@property (nonatomic, assign) UIEdgeInsets textInsets; // 控制字体与控件边界的间隙



@end
