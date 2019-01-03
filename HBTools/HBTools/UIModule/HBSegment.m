//
//  HBSegment.m
//  HBTools
//
//  Created by 花生酱 on 23/12/2018.
//  Copyright © 2018 花生酱. All rights reserved.
//

#import "HBSegment.h"
#import <SDAutoLayout/SDAutoLayout.h>

struct DelegateFlag {
    BOOL didClickSegementButtonItemFlag;
    BOOL titleForButtonSelectedStateAtIndexFlag;
};

@interface HBSegment(){
    
    UIButton * _flagButton;
    CGFloat _viewWidth;
    BOOL _isFirstLoad;
}

@property(nonatomic ,assign) struct DelegateFlag delegateFlag;

@property (nonatomic, assign) NSInteger currentIndex;


@property (nonatomic ,strong)UIButton * flagButton;

@property(nonatomic ,strong) UIScrollView * scrollView;

@property(nonatomic ,strong) NSMutableArray * itemArray;

@property(nonatomic ,strong) NSMutableArray * separateArray;

@property(nonatomic ,strong) CALayer * lineLayer;

@end

@implementation HBSegment

@synthesize normalTitleColor = _normalTitleColor;
@synthesize selectedTitleColor = _selectedTitleColor;
@synthesize fontSize = _fontSize;
@synthesize lineColor = _lineColor;
@synthesize separateColor = _separateColor;
@synthesize zoomFactor = _zoomFactor;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.hasSeparate = NO;
        self.showLine = NO;
        self.isZoom = NO;
        self.currentIndex = 0;
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
        self.isZoom = NO;
        self.currentIndex = 0;
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
        self.isZoom = NO;
        self.currentIndex = 0;
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    
    _viewWidth = rect.size.width;
}

-(void)installView{
    
    NSInteger itemCount = [self.dataSource numberOfItemInSegmentView:self];
    
    self.itemArray = [NSMutableArray arrayWithCapacity:itemCount];
    self.separateArray = [NSMutableArray array];
    
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
        
        if (index+1<itemCount) {
            UILabel * label = [UILabel new];
            label.backgroundColor = self.separateColor;
            [label setHidden:!self.hasSeparate];
            [self.scrollView addSubview:label];
            label.sd_layout
            .leftSpaceToView(button, 5)
            .centerYEqualToView(button)
            .widthIs(1)
            .heightRatioToView(button, 0.5);
            
            [self.separateArray addObject:label];
            
            tempView = label;
        }else{
            tempView = button;
        }
    }
    
    
    
    [self.scrollView setupAutoContentSizeWithRightView:tempView rightMargin:10];

    [self.scrollView updateLayout];
    
    UIButton * firstButton = self.itemArray[self.currentIndex];
    [firstButton setSelected:YES];
    firstButton.titleLabel.font = [UIFont systemFontOfSize:self.fontSize+4];
    _flagButton = firstButton;
    
    
#pragma - mark =============== 初始化layer =======================
    
    self.lineLayer = [[CALayer alloc]init];
    
    self.lineLayer.backgroundColor = self.lineColor.CGColor;
    
    self.lineLayer.bounds = CGRectMake(0,0,firstButton.width,1);
    
    CGFloat scrollViewBottom = self.scrollView.frame.size.height-2;
    
    self.lineLayer.position = CGPointMake(firstButton.centerX, scrollViewBottom);
    
    [self.scrollView.layer addSublayer:self.lineLayer];
}

-(void)setSelectedItemWithIndex:(NSInteger)selectedIndex{
    
    if (self.dataSource) {
        
        [_flagButton setSelected:NO];
        _flagButton.titleLabel.font = [UIFont systemFontOfSize:self.fontSize];
        UIButton * firstButton = self.itemArray[selectedIndex];
        [firstButton setSelected:YES];
        firstButton.titleLabel.font = [UIFont systemFontOfSize:self.fontSize+4];
        _flagButton = firstButton;
        self.currentIndex = selectedIndex;
        
        [firstButton updateLayout];
        
        self.lineLayer.bounds = CGRectMake(0,0,firstButton.width,1);
        
        CGFloat scrollViewBottom = self.scrollView.frame.size.height-2;
        
        self.lineLayer.position = CGPointMake(firstButton.centerX, scrollViewBottom);
        
    }else{
        self.currentIndex = selectedIndex;
    }
}


-(void)didPressButtonItem:(UIButton *)button{
    
    if ([_flagButton isEqual:button]) {
        return;
    }
    
    NSInteger buttonIndex = button.tag-1000;
    
    BOOL animated = YES;
    
    if ( labs(buttonIndex - self.currentIndex) > 2) {
        animated = NO;
    }
    self.currentIndex = buttonIndex;
    
    [self scrollViewDidScrollWithItem:button];

    if (_delegateFlag.didClickSegementButtonItemFlag) {
        [self.delegate segementView:self didClickSegementButtonItem:self.currentIndex animated:animated];
    }
}

-(void)scrollViewDidScrollWithItem:(UIButton *)item{
    
    [_flagButton setSelected:NO];
    _flagButton.titleLabel.font = [UIFont systemFontOfSize:self.fontSize];
    [item setSelected:YES];
    item.titleLabel.font = [UIFont systemFontOfSize:self.fontSize+4];
    _flagButton = item;
    
    [self.scrollView updateLayout];
    
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
    if (absIndex >= 1) {
        
        NSInteger buttonIndex = (NSInteger)index;
        
        UIButton * button = self.itemArray[buttonIndex];
        
        [self scrollViewDidScrollWithItem:button];
        
        self.currentIndex = buttonIndex;
    }
}

#pragma - mark =============== 懒加载 =======================
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

#pragma - mark =============== SET GET 方法 =======================

-(CGFloat)zoomFactor{
    if (!_zoomFactor) {
        _zoomFactor = 3.0;
    }
    return _zoomFactor;
}

-(void)setZoomFactor:(CGFloat)zoomFactor{
    _zoomFactor = zoomFactor;
    _flagButton.titleLabel.font = [UIFont systemFontOfSize:self.fontSize+zoomFactor];
}

-(void)setDelegate:(id<HBSegmentDelegate>)delegate{
    
    _delegate = delegate;
    _delegateFlag.didClickSegementButtonItemFlag = [self.delegate respondsToSelector:@selector(segementView:didClickSegementButtonItem:animated:)];
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

-(void)setHasSeparate:(BOOL)hasSeparate{
    _hasSeparate = hasSeparate;
    for (UILabel * label in self.separateArray) {
        [label setHidden:!hasSeparate];
    }
}

-(UIColor *)separateColor{
    if (!_separateColor) {
        _separateColor = [UIColor lightGrayColor];
    }
    return _separateColor;
}
-(void)setSeparateColor:(UIColor *)separateColor{
    _separateColor = separateColor;
    for (UILabel * label in self.separateArray) {
        [label setBackgroundColor:separateColor];
    }
}

-(CGFloat)fontSize{
    if (!_fontSize) {
        CGFloat fontSize = 14;
        if ([UIScreen mainScreen].bounds.size.width < 375) {
            fontSize = 13;
        }
        _fontSize = fontSize;
    }
    return _fontSize;
}
-(void)setFontSize:(CGFloat)fontSize{
    _fontSize = fontSize;
    for (UIButton * button in self.itemArray) {
        button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    }
}

-(UIColor *)normalTitleColor{
    if (!_normalTitleColor) {
        _normalTitleColor = [UIColor blackColor];
    }
    return _normalTitleColor;
}
-(void)setNormalTitleColor:(UIColor *)normalTitleColor{
    _normalTitleColor = normalTitleColor;
    
    for (UIButton * button in self.itemArray) {
        [button setTitleColor:normalTitleColor forState:UIControlStateNormal];
    }
}

-(UIColor *)selectedTitleColor{
    if (!_selectedTitleColor) {
        _selectedTitleColor = [UIColor orangeColor];
    }
    return _selectedTitleColor;
}

-(void)setSelectedTitleColor:(UIColor *)selectedTitleColor{
    
    _selectedTitleColor = selectedTitleColor;
    
    for (UIButton * button in self.itemArray) {
        [button setTitleColor:selectedTitleColor forState:UIControlStateSelected];
    }
}

@end
