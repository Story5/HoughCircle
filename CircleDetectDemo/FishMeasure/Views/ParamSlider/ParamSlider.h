//
//  ParamSlider.h
//  CircleDetectDemo
//
//  Created by Story5 on 2017/4/21.
//  Copyright © 2017年 Story5. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ParamSlider;

@protocol ParamSliderDataSource <NSObject>

- (NSInteger)countOfSlidersInParamSlider:(ParamSlider *)paramSlider;
- (NSArray<NSNumber *> *)minimumValuesForParamSlider:(ParamSlider *)paramSlider;
- (NSArray<NSNumber *> *)maximumValuesForParamSlider:(ParamSlider *)paramSlider;
- (NSArray<NSNumber *> *)enterValueForParamSlider:(ParamSlider *)paramSlider;

@end

@protocol ParamSliderDelegate <NSObject>

- (void)value:(float)value indexOfSlider:(NSInteger)index;

@end

@interface ParamSlider : UIView

@property (nonatomic,weak) id<ParamSliderDataSource> dataSource;
@property (nonatomic,weak) id<ParamSliderDelegate> delegate;

@property (nonatomic) NSInteger sliderCount;
@property (nonatomic) float minimumValue;
@property (nonatomic) float maximumValue;

- (void)showSlider;

@end
