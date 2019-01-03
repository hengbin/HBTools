//
//  SegmentViewController.m
//  HBTools
//
//  Created by 花生酱 on 26/12/2018.
//  Copyright © 2018 花生酱. All rights reserved.
//

#import "SegmentViewController.h"
#import "HBTools.h"
#import <SDAutoLayout/SDAutoLayout.h>


@interface SegmentViewController ()<HBSegmentDelegate,HBSegmentDataSource,UIScrollViewDelegate>{
    
    NSString * _flagString;
    NSArray * _titleArray;
    
    CGFloat _screenWidth;
}

@property(nonatomic ,strong) HBSegment * segmentView;

@property(nonatomic ,strong) UIScrollView * scrollView;


@end

@implementation SegmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _screenWidth = [UIScreen mainScreen].bounds.size.width;
        
    _titleArray = @[@"西瓜",@"香蕉",@"西红柿",@"奶油草莓",@"菲律宾原产地芒果",@"马来西亚原产地精品榴莲",@"西瓜",@"香蕉",@"西红柿",@"奶油草莓",@"菲律宾原产地芒果",@"马来西亚原产地精品榴莲"];
    
    
    self.segmentView = [[HBSegment alloc]init];
    self.segmentView.hasSeparate = YES;
    self.segmentView.showLine = YES;
    [self.view addSubview:self.segmentView];
    self.segmentView.sd_layout
    .topSpaceToView(self.navigationController.navigationBar, 0)
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .heightIs(44);
    self.segmentView.delegate = self;
    self.segmentView.dataSource = self;
    
    [self.segmentView setSelectedItemWithIndex:3];
    
    
    [self.view addSubview:self.scrollView];
    self.scrollView.sd_layout
    .topSpaceToView(self.segmentView, 0)
    .leftEqualToView(self.segmentView)
    .rightEqualToView(self.segmentView)
    .bottomSpaceToView(self.view, 0);
    
    self.scrollView.backgroundColor = [UIColor cyanColor];
    
    [self.scrollView updateLayout];
    
    [self.scrollView setContentSize:CGSizeMake(_titleArray.count*_screenWidth,self.scrollView.height)];
    for (int i = 0; i<_titleArray.count; i++) {
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(i*_screenWidth, 0, self.scrollView.width, self.scrollView.height)];
        
        view.backgroundColor = [UIColor randomColor];
        
        [self.scrollView addSubview:view];
    }
    
    [self.scrollView setContentOffset:CGPointMake(3*self.view.width, 0) animated:NO];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self.segmentView selectedButtonItemWithContentOffsetX:scrollView.contentOffset.x];
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
         _scrollView = [[UIScrollView alloc]init];
         _scrollView.pagingEnabled = YES;
         _scrollView.delegate = self;
         _scrollView.showsVerticalScrollIndicator = NO;
         _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)segementView:(HBSegment *)segmentView didClickSegementButtonItem:(NSInteger)index animated:(BOOL)animated{
    
    [self.scrollView setContentOffset:CGPointMake(index*_screenWidth, 0) animated:animated];
}

- (NSInteger)numberOfItemInSegmentView:(HBSegment *)segmentView {
    return [_titleArray count];
}

- (NSString *)segementView:(HBSegment *)segmentView titleForButtonItemAtIndex:(NSInteger)index {
    return _titleArray[index];
}

@end
