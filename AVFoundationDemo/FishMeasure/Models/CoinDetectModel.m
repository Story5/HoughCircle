//
//  CoinDetectModel.m
//  AVFoundationDemo
//
//  Created by Story5 on 4/11/17.
//  Copyright © 2017 Story5. All rights reserved.
//

#import "CoinDetectModel.h"

@implementation CoinDetectModel

- (void)setDetectStatus:(BOOL)detectStatus
{
    _detectStatus = detectStatus;
    if (_detectStatus == false) {
        _circleCenter = CGPointZero;
        _circleRadius = 0;
        _captureImage = nil;
    }
}

@end
