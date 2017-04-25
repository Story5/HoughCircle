//
//  CGGeometryConvertTool.m
//  AVFoundationDemo
//
//  Created by Story5 on 4/10/17.
//  Copyright © 2017 Story5. All rights reserved.
//

#import "CGGeometryConvertTool.h"
#import <Foundation/NSString.h>

@interface CGGeometryConvertTool ()

@property (nonatomic,assign) CGFloat scale;

@end

@implementation CGGeometryConvertTool

- (CGFloat)covertLength:(CGFloat)length
{
    return length * self.scale;
}

- (int)covertIntLength:(int)length
{
    int covertLength = length * self.scale;
    return covertLength;
}

- (CGPoint)convertPoint:(CGPoint)point
{
    CGPoint covertPoint = CGPointMake(point.x * [self widthScale], point.y * [self heightScale]);
    return covertPoint;
}

- (CGFloat)widthScale
{
    CGFloat scaleWidth = self.covertSize.width / self.sourceSize.width;
    return scaleWidth;
}

- (CGFloat)heightScale
{
    CGFloat scaleHeight = self.covertSize.height / self.sourceSize.height;
    return scaleHeight;
}

- (CGFloat)scale
{
    CGFloat scaleWidth = self.covertSize.width / self.sourceSize.width;
    CGFloat scaleHeight = self.covertSize.height / self.sourceSize.height;
    
    _scale = scaleWidth > scaleHeight ? scaleWidth : scaleHeight;
    return _scale;
}

@end
