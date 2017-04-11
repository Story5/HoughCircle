//
//  CGGeometryConvertTool.h
//  AVFoundationDemo
//
//  Created by Story5 on 4/10/17.
//  Copyright © 2017 Story5. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGGeometry.h>
#import <UIKit/UIGeometry.h>

@interface CGGeometryConvertTool : NSObject

// 被转换的基础size
@property (nonatomic,assign) CGSize sourceSize;
// 要转换的基础size
@property (nonatomic,assign) CGSize covertSize;

- (CGPoint)convertPoint:(CGPoint)point;
- (CGFloat)covertLength:(CGFloat)length;
- (int)covertIntLength:(int)length;

@end
