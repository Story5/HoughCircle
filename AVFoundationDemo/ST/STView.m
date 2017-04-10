//
//  STView.m
//  AVFoundationDemo
//
//  Created by 舒通 on 2017/4/10.
//  Copyright © 2017年 Story5. All rights reserved.
//

#import "STView.h"

@implementation STView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.center = self.centerPoint;
        self.centerPoint = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        self.radius = 40;        
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.centerPoint = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        self.radius = 40;
    }
    return self;
}

- (void)updateframe:(CGRect)frame
{
    self.frame = frame;
    self.layer.borderColor = [UIColor redColor].CGColor;
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = self.frame.size.width / 2;
    self.layer.masksToBounds = YES;
}
//- (void)drawRect:(CGRect)rect
//{
//    [super drawRect:rect];
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextAddEllipseInRect(context, CGRectMake(self.centerPoint.x, self.centerPoint.y, self.radius, self.radius));
//    [[UIColor whiteColor]setStroke];
//    CGContextDrawPath(context, kCGPathStroke);
////    [self drawPieChartBackGroundWithRedius:self.radius withCenter:self.centerPoint withWidth:2 withColor:[UIColor redColor] andContextRef:context];
//}
//- (void)drawPieChartBackGroundWithRedius:(CGFloat)redius withCenter:(CGPoint)point withWidth:(CGFloat)width withColor:(UIColor *)color andContextRef:(CGContextRef)context
//{
//    //起点
//    CGFloat startAngle = 0;
//    //终点
//    CGFloat  endAngle = M_PI * 2;
//    
//    CGContextSetLineWidth(context, width);//线宽
//    [color setStroke]; // 颜色
//    
//    //路径
//    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:point radius:redius startAngle:startAngle endAngle:endAngle clockwise:NO];
//    //添加路径
//    CGContextAddPath(context, path.CGPath);
//    //绘制内容
//    CGContextDrawPath(context, kCGPathStroke);
//}
//
//- (void)setCenterPoint:(CGPoint)centerPoint
//{
//    _centerPoint = centerPoint;
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    [self drawPieChartBackGroundWithRedius:self.radius withCenter:self.centerPoint withWidth:2 withColor:[UIColor redColor] andContextRef:context];
//    
////    [self setNeedsDisplay];
//}
//- (void)setRadius:(CGFloat)radius
//{
//    _radius = radius;
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    [self drawPieChartBackGroundWithRedius:self.radius withCenter:self.centerPoint withWidth:2 withColor:[UIColor redColor] andContextRef:context];
//    
//    [self setNeedsDisplayInRect:CGRectMake(self.centerPoint.x, self.centerPoint.y, radius, radius)];
//
//}

@end
