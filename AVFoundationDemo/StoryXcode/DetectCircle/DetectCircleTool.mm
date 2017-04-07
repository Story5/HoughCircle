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

+ (BOOL)detectCircleInImage:(UIImage *)image
{
    cv::Mat src;
    UIImageToMat(image, src);
    
    size_t size = [self detectCircle:src];
    if (size > 0) {
        return true;
    }
    return false;
}

+ (size_t)detectCircle:(cv::Mat&)src
{
    cv::Mat src_gray;
    cv::cvtColor( src, src_gray, CV_BGR2GRAY );
    cv::GaussianBlur( src_gray, src_gray, cv::Size(9, 9), 2, 2 );
    std::vector<cv::Vec3f> circles;
    cv::HoughCircles( src_gray, circles, CV_HOUGH_GRADIENT, 1, src_gray.rows/8, 200, 100, 0, 0 );
    //    self.TakePictureButton.enabled = circles.size() > 0 ? YES : NO;
    for( size_t i = 0; i < circles.size(); i++ )
    {
        cv::Point center(cvRound(circles[i][0]), cvRound(circles[i][1]));
        int radius = cvRound(circles[i][2]);
        std::cout << center << std::endl;
        printf("%d",radius);
        // circle center
        circle( src, center, 3, cv::Scalar(0,0,255), -1, 8, 0 );
        // circle outline
        circle( src, center, radius, cv::Scalar(0,255,0), 5, 8, 0 );
    }
    
    UIImage *image = MatToUIImage(src);
    
    return circles.size();
}

@end
