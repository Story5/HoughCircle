//
//  CaptureImageView.m
//  AVFoundationDemo
//
//  Created by Story5 on 4/11/17.
//  Copyright © 2017 Story5. All rights reserved.
//

#import "CaptureImageView.h"

@interface CaptureImageView ()

@property (nonatomic,strong) NSString *tipsNotDetect;
@property (nonatomic,strong) NSString *tipsDetected;

@end

@implementation CaptureImageView
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self drawCaptureImage];
    
    [self drawIcon];
    
    [self drawTips];
    
    [self drawCircle];
}

- (void)drawIcon
{
    UIImage *image = [UIImage imageNamed:@"logo.png"];
    [image drawInRect:CGRectMake(10, 20, 30, 30)];
}

- (void)drawTips
{
    if (!self.detectingMode) return;
    
    CGFloat yOffset = 60;
    NSDictionary *attribute = @{NSForegroundColorAttributeName:[UIColor whiteColor],
                                NSBackgroundColorAttributeName:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5],
                                NSFontAttributeName:[UIFont systemFontOfSize:18]};
    if (self.coinDetectModel.detectStatus) {
        CGSize size = [self.tipsDetected sizeWithAttributes:attribute];
        CGPoint point = CGPointMake((self.bounds.size.width - size.width) / 2, yOffset);
        [self.tipsDetected drawAtPoint:point withAttributes:attribute];
    } else {
        CGSize size = [self.tipsNotDetect sizeWithAttributes:attribute];
        CGPoint point = CGPointMake((self.bounds.size.width - size.width) / 2, yOffset);
        [self.tipsNotDetect drawAtPoint:point withAttributes:attribute];
    }
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
    if (!self.detectingMode) return;
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

- (NSString *)tipsNotDetect
{
    _tipsNotDetect = @"没有检测到参照物,请调整角度和距离";
    return _tipsNotDetect;
}

- (NSString *)tipsDetected
{
    _tipsDetected = @"检测到参照物";
    return _tipsDetected;
}

@end
