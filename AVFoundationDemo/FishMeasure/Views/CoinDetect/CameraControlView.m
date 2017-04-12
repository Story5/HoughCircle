//
//  CameraControlView.m
//  AVFoundationDemo
//
//  Created by Story5 on 4/11/17.
//  Copyright © 2017 Story5. All rights reserved.
//

#import "CameraControlView.h"

@interface CameraControlView ()

@property (nonatomic,strong) UIButton *pictureButton;
@property (nonatomic,strong) UIButton *guideButton;
@property (nonatomic,strong) UIButton *flashLightButton;

@end

@implementation CameraControlView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - public methods
- (void)enableTakePicture:(BOOL)enabled
{
    self.pictureButton.enabled = enabled;
}

#pragma mark - button click
- (void)clickTakePictureButton:(UIButton *)aSender
{
    NSLog(@"%s",__func__);
    if ([self.delegate respondsToSelector:@selector(cameraControlView:clickTakePictureButton:)]) {
        [self.delegate cameraControlView:self clickTakePictureButton:aSender];
    }
}

- (void)clickGuideButton:(UIButton *)aSender
{
    NSLog(@"%s",__func__);
    if ([self.delegate respondsToSelector:@selector(cameraControlView:clickGuideButton:)]) {
        [self.delegate cameraControlView:self clickGuideButton:aSender];
    }
}

- (void)clickFlashButton:(UIButton *)aSender
{
    NSLog(@"%s",__func__);
    aSender.selected = !aSender.selected;
    if ([self.delegate respondsToSelector:@selector(cameraControlView:clickFlashLightButton:)]) {
        [self.delegate cameraControlView:self clickFlashLightButton:aSender];
    }
    
}

#pragma mark - init UI
- (void)createUI {
    
    // 图片
    UIImage *takePictureImage = [UIImage imageNamed:@"TakePicture.png"];
    UIImage *guideImage = [UIImage imageNamed:@"Guide.png"];
    UIImage *flashLightOffImage = [UIImage imageNamed:@"FlashLight_Off.png"];
    UIImage *flashLightOnImage = [UIImage imageNamed:@"FlashLight_On.png"];
    
    
    // 拍照按钮
    NSInteger height = self.bounds.size.height;
    self.pictureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.pictureButton.frame = CGRectMake((self.bounds.size.width - height) / 2, 0, height, height);
    [self.pictureButton setImage:takePictureImage forState:UIControlStateNormal];
    self.pictureButton.enabled = false;
    [self.pictureButton addTarget:self action:@selector(clickTakePictureButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.pictureButton];
    
    
    // 图片大小和间距
    NSInteger gap = 10;
    NSInteger width = height * guideImage.size.width / takePictureImage.size.height;
    // 说明按钮
    self.guideButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.guideButton.frame = CGRectMake(CGRectGetMinX(self.pictureButton.frame) - gap - width, CGRectGetMidY(self.pictureButton.frame) - width / 2, width, width);
    [self.guideButton setImage:guideImage forState:UIControlStateNormal];
    [self.guideButton addTarget:self action:@selector(clickGuideButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.guideButton];
    
    // 闪光灯按钮
    self.flashLightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.flashLightButton.frame = CGRectMake(CGRectGetMaxX(self.pictureButton.frame) + gap, CGRectGetMidY(self.pictureButton.frame) - width / 2, width, width);
    [self.flashLightButton setImage:flashLightOffImage forState:UIControlStateNormal];
    [self.flashLightButton setImage:flashLightOnImage forState:UIControlStateSelected];
    [self.flashLightButton addTarget:self action:@selector(clickFlashButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.flashLightButton];
}

@end
