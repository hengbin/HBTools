//
//  HBLabel.m
//  HBTools
//
//  Created by 花生酱 on 01/01/2019.
//  Copyright © 2019 花生酱. All rights reserved.
//

#import "HBLabel.h"
#import "UIColor+Hex.h"
@interface HBLabel()

@property(nonatomic ,strong) NSMutableParagraphStyle   * paragraphStyle;


@end

@implementation HBLabel
@synthesize textColor_HB = _textColor_HB;
@synthesize labelText_HB = _labelText_HB;
@synthesize fontSize_HB = _fontSize_HB;
@synthesize textAlignment_HB = _textAlignment_HB;
@synthesize backgroundColor_HB = _backgroundColor_HB;
@synthesize attributedString_HB = _attributedString_HB;
@synthesize frame_HB = _frame_HB;

@synthesize lineSpacing_HB = _lineSpacing_HB;
@synthesize paragraphSpacing_HB = _paragraphSpacing_HB;
@synthesize maximumLineHeight_HB = _maximumLineHeight_HB;
@synthesize minimumLineHeight_HB = _minimumLineHeight_HB;
@synthesize firstLineHeadIndent_HB = _firstLineHeadIndent_HB;

@synthesize textColorHex_HB = _textColorHex_HB;
@synthesize backgroundColorHex_HB = _backgroundColorHex_HB;

- (instancetype)init
{
    self = [super init];
    if (self) {
//        _textInsets = UIEdgeInsetsZero;
    }
    return self;
}

-(ColorForLabel)textColor_HB{
    if (!_textColor_HB) {
        
        __weak typeof(self) weakSelf = self;
        _textColor_HB = ^(UIColor * color){
            weakSelf.textColor = color;
            return weakSelf;
        };
    }
    return _textColor_HB;
}
-(labelColorHex)textColorHex_HB{
    if (!_textColorHex_HB) {
        __weak typeof(self) weakSelf = self;
        _textColorHex_HB = ^(NSString * hex){
            weakSelf.textColor = [UIColor colorWithHexString:hex];
            return weakSelf;
        };
    }
    return _textColorHex_HB;
}

-(labelColorHex)backgroundColorHex_HB{
    if (!_backgroundColorHex_HB) {
        __weak typeof(self) weakSelf = self;
        _backgroundColorHex_HB = ^(NSString * hex){
            weakSelf.backgroundColor = [UIColor colorWithHexString:hex];
            return weakSelf;
        };
    }
    return _backgroundColorHex_HB;
}

-(Text)labelText_HB{
    if (!_labelText_HB) {
        __weak typeof(self) weakSelf = self;
        _labelText_HB = ^(NSString * text){
            weakSelf.text = text;
            return weakSelf;
        };
    }
    return _labelText_HB;
}
-(SizeForLabel)fontSize_HB{
    if (!_fontSize_HB) {
        __weak typeof(self) weakSelf = self;
        _fontSize_HB = ^(CGFloat fontSize){
            weakSelf.font = [UIFont systemFontOfSize:fontSize];
            return weakSelf;
        };
    }
    return _fontSize_HB;
}

-(TextAlignment)textAlignment_HB{
    if (!_textAlignment_HB) {
        __weak typeof(self) weakSelf = self;
        _textAlignment_HB = ^(Alignment textAlign){
            switch (textAlign) {
                case left:
                    weakSelf.textAlignment = NSTextAlignmentLeft;
                    break;
                case center:
                    weakSelf.textAlignment = NSTextAlignmentCenter;
                    break;
                case right:
                    weakSelf.textAlignment = NSTextAlignmentRight;
                    break;
            }
            return weakSelf;
        };
    }
    return _textAlignment_HB;
}

-(ColorForLabel)backgroundColor_HB{
    if (!_backgroundColor_HB) {
        __weak typeof(self) weakSelf = self;
        _backgroundColor_HB = ^(UIColor * bgColor){
            weakSelf.backgroundColor = bgColor;
            return weakSelf;
        };
    }
    return _backgroundColor_HB;
}
-(AttributedString)attributedString_HB{
    if (!_attributedString_HB) {
        __weak typeof(self) weakSelf = self;
        _attributedString_HB = ^(NSAttributedString * attString){
            weakSelf.attributedText = attString;
            return weakSelf;
        };
    }
    return _attributedString_HB;
}
-(LabelFrame)frame_HB{
    if (!_frame_HB) {
        __weak typeof(self) weakSelf = self;
        _frame_HB = ^(CGFloat viewX,CGFloat viewY,CGFloat viewWidth,CGFloat viewHeight){
            weakSelf.frame = CGRectMake(viewX, viewY, viewWidth, viewHeight);
            return weakSelf;
        };
    }
    return _frame_HB;
}

-(Paragraph)lineSpacing_HB{
    if (!_lineSpacing_HB) {
        __weak typeof(self) weakSelf = self;
        _lineSpacing_HB = ^(CGFloat value){
            [weakSelf.paragraphStyle setLineSpacing:value];
            return weakSelf;
        };
    }
    return _lineSpacing_HB;
}
-(Paragraph)paragraphSpacing_HB{
    if (!_paragraphSpacing_HB) {
        __weak typeof(self) weakSelf = self;
        _paragraphSpacing_HB = ^(CGFloat value){
            [weakSelf.paragraphStyle setParagraphSpacing:value];
            return weakSelf;
        };
    }
    return _paragraphSpacing_HB;
}
-(Paragraph)firstLineHeadIndent_HB{
    if (!_firstLineHeadIndent_HB) {
        __weak typeof(self) weakSelf = self;
        _firstLineHeadIndent_HB = ^(CGFloat value){
            [weakSelf.paragraphStyle setFirstLineHeadIndent:value];
            return weakSelf;
        };
    }
    return _firstLineHeadIndent_HB;
}

-(Paragraph)minimumLineHeight_HB{
    if (!_minimumLineHeight_HB) {
        __weak typeof(self) weakSelf = self;
        _minimumLineHeight_HB = ^(CGFloat value){
            [weakSelf.paragraphStyle setMinimumLineHeight:value];
            return weakSelf;
        };
    }
    return _minimumLineHeight_HB;
}
-(Paragraph)maximumLineHeight_HB{
    if (!_maximumLineHeight_HB) {
        __weak typeof(self) weakSelf = self;
        _maximumLineHeight_HB = ^(CGFloat value){
            [weakSelf.paragraphStyle setMaximumLineHeight:value];
            return weakSelf;
        };
    }
    return _maximumLineHeight_HB;
}

-(void)setText:(NSString *)text{
    
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:self.paragraphStyle range:NSMakeRange(0, [text length])];
    
    [self setAttributedText:attributedString];
    
    [self setLineBreakMode:NSLineBreakByTruncatingTail];
    
    CGRect dlRect = self.frame;
    [self sizeToFit];
    CGRect dlRectNew = self.frame;
    
    if(dlRectNew.size.height>dlRect.size.height){
        dlRectNew.size.height = dlRect.size.height;
        [self setFrame:dlRectNew];
    }
}

-(NSMutableParagraphStyle *)paragraphStyle{
    
    if (!_paragraphStyle) {
        _paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        //行间距
        [_paragraphStyle setLineSpacing:0.0];
        //段落间距
        [_paragraphStyle setParagraphSpacing:0.0];
        //第一行头缩进
        [_paragraphStyle setFirstLineHeadIndent:0.0];
        //最小行高
        [_paragraphStyle setMinimumLineHeight:0.0];
        //最大行高
        [_paragraphStyle setMaximumLineHeight:0.0];
        //连字属性 在iOS，唯一支持的值分别为0和1
        _paragraphStyle.hyphenationFactor = 1;
    }
    return _paragraphStyle;
}

//- (void)drawTextInRect:(CGRect)rect {
//    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, _textInsets)];
//}


@end
