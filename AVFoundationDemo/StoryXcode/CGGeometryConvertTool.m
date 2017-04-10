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
    NSLog(@"source length = %d",length);
    NSLog(@"covert length = %d",covertLength);
    return covertLength;
}

- (CGPoint)convertPoint:(CGPoint)point
{
    CGPoint covertPoint = CGPointMake(point.x * self.scale, point.y * self.scale);
    CGPoint returnPoint = CGPointMake(covertPoint.x, self.covertSize.height - covertPoint.y);
    NSLog(@"source point = %@",NSStringFromCGPoint(point));
    NSLog(@"covert point = %@",NSStringFromCGPoint(returnPoint));
    return returnPoint;
}

- (CGFloat)scale
{
    CGFloat scaleWidth = self.covertSize.width / self.sourceSize.width;
    CGFloat scaleHeight = self.covertSize.height / self.sourceSize.height;
    
    _scale = scaleWidth > scaleHeight ? scaleWidth : scaleHeight;
    return _scale;
}

@end
