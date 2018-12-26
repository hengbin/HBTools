//
//  HBSegment.m
//  HBTools
//
//  Created by 花生酱 on 23/12/2018.
//  Copyright © 2018 花生酱. All rights reserved.
//

#import "HBSegment.h"
#import <SDAutoLayout.h>

struct DelegateFlag {
    BOOL didClickSegementButtonItemFlag;
    BOOL titleForButtonSelectedStateAtIndexFlag;
};

@interface HBSegment(){
    
    UIButton * _flagButton;
    CGFloat _viewWidth;
}

@property(nonatomic ,assign) struct DelegateFlag delegateFlag;

@property (nonatomic, assign) NSInteger currentIndex;


@property (nonatomic ,strong)UIButton * flagButton;

@property(nonatomic ,strong) UIScrollView * scrollView;

@property(nonatomic ,strong) NSMutableArray * itemArray;

@property(nonatomic ,strong) CALayer * lineLayer;


@end

@implementation HBSegment

@synthesize normalTitleColor = _normalTitleColor;
@synthesize selectedTitleColor = _selectedTitleColor;
@synthesize fontSize = _fontSize;
@synthesize lineColor = _lineColor;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.hasSeparate = NO;
        self.showLine = NO;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    _viewWidth = frame.size.width;
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.hasSeparate = NO;
        self.showLine = NO;
    }
    return self;
}

-(instancetype)initWithOrigin:(CGPoint)origin{
    
    _viewWidth = [UIScreen mainScreen].bounds.size.width;
    
    self = [super initWithFrame:CGRectMake(origin.x, origin.y, _viewWidth, 44)];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.hasSeparate = NO;
        self.showLine = NO;
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    
    _viewWidth = rect.size.width;
}

-(void)installView{
    
    NSInteger itemCount = [self.dataSource numberOfItemInSegmentView:self];
    
    self.itemArray = [NSMutableArray arrayWithCapacity:itemCount];
    
    UIView * tempView = self.scrollView;
    
    for (int index = 0; index<itemCount; index++) {
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        NSString * titleString = [self.dataSource segementView:self titleForButtonItemAtIndex:index];
        
        [button setTitle:titleString forState:UIControlStateNormal];
        if (_delegateFlag.titleForButtonSelectedStateAtIndexFlag) {
            NSString * selectedTitle = [self.dataSource segementView:self titleForButtonSelectedStateAtIndex:index];
            [button setTitle:selectedTitle forState:UIControlStateSelected];
        }
        [button setTitleColor:self.normalTitleColor forState:UIControlStateNormal];
        [button setTitleColor:self.selectedTitleColor forState:UIControlStateSelected];
        
        button.titleLabel.font = [UIFont systemFontOfSize:self.fontSize];
        
        button.tag = index+1000;
        
        [button addTarget:self action:@selector(didPressButtonItem:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.scrollView addSubview:button];
        
        button.sd_layout
        .topSpaceToView(self.scrollView, 5)
        .leftSpaceToView(tempView, 10)
        .bottomSpaceToView(self.scrollView, 5);
        
        [button setupAutoSizeWithHorizontalPadding:5 buttonHeight:34];
        [self.itemArray addObject:button];
        
        if (self.hasSeparate && index+1<itemCount) {
            UILabel * label = [UILabel new];
            label.backgroundColor = self.separateColor;
            [self.scrollView addSubview:label];
            label.sd_layout
            .leftSpaceToView(button, 5)
            .centerYEqualToView(button)
            .widthIs(1)
            .heightRatioToView(button, 0.5);
            
            tempView = label;
        }else{
            tempView = button;
        }
    }
    
    UIButton * firstButton = self.itemArray.firstObject;
    [firstButton setSelected:YES];
    _flagButton = firstButton;
    self.currentIndex = 0;
    
    [self.scrollView setupAutoContentSizeWithRightView:tempView rightMargin:10];

    [self.scrollView updateLayout];
#pragma - mark =============== 初始化layer =======================
    
    self.lineLayer = [[CALayer alloc]init];
    
    self.lineLayer.backgroundColor = self.lineColor.CGColor;

    self.lineLayer.bounds = CGRectMake(0,0,firstButton.width,1);

    CGFloat scrollViewBottom = self.scrollView.frame.size.height-2;
    
    self.lineLayer.position = CGPointMake(firstButton.centerX, scrollViewBottom);
    
    [self.scrollView.layer addSublayer:self.lineLayer];
}

-(void)didPressButtonItem:(UIButton *)button{
    
    if ([_flagButton isEqual:button]) {
        return;
    }
    self.currentIndex = button.tag-1000;
    [self scrollViewDidScrollWithItem:button];
    
    if (_delegateFlag.didClickSegementButtonItemFlag) {
        [self.delegate segementView:self didClickSegementButtonItem:button.tag-1000];
    }
}

-(void)scrollViewDidScrollWithItem:(UIButton *)item{
    
    [_flagButton setSelected:NO];
    [item setSelected:YES];
    _flagButton = item;
    
    CGFloat twoThirdScreenWidth = _viewWidth/3*2;
    
    CGFloat buttonCenterX = item.centerX;
    
    CGFloat contentWidth = self.scrollView.contentSize.width;
    
    if (buttonCenterX > twoThirdScreenWidth) {
        
        CGFloat toPointX = item.frame.origin.x+item.width+10;
        
        if (toPointX >= contentWidth) {
            CGFloat offsetX = contentWidth-_viewWidth;
            [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
        }else{
            CGFloat offsetX = buttonCenterX-_viewWidth/2;
            [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
        }
    }else{
        
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.lineLayer.bounds = CGRectMake(0,0,item.width,1);
        
        CGFloat scrollViewBottom = self.scrollView.frame.size.height-2;
        
        self.lineLayer.position = CGPointMake(item.centerX, scrollViewBottom);
        
    }];
}

-(void)selectedButtonItemWithContentOffsetX:(CGFloat)offSetX{
    
    CGFloat index = offSetX/_viewWidth;
    CGFloat absIndex = fabs(index - self.currentIndex);
    if (absIndex == 1) {
        
        NSInteger buttonIndex = (NSInteger)index;
        
        UIButton * button = self.itemArray[buttonIndex];
        
        [self scrollViewDidScrollWithItem:button];
        
        self.currentIndex = buttonIndex;
    }
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.pagingEnabled = NO;
        _scrollView.bounces = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
        [self addSubview:_scrollView];
        _scrollView.sd_layout
        .topSpaceToView(self, 0)
        .leftSpaceToView(self, 0)
        .rightSpaceToView(self, 0)
        .bottomSpaceToView(self, 0);
    }
    return _scrollView;
}

-(void)setDelegate:(id<HBSegmentDelegate>)delegate{
    
    _delegate = delegate;
    _delegateFlag.didClickSegementButtonItemFlag = [self.delegate respondsToSelector:@selector(segementView:didClickSegementButtonItem:)];
}

-(void)setDataSource:(id<HBSegmentDataSource>)dataSource{
    
    _dataSource = dataSource;
    
    _delegateFlag.titleForButtonSelectedStateAtIndexFlag = [self.dataSource respondsToSelector:@selector(segementView:titleForButtonSelectedStateAtIndex:)];
    
    [self installView];
}

-(UIColor *)lineColor{
    if (!_lineColor) {
        if (self.showLine) {
            _lineColor = [UIColor redColor];
        }else{
            _lineColor = [UIColor clearColor];
        }
    }
    return _lineColor;
}

-(void)setLineColor:(UIColor *)lineColor{
    
    _lineColor = lineColor;

#pragma - mark ===============设置layer显示颜色=======================
    if (self.showLine) {
        self.lineLayer.backgroundColor = lineColor.CGColor;
    }
}

-(void)setShowLine:(BOOL)showLine{
    
    _showLine = showLine;

#pragma - mark ===============设置layer是否显示=======================
    if (!showLine) {
        self.lineLayer.backgroundColor = [UIColor clearColor].CGColor;
    }else{
        self.lineLayer.backgroundColor = self.lineColor.CGColor;
    }
}

-(UIColor *)separateColor{
    if (!_separateColor) {
        _separateColor = [UIColor lightGrayColor];
    }
    return _separateColor;
}

-(CGFloat)fontSize{
    if (!_fontSize) {
        CGFloat fontSize = 14;
        if (_viewWidth < 375) {
            fontSize = 13;
        }
        _fontSize = fontSize;
    }
    return _fontSize;
}
-(UIColor *)normalTitleColor{
    if (!_normalTitleColor) {
        _normalTitleColor = [UIColor blackColor];
    }
    return _normalTitleColor;
}
-(UIColor *)selectedTitleColor{
    if (!_selectedTitleColor) {
        _selectedTitleColor = [UIColor orangeColor];
    }
    return _selectedTitleColor;
}

//UIColor 转UIImage
- (UIImage*) createImageWithColor: (UIColor*) color{
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
