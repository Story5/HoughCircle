//
//  CameraControlView.h
//  AVFoundationDemo
//
//  Created by Story5 on 4/11/17.
//  Copyright © 2017 Story5. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CameraControlView;

@protocol CameraControlViewDelegate <NSObject>

- (void)cameraControlView:(CameraControlView *)cameraControleView clickTakePictureButton:(UIButton *)aSender;
- (void)cameraControlView:(CameraControlView *)cameraControleView clickGuideButton:(UIButton *)aSender;
- (void)cameraControlView:(CameraControlView *)cameraControleView clickFlashLightButton:(UIButton *)aSender;

@end

@interface CameraControlView : UIView

@property (nonatomic,assign) id<CameraControlViewDelegate>delegate;

@end
