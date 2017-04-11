//
//  CaptureImageView.m
//  AVFoundationDemo
//
//  Created by Story5 on 4/11/17.
//  Copyright © 2017 Story5. All rights reserved.
//

#import "CaptureImageView.h"

@implementation CaptureImageView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self drawCaptureImage];
    
    [self drawIcon];

    [self drawCircle];
}

- (void)drawIcon
{
    UIImage *image = [UIImage imageNamed:@"logo.png"];
    [image drawInRect:CGRectMake(10, 20, 40, 40)];
}

- (void)drawCaptureImage
{
    if (self.coinDetectModel.captureImage) {
        UIImage *image = self.coinDetectModel.captureImage;
        [image drawInRect:self.bounds];
    }
}

- (void)drawCircle
{
    CGPoint center = self.coinDetectModel.circleCenter;
    int radius = self.coinDetectModel.circleRadius;
    [self drawCircle:center radius:radius];
}

- (void)drawCircle:(CGPoint)center radius:(CGFloat)radius
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetRGBStrokeColor(context, 0, 1, 0, 1);
    CGContextSetLineWidth(context, 5);
    //    CGContextMoveToPoint(context, self.circleCenter.x, self.circleCenter.y);
    CGContextAddArc(context, center.x, center.y, radius, 0, M_PI * 2, 1);
    
    CGContextStrokePath(context);
}

- (CoinDetectModel *)coinDetectModel
{
    if (_coinDetectModel == nil) {
        _coinDetectModel = [[CoinDetectModel alloc] init];
    }
    return _coinDetectModel;
}

@end
