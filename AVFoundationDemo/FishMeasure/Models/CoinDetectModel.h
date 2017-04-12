//
//  CoinDetectModel.h
//  AVFoundationDemo
//
//  Created by Story5 on 4/11/17.
//  Copyright © 2017 Story5. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CoinDetectModel : NSObject

- (instancetype)shareInstance;

@property (nonatomic,assign) BOOL detectStatus;
@property (nonatomic,assign) CGPoint circleCenter;
@property (nonatomic,assign) int circleRadius;
@property (nonatomic,strong) UIImage *captureImage;

@end
