//
//  STView.h
//  AVFoundationDemo
//
//  Created by 舒通 on 2017/4/10.
//  Copyright © 2017年 Story5. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STView : UIView

@property (nonatomic, assign) CGPoint centerPoint;
@property (nonatomic, assign) CGFloat radius;

- (void)updateframe:(CGRect)frame;

@end
