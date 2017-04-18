//
//  ConfigureTool.h
//  AVFoundationDemo
//
//  Created by Story5 on 4/12/17.
//  Copyright © 2017 Story5. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ConfigureTool : NSObject

+ (instancetype)shareInstance;

@property (nonatomic,strong,getter=tipDetectFont) UIFont *tipDetectFont;
@property (nonatomic,strong,getter=guideFont) UIFont *guideFont;

@end
