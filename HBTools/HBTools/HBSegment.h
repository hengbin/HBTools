//
//  HBSegment.h
//  HBTools
//
//  Created by 花生酱 on 23/12/2018.
//  Copyright © 2018 花生酱. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol HBSegmentDelegate;
@protocol HBSegmentDataSource;

@interface HBSegment : UIView

@property (nonatomic ,weak)id<HBSegmentDelegate>delegate;

@property (nonatomic ,weak)id<HBSegmentDataSource>dataSource;

@property(nonatomic ,strong) UIColor * normalTitleColor;// default is blackColor

@property(nonatomic ,strong) UIColor * selectedTitleColor;// default is orangeColor

@property(nonatomic ,assign) CGFloat fontSize;//  default is 15px

@property(nonatomic ,assign) BOOL hasSeparate; //  default is NO

/** 分割线颜色 */
@property(nonatomic ,strong) UIColor * separateColor; // 当 hasSeparate 为 YES 时可用,默认为 灰色

@property(nonatomic ,assign) BOOL showLine; //   default is NO

@property(nonatomic ,strong) UIColor * lineColor;//  当 showLine 为 YES 时可用,默认为 橘色


-(instancetype)initWithOrigin:(CGPoint)origin;

-(void)selectedButtonItemWithContentOffsetX:(CGFloat)offSetX;

@end

@protocol HBSegmentDataSource<NSObject>

@required
/**
 需要显示多少个item
 
 @param segmentView 回调对象
 @return item个数
 */
-(NSInteger)numberOfItemInSegmentView:(HBSegment *)segmentView;

/**
 每个item上要显示什么内容
 
 @param segmentView 回调对象
 @param index 索引
 @return 要显示的字符串
 */
-(NSString *)segementView:(HBSegment *)segmentView titleForButtonItemAtIndex:(NSInteger)index;

@optional


/**
 每个item被选中时要显示的内容

 @param segmentView 回调对象
 @param index 索引
 @return 要显示的字符串
 */
-(NSString *)segementView:(HBSegment *)segmentView titleForButtonSelectedStateAtIndex:(NSInteger)index;

@end

@protocol HBSegmentDelegate<NSObject>

/**
 点击事件回调
 
 @param segmentView 回调对象
 @param index 被点击的控件索引
 */
-(void)segementView:(HBSegment *)segmentView didClickSegementButtonItem:(NSInteger)index;

@end
