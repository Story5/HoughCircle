//
//  ParamSlider.m
//  CircleDetectDemo
//
//  Created by Story5 on 2017/4/21.
//  Copyright © 2017年 Story5. All rights reserved.
//

#import "ParamSlider.h"

#define BASETAG     100
#define LabelTag    200

@interface ParamSlider ()

@property (nonatomic,strong) NSArray<NSNumber *> *minimumValues;
@property (nonatomic,strong) NSArray<NSNumber *> *maximumValues;
@property (nonatomic,strong) NSArray<NSNumber *> *enterValues;

@end

@implementation ParamSlider

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
    }
    return self;
}

#pragma mark - event
- (void)valueChange:(UISlider *)aSender
{
    // dp
    // minDist;
    // param1;
    // param2;
    // minRadius;
    // maxRadius;
    
    NSLog(@"value = %f",aSender.value);
    
    UILabel *label = [self viewWithTag:aSender.tag + LabelTag - BASETAG];
    label.text = [NSString stringWithFormat:@"%.0f",aSender.value];
    
    if ([self.delegate respondsToSelector:@selector(value:indexOfSlider:)]) {
        [self.delegate value:aSender.value indexOfSlider:aSender.tag - BASETAG];
    }
}

#pragma mark - private
- (void)showSlider
{
    [self configData];
    
    CGFloat gap = 10;
    CGSize sliderSize = CGSizeMake(self.bounds.size.width, 20);
    
    for (int i = 0; i < self.sliderCount; i++) {
        
        CGRect sliderFrame = CGRectMake(0, (sliderSize.height + gap) * i * 2, sliderSize.width, sliderSize.height);
        UISlider *slider = [[UISlider alloc] initWithFrame:sliderFrame];
        slider.tag = BASETAG + i;
        if (self.minimumValues) {
            float minValue = [self.minimumValues[i] floatValue];
            slider.minimumValue = minValue;
        } else {
            slider.minimumValue = self.minimumValue;
        }
        
        if (self.maximumValues) {
            float maxValue = [self.maximumValues[i] floatValue];
            slider.maximumValue = maxValue;
        } else {
            slider.maximumValue = self.maximumValue;
        }
        
        if (self.enterValues) {
            float value = [self.enterValues[i] floatValue];
            slider.value = value;
        }
        [slider addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:slider];
        
        CGRect labelFrame = CGRectMake(0, CGRectGetMaxY(sliderFrame) + gap, sliderSize.width / 8, sliderSize.height);
        UILabel *label = [[UILabel alloc] initWithFrame:labelFrame];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = [UIColor redColor];
        label.font = [UIFont systemFontOfSize:20];
        label.text = [NSString stringWithFormat:@"%.0f",slider.value];
        label.tag = LabelTag + i;
        [self addSubview:label];
    }
}

- (void)configData
{
    // sliderCount
    if ([self.dataSource respondsToSelector:@selector(countOfSlidersInParamSlider:)]) {
        self.sliderCount = [self.dataSource countOfSlidersInParamSlider:self];
    }
    
    // minimumValues
    if ([self.dataSource respondsToSelector:@selector(minimumValuesForParamSlider:)]) {
        self.minimumValues = [self.dataSource minimumValuesForParamSlider:self];
    } else {
        NSNumber *number = [[NSNumber alloc] initWithFloat:self.minimumValue];
        NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:self.sliderCount];
        for (int i = 0; i < self.sliderCount; i++) {
            [array addObject:number];
        }
        self.minimumValues = [[NSArray alloc] initWithArray:array copyItems:YES];
    }
    
    // maximumValues
    if ([self.dataSource respondsToSelector:@selector(maximumValuesForParamSlider:)]) {
        self.maximumValues = [self.dataSource maximumValuesForParamSlider:self];
    } else {
        NSNumber *number = [[NSNumber alloc] initWithFloat:self.maximumValue];
        NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:self.sliderCount];
        for (int i = 0; i < self.sliderCount; i++) {
            [array addObject:number];
        }
        self.maximumValues = [[NSArray alloc] initWithArray:array copyItems:YES];
    }
    
    if ([self.dataSource respondsToSelector:@selector(enterValueForParamSlider:)]) {
        self.enterValues = [self.dataSource enterValueForParamSlider:self];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
