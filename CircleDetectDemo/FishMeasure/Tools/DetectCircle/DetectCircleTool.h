//
//  DetectCircleTool.h
//  AVFoundationDemo
//
//  Created by Story5 on 4/7/17.
//  Copyright © 2017 Story5. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DetectCircleTool : NSObject

@property (nonatomic,assign) double size;
@property (nonatomic,assign) double dp;
@property (nonatomic,assign) double minDist;
@property (nonatomic,assign) double param1;
@property (nonatomic,assign) double param2;
@property (nonatomic,assign) int minRadius;
@property (nonatomic,assign) int maxRadius;


@property (nonatomic,readonly) CGPoint center;
@property (nonatomic,readonly) int radius;
@property (nonatomic,strong,readonly) UIImage *covertImage;

- (BOOL)detectCircleInImage:(UIImage *)image;

@end
