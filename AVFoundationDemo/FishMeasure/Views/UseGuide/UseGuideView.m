//
//  UseGuideScrollView.m
//  OpenCVDetectCircleDemo
//
//  Created by Story5 on 3/17/17.
//  Copyright © 2017 Story5. All rights reserved.
//

#import "UseGuideView.h"

#define UseGuideImage_Count 3

@implementation UseGuideView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configScrollView];
        [self configHeadView];
    }
    return self;
}

#pragma mark - event 
- (void)closeButtonClicked:(UIButton *)aSender
{
    NSLog(@"%s",__func__);
    [self removeFromSuperview];
}

- (void)configHeadView
{
    NSInteger fontSize = 30;
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 45, self.bounds.size.width, fontSize)];
    [self addSubview:headView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, headView.bounds.size.width, headView.bounds.size.height)];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.text = @"使用说明";
    [headView addSubview:label];
    
    UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(25, 0, headView.bounds.size.height, headView.bounds.size.height)];
    [closeButton setTitle:@"X" forState:UIControlStateNormal];
    [closeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:closeButton];
}

- (void)configScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:scrollView];
    
    for (int i = 0; i < UseGuideImage_Count; i ++) {
        
        NSString *imageName = [NSString stringWithFormat:@"UseGuide%d_%@",i+1,[self guideImageSuffix]];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * scrollView.bounds.size.width, 0, scrollView.bounds.size.width, scrollView.bounds.size.height)];
        imageView.image = [UIImage imageNamed:imageName];
        [scrollView addSubview:imageView];
    }
    
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(scrollView.bounds.size.width * 3, scrollView.bounds.size.height);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (NSString *)guideImageSuffix
{
    NSString *suffix = @"1242x2208";

    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        
        NSInteger compare = 0;
        if (screenSize.height > screenSize.width) {
            //竖屏情况
            compare = screenSize.height;
        } else if (screenSize.width > screenSize.height) {
            //横屏情况
            compare = screenSize.width;
        }
        
        switch (compare) {
            case 568:
                suffix = @"640x1136";
                break;
            case 667:
                suffix = @"750x1334";
                break;
            case 736:
                suffix = @"1242x2208";
                break;
            default:
                suffix = @"1242x2208";
                break;
        }
    }
    return suffix;
}

@end
