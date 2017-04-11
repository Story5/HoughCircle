//
//  CoinDetectView.h
//  AVFoundationDemo
//
//  Created by Story5 on 4/10/17.
//  Copyright © 2017 Story5. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CoinDetectModel;
@class CoinDetectView;

@protocol CoinDetectViewDelegate <NSObject>

- (void)coinDetectView:(CoinDetectView *)coinDetectView captureFishWithModel:(CoinDetectModel *)model;

@end

@interface CoinDetectView : UIView

@property (nonatomic,strong) id<CoinDetectViewDelegate>delegate;

- (void)startRunning;
- (void)stopRunning;

@end
