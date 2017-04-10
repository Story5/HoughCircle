//
//  DrawCircleView.m
//  AVFoundationDemo
//
//  Created by Story5 on 4/10/17.
//  Copyright © 2017 Story5. All rights reserved.
//

#import "DrawCircleView.h"

@implementation DrawCircleView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self drawIcon];
    
    [self drawCircle:self.circleCenter radius:self.circleRadius];
}

- (void)drawIcon
{
    UIImage *image = [UIImage imageNamed:@"icon.png"];
    [image drawInRect:CGRectMake(10, 20, 40, 40)];
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

@end
