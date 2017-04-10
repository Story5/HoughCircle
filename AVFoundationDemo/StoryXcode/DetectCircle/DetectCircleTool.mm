//
//  DetectCircleTool.m
//  AVFoundationDemo
//
//  Created by Story5 on 4/7/17.
//  Copyright © 2017 Story5. All rights reserved.
//

#import "DetectCircleTool.h"

#import <opencv2/opencv.hpp>
#import <opencv2/imgcodecs/ios.h>
#import <opencv2/imgproc/imgproc.hpp>

@implementation DetectCircleTool

- (BOOL)detectCircleInImage:(UIImage *)image
{
    // 将 UIImage 转成 MAT
    cv::Mat src;
    UIImageToMat(image, src);
    
    // 将图像作灰度处理
    cv::Mat src_gray;
    cv::cvtColor( src, src_gray, CV_BGR2GRAY );
    
    // 高斯滤镜
    cv::GaussianBlur( src_gray, src_gray, cv::Size(9, 9), 2, 2 );
    
    // 霍夫变换检测圆形
    std::vector<cv::Vec3f> circles;
    cv::HoughCircles( src_gray, circles, CV_HOUGH_GRADIENT, 1, src_gray.rows/8, 200, 100, 0, 0 );
    
    if (circles.size() <= 0) {
        _center = CGPointZero;
        _radius = 0;
        _covertImage = nil;
        return false;
    }
    
    for( size_t i = 0; i < circles.size(); i++ )
    {
        // 圆心
        cv::Point center(cvRound(circles[i][0]), cvRound(circles[i][1]));
        // 半径
        int radius = cvRound(circles[i][2]);
        
        // 图像上画圆
        // circle center
        circle( src, center, 3, cv::Scalar(0,0,255), -1, 8, 0 );
        // circle outline
        circle( src, center, radius, cv::Scalar(0,255,0), 5, 8, 0 );
        
        
        _center = CGPointMake(center.x, center.y);
        _radius = radius;
    }
    
    // 将 MAT 转换成 UIImage
    _covertImage = MatToUIImage(src);
    
    return true;
}

@end
